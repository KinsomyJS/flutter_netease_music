import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class PivotTransition extends AnimatedWidget {
  /// 创建旋转变换
  /// turns不能为空.
  PivotTransition({
    Key key,
    this.alignment: FractionalOffset.topCenter,
    @required Animation<double> turns,
    this.child,
  }) : super(key: key, listenable: turns);

  /// The animation that controls the rotation of the child.
  /// If the current value of the turns animation is v, the child will be
  /// rotated v * 2 * pi radians before being painted.
  Animation<double> get turns => listenable;

  /// The pivot point to rotate around.
  final FractionalOffset alignment;

  /// The widget below this widget in the tree.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final double turnsValue = turns.value;
    final Matrix4 transform = new Matrix4.rotationZ(turnsValue * pi * 2.0);
    return new Transform(
      transform: transform,
      alignment: alignment,
      child: child,
    );
  }
}

class AnimatedNeedle extends AnimatedWidget {
  AnimatedNeedle({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return new Container(
      height: 300.0,
      width: 100.0,
      child: new PivotTransition(
          turns: animation,
          alignment: FractionalOffset.topCenter,
          child: new Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage("images/play_needle.png"),
              ),
            ),
          )),
    );
  }
}
