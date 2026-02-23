import 'admin_screen.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // 入力された値を管理する変数
  final _classController = TextEditingController();
  final _numberController = TextEditingController();
  final _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('お弁当予約 ログイン'),
        backgroundColor: Colors.orange, // お弁当っぽい色
      ),
      body: Center(
        child: Container(
          width: 400, // Webで見やすいように幅を制限
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'ログインしてください',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              
              // クラス名入力
              TextField(
                controller: _classController,
                decoration: const InputDecoration(
                  labelText: 'クラス名 (例: Embedded)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // 出席番号入力
              TextField(
                controller: _numberController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: '出席番号 (例: 05)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // パスワード入力
              TextField(
                controller: _passController,
                obscureText: true, // 文字を隠す
                decoration: const InputDecoration(
                  labelText: 'パスワード',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30),

              // ログインボタン
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                   // ▼▼ ここから変更 ▼▼
                    // 画面遷移のコード
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('ログイン', style: TextStyle(fontSize: 18)),
                ),
              ),
              // ...ログインボタンのコードの後...
              
              const SizedBox(height: 40),
              
              // 管理者画面へのデバッグ用リンク
              TextButton(
                onPressed: () {
                   Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AdminScreen()),
                    );
                },
                child: const Text(
                  "管理者はこちら",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}