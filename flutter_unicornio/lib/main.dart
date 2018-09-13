import 'package:flutter/material.dart';
import 'package:unicorndial/unicorndial.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Unicornio Exemplo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
  var childButtons = List<UnicornButton>();

  childButtons.add(UnicornButton(
    hasLabel: true,
    labelText: "Busão",
    currentButton: FloatingActionButton(
    heroTag: "train",
    backgroundColor: Colors.orange,
    mini: true,
    child: Icon(Icons.train),
    onPressed: () {},
  )));

  childButtons.add(UnicornButton(
    currentButton: FloatingActionButton(
    heroTag: "airplane",
    backgroundColor: Colors.blue,
    mini: true,
    child: Icon(Icons.airplanemode_active)
  )));

  childButtons.add(UnicornButton(
    currentButton: FloatingActionButton(
    heroTag: "directions",
    backgroundColor: Colors.red,
    mini: true,
    child: Icon(Icons.directions_car)
  )));

  return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'Toque no botão abaixo:',
            ),
          ],
        ),
      ),
      floatingActionButton: UnicornDialer(
          backgroundColor: Color.fromRGBO(255, 255, 255, 0.6),
          parentButtonBackground: Colors.redAccent,
          orientation: UnicornOrientation.VERTICAL, // HORIZONTAL
          parentButton: Icon(Icons.add),
          childButtons: childButtons),
    );
  }
}
