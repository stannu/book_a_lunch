import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // 追加
import 'screens/login_screen.dart';

void main() async {
  // Firebaseを使うためのおまじない
  WidgetsFlutterBinding.ensureInitialized();

  // ▼▼ Step 3で取得したキーをここにコピペしてください ▼▼
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyACrjvNDXlSzdyiQeqAA8ZY42fGgnBDEjk",
        authDomain: "book-a-lunch.firebaseapp.com",
        projectId: "book-a-lunch",
        storageBucket: "book-a-lunch.firebasestorage.app",
        messagingSenderId: "355740782062",
        appId: "1:355740782062:web:84948267a57905d3ef92ff"
    ),
  );
  // ▲▲ コピペここまで ▲▲

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'お弁当予約',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
        fontFamilyFallback: const ["Noto Sans JP", "Hiragino Sans", "Meiryo"],
      ),
      home: const LoginScreen(),
    );
  }
}