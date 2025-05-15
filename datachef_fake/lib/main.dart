import 'package:flutter/material.dart';
import 'pages/start.dart'; // 상대 경로 사용

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '건강 관리 앱',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Noto Sans KR',
      ),
      home: const StartPage(),
    );
  }
}
