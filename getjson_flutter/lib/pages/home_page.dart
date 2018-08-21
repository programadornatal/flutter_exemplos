import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool carregando = true;
  List<dynamic> retornoJSON;
  initState() {
    super.initState();
    _carregaJSON();
  }
  
  Future<Null> _carregaJSON() async {
    var result = await http.get("https://jsonplaceholder.typicode.com/users");
    String retornoBody = result.body;
    retornoJSON = json.decode(retornoBody);

    if(result.request.finalized) {
      debugPrint(retornoJSON.toString());
    } else {
      _showErro("Ops!","Não foi possivel carregar!");
    }
    setState(() {
      carregando = false;
    });
  }

  _showErro(String titulo, String mensagem) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text(titulo),
            content: new Text(mensagem),
            actions: <Widget>[
              new FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: new Text("OK")
              )
            ],
          );
        }
    );
  }
  
  _qualId(int id) {
    // debugPrint(id.toString());
    Navigator.pushNamed(context, '/detalhes');
  }

  _itemFilhos(String l, String titulo, String subtitulo) {
    return new ListTile(
      leading: new CircleAvatar(
        backgroundColor: Colors.black87,
        child: new Text(l),
      ),
      onTap: () => _qualId(int.parse(l)),
      title: new Text(titulo),
      subtitle: new Text(subtitulo),
    );
  }


  _filhosListView() {
    debugPrint(retornoJSON.length.toString());
    List<Widget> filhos = <Widget>[];
    for (var i in retornoJSON) {
      filhos.add(_itemFilhos(i['id'].toString(), i['name'], i['email']));
    }
    return filhos;
  }

  _carregaLista() {
    return new ListView(
      children: _filhosListView(),
    );
  }

  _controleCarregando() {
    if(carregando) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      return _carregaLista();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("LISTA DE FOTOS"),
      ),
      body: _controleCarregando(),
    );
  }
}
