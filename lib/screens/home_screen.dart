import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  // ログイン画面から「誰がログインしたか」を受け取る準備
  // ※今はまだ受け取っていないので、下のコードで "test-user" に固定しています
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ★重要：今回はテスト用にIDを固定します
  // 本番ではログイン画面から「embedded-05」などを受け取ります
  final String userId = "test-user"; 
  final String weekId = "2026-02-09";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('来週の予約 (2/9週)'),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      // 【1】まず「メニュー」を読み込む
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('weeks')
            .doc(weekId)
            .snapshots(),
        builder: (context, menuSnapshot) {
          if (menuSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!menuSnapshot.hasData || !menuSnapshot.data!.exists) {
            return const Center(child: Text("メニューデータがありません"));
          }

          // メニューデータの取り出し
          Map<String, dynamic> menuData = menuSnapshot.data!.data() as Map<String, dynamic>;

          // 【2】次に「自分の注文」を読み込む（入れ子にします）
          return StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('orders')
                .doc('${weekId}_$userId') // "2026-02-09_test-user" というIDで探す
                .snapshots(),
            builder: (context, orderSnapshot) {
              // 注文データがまだなくてもエラーにしない（空のMapを使う）
              Map<String, dynamic> orderData = {};
              if (orderSnapshot.hasData && orderSnapshot.data!.exists) {
                orderData = orderSnapshot.data!.data() as Map<String, dynamic>;
              }

              // 月〜金のリストを作る
              List<Map<String, dynamic>> days = [
                {"date": "2/9 (月)", "key": "mon"},
                {"date": "2/10 (火)", "key": "tue"},
                {"date": "2/11 (水)", "key": "wed", "isHoliday": true}, // 水曜固定休み（仮）
                {"date": "2/12 (木)", "key": "thu"},
                {"date": "2/13 (金)", "key": "fri"},
              ];

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: days.length,
                itemBuilder: (context, index) {
                  final day = days[index];
                  final key = day['key'];

                  // メニュー情報の取得
                  String menuName = menuData['${key}_menu'] ?? '未定';
                  String shopName = menuData['${key}_shop'] ?? '-';
                  
                  // 休み判定（データ上のフラグがあればそれも考慮）
                  bool isHoliday = day['isHoliday'] == true || menuName == '未定';

                  // ★ここがポイント！注文情報の取得
                  // データベースに "mon": true と書いてあればONになる
                  bool isOrdered = orderData[key] == true;

                  return Card(
                    color: isHoliday ? Colors.grey[200] : Colors.white,
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          // 日付・店名
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(day['date'], style: const TextStyle(fontWeight: FontWeight.bold)),
                                if (!isHoliday)
                                  Container(
                                    margin: const EdgeInsets.only(top: 4),
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    color: Colors.orange[100],
                                    child: Text(shopName, style: const TextStyle(fontSize: 12)),
                                  ),
                              ],
                            ),
                          ),
                          // メニュー名
                          Expanded(
                            flex: 3,
                            child: Text(
                              isHoliday ? "お休み" : menuName,
                              style: TextStyle(
                                fontSize: 16,
                                color: isHoliday ? Colors.grey : 
                                       (isOrdered ? Colors.orange[800] : Colors.black),
                                fontWeight: isOrdered ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ),
                          // スイッチ（注文操作）
                          if (!isHoliday)
                            Switch(
                              value: isOrdered,
                              activeColor: Colors.orange,
                              onChanged: (bool newValue) {
                                // ★ここが「書き込み」回路
                                // データベースの該当箇所を更新する
                                FirebaseFirestore.instance
                                    .collection('orders')
                                    .doc('${weekId}_$userId')
                                    .set({
                                      key: newValue // 例: "mon": true
                                    }, SetOptions(merge: true)); // merge:true は「上書きせずに追加」
                              },
                            )
                          else
                            const Text("-"),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}