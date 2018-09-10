import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();

  bool checkValue = false;

  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    getCredential();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: null,
      body: new SingleChildScrollView(
        child: _body(),
        scrollDirection: Axis.vertical,
      ),
    );
  }

  Widget _body() {
    return new Container(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Container(
            child: new Image.asset(
              "images/android.jpg",
            ),
          ),
          new Container(
            padding: const EdgeInsets.only(
              left: 20.0, top: 10.0, right: 20.0
            ),
            child: new Column(
              children: <Widget>[
                new TextField(
                  controller: username,
                  decoration: InputDecoration(
                      hintText: "username",
                      hintStyle: new TextStyle(color: Colors.grey.withOpacity(0.3))),
                ),
                new TextField(
                    controller: password,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "password",
                        hintStyle:
                        new TextStyle(color: Colors.grey.withOpacity(0.3)))),
                new CheckboxListTile(
                  value: checkValue,
                  onChanged: _onChanged,
                  title: new Text("Lembrar acesso"),
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                new Container(
                  decoration:
                  new BoxDecoration(border: Border.all(color: Colors.black)),
                  child: new ListTile(
                    title: new Text(
                      "Login",
                      textAlign: TextAlign.center,
                    ),
                    onTap: _navigator,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  _onChanged(bool value) async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      checkValue = value;
      sharedPreferences.setBool("check", checkValue);
      sharedPreferences.setString("username", username.text);
      sharedPreferences.setString("password", password.text);
      sharedPreferences.commit();
      getCredential();
    });
  }

  getCredential() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      checkValue = sharedPreferences.getBool("check");
      if (checkValue != null) {
        if (checkValue) {
          username.text = sharedPreferences.getString("username");
          password.text = sharedPreferences.getString("password");
        } else {
          username.clear();
          password.clear();
          sharedPreferences.clear();
        }
      } else {
        checkValue = false;
      }
    });
  }

  _navigator() {
    if (username.text.length != 0 || password.text.length != 0) {
      Navigator.of(context).pushAndRemoveUntil(
          new MaterialPageRoute(
              builder: (BuildContext context) => new HomeScreen()),
              (Route<dynamic> route) => false);
    } else {
      showDialog(
          context: context,
          barrierDismissible: false,
          child: new CupertinoAlertDialog(
            content: new Text(
              "Usuario e senha \nsão obrigatórios",
              style: new TextStyle(fontSize: 16.0),
            ),
            actions: <Widget>[
              new FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: new Text("OK"))
            ],
          ));
    }
  }
}