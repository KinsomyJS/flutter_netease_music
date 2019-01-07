import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class RotateRecord extends AnimatedWidget {
  RotateRecord({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return new Container(
      margin: new EdgeInsets.symmetric(vertical: 10.0),
      height: 250.0,
      width: 250.0,
      child: new RotationTransition(
          turns: animation,
          child: new Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(
                    "https://images-na.ssl-images-amazon.com/images/I/51inO4DBH0L._SS500.jpg"),
              ),
            ),
          )),
    );
  }
}
