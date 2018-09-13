import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

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
      home: new MyHomePage(title: 'Data e Snackbar'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

DateTime data = DateTime.parse("2018-09-11 15:35:00");

class _MyHomePageState extends State<MyHomePage> {
  String formatada = data.toString();
  var formatyMd = new DateFormat.yMd(); // -> 9/11/2018
  var formatddMMy = new DateFormat("dd/MM/y"); // -> 11/09/2018
  var formatyMMMMd = new DateFormat.yMMMMd(); // -> September 09, 2018
  var formatjm = new DateFormat.jm(); // -> 15:35 PM
  var formataddjm = new DateFormat.yMd().add_jm(); // -> 09/11/2018 15:35 PM
  var formatHm = new DateFormat.Hm();

  _showSnackBar(BuildContext c) {
    // Find the Scaffold in the Widget tree and use it to show a SnackBar!
    Scaffold.of(c).showSnackBar(SnackBar(
      duration: Duration(milliseconds: 500),
      content: Text('Data Alterada!'),
      action: SnackBarAction(
        label: 'DESFAZER',
        onPressed: () {
          setState(() {
            formatada = data.toString();
          });
        },
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Builder(
          builder: (BuildContext context) {
            return new Center(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text(
                    'Data atual\n' + formatada,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.display1,
                  ),
                  new FlatButton(
                    color: Colors.blue,
                    onPressed: () {
                        _showSnackBar(context);
                        setState(() {
                          formatada = formatyMd.format(data);
                        });
                    },
                    child: const Text("Formato yMd",
                        style: TextStyle(color: Colors.white)),
                  ),
                  new FlatButton(
                    color: Colors.blue,
                    onPressed: () {
                      _showSnackBar(context);
                      setState(() {
                        formatada = formatddMMy.format(data);
                      });
                    },
                    child: const Text("Formato yMMdd",
                        style: TextStyle(color: Colors.white)),
                  ),
                  new FlatButton(
                    color: Colors.blue,
                      onPressed: () {
                        _showSnackBar(context);
                        setState(() {
                          formatada = formatyMMMMd.format(data);
                        });
                    },
                    child: const Text("Formato yMMMMd",
                        style: TextStyle(color: Colors.white)),
                  ),
                  new FlatButton(
                    color: Colors.blue,
                      onPressed: () {
                        _showSnackBar(context);
                        setState(() {
                          formatada = formatjm.format(data);
                        });
                    },
                    child: const Text("Formato jm",
                        style: TextStyle(color: Colors.white)),
                  ),
                  new FlatButton(
                    color: Colors.blue,
                      onPressed: () {
                        _showSnackBar(context);
                        setState(() {
                      formatada = formataddjm.format(data);
                      });
                    },
                    child: const Text("Formato addjm",
                        style: TextStyle(color: Colors.white)),
                  ),
                  new FlatButton(
                    color: Colors.blue,
                      onPressed: () {
                        _showSnackBar(context);
                        setState(() {
                          formatada = formatHm.format(data);
                        });
                    },
                    child: const Text("Formato Hm",
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            );
          }
      ),
    );
  }
}
