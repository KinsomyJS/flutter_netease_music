import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_netease_music/anims/needle_animated.dart';
import 'package:flutter_netease_music/anims/test.dart';

class RotateRecord extends AnimatedWidget {
  RotateRecord({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return new Container(
      margin: new EdgeInsets.symmetric(vertical: 10.0),
      height: 300.0,
      width: 300.0,
      child: new RotationTransition(
          turns: animation,
          child: new Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(
                    "https://images.rapgenius.com/4xo4vvlzcnbsluagktti85tf1.1000x1000x1.jpg"),
              ),
            ),
          )),
    );
  }
}

class RotateLogoApp extends StatefulWidget {
  _RotateLogoAppState createState() => new _RotateLogoAppState();
}

class _RotateLogoAppState extends State<RotateLogoApp>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  Animation<double> animation_needle;
  AnimationController controller_needle;
  final _rotateTween = new Tween<double>(begin: -0.15, end: 0.0);
  final _commonTween = new Tween<double>(begin: 0.0, end: 1.0);
  bool _playing = false;

  initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 15000), vsync: this);
    animation = new CurvedAnimation(parent: controller, curve: Curves.linear);

    controller_needle = new AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    animation_needle =
        new CurvedAnimation(parent: controller_needle, curve: Curves.linear);

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.repeat();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Column(
        children: <Widget>[
          new Stack(
            alignment: const FractionalOffset(0.6, 0.1), //方法一
            children: <Widget>[
              new Container(
                child:
                    RotateRecord(animation: _commonTween.animate(controller)),
                margin: EdgeInsets.only(top: 120.0),
              ),
              new Container(
                child: new PivotTransition(
                  turns: _rotateTween.animate(controller_needle),
                  alignment: FractionalOffset.topLeft,
                  child: new Container(
                    width: 100.0,
                    child: new Image.asset("images/play_needle.png"),
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: RaisedButton(
              onPressed: () {
                setState(() {
                  _playing = !_playing;
                  if (_playing) {
                    controller.forward();
//                    controller.repeat();
                    controller_needle.forward();
                  } else {
                    controller.stop(canceled: false);
                    controller_needle.reverse();
                  }
                });
              },
              child: new Text(_playing ? "pause" : "play"),
            ),
          )
        ],
      ),
    );
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}
