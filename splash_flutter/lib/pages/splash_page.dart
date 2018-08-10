import 'package:flutter/material.dart';
import 'dart:async';
var color;

class SplashScreen extends StatefulWidget {

  SplashScreen(MaterialColor colorTheme){
    color = colorTheme;
  }

  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {

  AnimationController controller;
  Animation<double> animation;

  startTime() async {
    var _duration = new Duration(seconds: 4);
    return new Timer(_duration, navigationPage);
  }

  @override
  void initState() {
    super.initState();
    startTime();

    controller = AnimationController(
        duration: const Duration(milliseconds: 4000), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
    controller.forward();
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/homepage');
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedLogo(animation: animation);
  }
}

class AnimatedLogo extends AnimatedWidget {
  static final _opacityTween = Tween<double>(begin: 0.1, end: 1.0);
  AnimatedLogo({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    var stilo = new TextStyle(
        color: Colors.white,
        fontSize: 28.0,
        fontWeight: FontWeight.bold
    );
    return Center(
      child: Opacity(
        opacity: _opacityTween.evaluate(animation),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10.0),
          child: new Scaffold(
              backgroundColor: color,
              body: new Center(
              child: new Text(
              'Tela Splash',
              style: stilo,
              ),
            ),
          ),
        ),
      )
    );
  }
}