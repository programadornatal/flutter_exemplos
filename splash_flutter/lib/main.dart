import 'package:flutter/material.dart';
import 'package:splash_flutter/pages/splash_page.dart';
import 'package:splash_flutter/pages/home_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const colorTheme = Colors.blue;
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
          primaryColor: colorTheme
      ),
      home: new SplashScreen(colorTheme),
      routes: {
        '/homepage': (context) => HomePage(),
      },
    );
  }
}
