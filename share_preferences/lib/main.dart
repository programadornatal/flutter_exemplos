import 'package:flutter/material.dart';
import 'pages/login_page.dart';

void main() {
  runApp(
    new MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SharedPreferences',
      home: new LoginPage(),
    );
  }
}