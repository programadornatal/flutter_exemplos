import 'package:flutter/material.dart';

class fragmentoOne extends StatefulWidget {
  @override
  _fragmentoOneState createState() => _fragmentoOneState();
}

class _fragmentoOneState extends State<fragmentoOne> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Center(
        child: new Text("Fragmento 1"),
      )
    );
  }
}
