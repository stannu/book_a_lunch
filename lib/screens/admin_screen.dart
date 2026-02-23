import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // クリップボード用

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  // ダミーの集計データ（実際はデータベースから「全員分の注文」を集計して表示します）
  final List<Map<String, dynamic>> _summaryData = [
    {"date": "2/9 (月)", "shop": "店舗A", "menu": "唐揚げ弁当", "count": 15},
    {"date": "2/10 (火)", "shop": "店舗B", "menu": "酢豚弁当", "count": 23},
    {"date": "2/11 (水)", "shop": "-", "menu": "建国記念の日", "count": 0},
    {"date": "2/12 (木)", "shop": "店舗C", "menu": "サバの味噌煮", "count": 18},
    {"date": "2/13 (金)", "shop": "店舗A", "menu": "ミックスフライ", "count": 20},
  ];

  @override
  Widget build(BuildContext context) {
    // 合計注文数を計算
    int totalOrders = _summaryData.fold(0, (sum, item) => sum + (item["count"] as int));

    return Scaffold(
      appBar: AppBar(
        title: const Text('管理者ダッシュボード'),
        backgroundColor: Colors.blueGrey, // 管理者っぽい色
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "来週の発注集計 (2/9週)",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "合計注文数: $totalOrders 食",
              style: const TextStyle(fontSize: 18, color: Colors.blueGrey),
            ),
            const SizedBox(height: 24),

            // 集計テーブル
            Expanded(
              child: Card(
                child: ListView.separated(
                  itemCount: _summaryData.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    final data = _summaryData[index];
                    final isHoliday = data["count"] == 0;

                    return ListTile(
                      // 左側：日付
                      leading: CircleAvatar(
                        backgroundColor: isHoliday ? Colors.grey[200] : Colors.blue[100],
                        child: Text(
                          data["date"].substring(0, 3), // "2/9" だけ表示
                          style: TextStyle(
                              fontSize: 12,
                              color: isHoliday ? Colors.grey : Colors.blue[900]),
                        ),
                      ),
                      // 真ん中：店舗とメニュー
                      title: Text(data["menu"], 
                          style: TextStyle(fontWeight: FontWeight.bold, color: isHoliday ? Colors.grey : Colors.black)),
                      subtitle: Text(data["shop"]),
                      
                      // 右側：注文数（ここが重要！）
                      trailing: isHoliday 
                        ? const Text("-")
                        : Text(
                            "${data["count"]}個",
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                          ),
                    );
                  },
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // アクションボタンエリア
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // 報告用テキストを作成
                      String report = "【来週の発注書】\n";
                      for (var item in _summaryData) {
                        if (item["count"] > 0) {
                          report += "${item["date"]} (${item["shop"]}): ${item["count"]}個\n";
                        }
                      }
                      
                      // クリップボードにコピー
                      Clipboard.setData(ClipboardData(text: report));
                      
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('発注用テキストをコピーしました！')),
                      );
                    },
                    icon: const Icon(Icons.copy),
                    label: const Text("発注内容をコピー"),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.blueGrey,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}