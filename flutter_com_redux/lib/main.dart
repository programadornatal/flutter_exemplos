import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

enum Actions { Increment, Decrement }
int counterReducer(int state, dynamic action) {
  switch(action) {
    case Actions.Increment:
      return state + 1;
    case Actions.Decrement:
      return state - 1;
    default: return state;
  }
}

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  final store = new Store<int>(counterReducer, initialState: 0);
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new StoreProvider(
          store: store,
          child: new MyHomePage(title: 'Flutter com Redux')),
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
  int _selected = 0;

  final List<Widget> _children = [
    Home(),
    TrocadeTela(Colors.green),
  ];

  _itemBarSelect(int item) {
    setState(() {
      _selected = item;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: _children[_selected],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: new StoreConnector<int, VoidCallback>(
          builder: (context, callback) => new FloatingActionButton(
            onPressed: callback,
            tooltip: 'Increment',
            child: new Icon(Icons.add),
          ),
          converter: (store) {
            return () => store.dispatch(Actions.Increment);
          }
      ),
      bottomNavigationBar: new BottomNavigationBar(
          currentIndex: _selected,
          onTap: _itemBarSelect, // pode ser também (item) => _itemBarSelect(item)
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: new Text("HOME"),
            ),
            BottomNavigationBarItem(
                icon: new Icon(Icons.speaker_notes),
                title: new Text("VALOR")
            ),
          ] ,
      ),
    );
  }
}

class TrocadeTela extends StatelessWidget {
  final Color color;
  TrocadeTela(this.color);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      width: double.maxFinite,
      height: double.maxFinite,
      child: new Column(
          children: <Widget>[
            new StoreConnector<int, String>
              (
                builder: (context, count) => new Text(
                    count,
                    style: Theme.of(context).textTheme.display1
                ),
                converter: (store) => store.state.toString()
            )
          ],
        ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text(
              'Cliques no botão:',
              style: TextStyle(fontSize: 20.0)
          ),
          new StoreConnector<int, VoidCallback>(
            builder: (context, callback) => new RaisedButton(
                onPressed: callback,
                child: new Text("Menos"),
            ),
            converter: (store) {
              return () => store.dispatch(Actions.Decrement);
            }
          ),
          new StoreConnector<int, String>
            (
              builder: (context, count) => new Text(
                  count,
                  style: Theme.of(context).textTheme.display1
              ),
              converter: (store) => store.state.toString()
          )
        ],
      ),
    );
  }
}


