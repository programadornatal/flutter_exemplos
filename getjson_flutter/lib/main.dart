import 'package:flutter/material.dart';
import 'package:getjson_flutter/pages/detalhes_page.dart';
import 'package:getjson_flutter/pages/home_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Home(),
      routes: {
        '/home': (context) => Home(),
        '/detalhes': (context) => Detalhes()
      },
    );
  }
}