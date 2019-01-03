//import 'dart:ui';
//import 'dart:math';
//import 'package:flutter/material.dart';
//
///// Animates the rotation of a widget around a pivot point.
//class PivotTransition extends AnimatedWidget {
//  /// Creates a rotation transition.
//  ///
//  /// The [turns] argument must not be null.
//  PivotTransition({
//    Key key,
//    this.alignment: FractionalOffset.center,
//    @required Animation<double> turns,
//    this.child,
//  }) : super(key: key, listenable: turns);
//
//  /// The animation that controls the rotation of the child.
//  ///
//  /// If the current value of the turns animation is v, the child will be
//  /// rotated v * 2 * pi radians before being painted.
//  Animation<double> get turns => listenable;
//
//  /// The pivot point to rotate around.
//  final FractionalOffset alignment;
//
//  /// The widget below this widget in the tree.
//  final Widget child;
//
//  @override
//  Widget build(BuildContext context) {
//    final double turnsValue = turns.value;
//    final Matrix4 transform = new Matrix4.rotationZ(turnsValue * pi * 2.0);
//    return new Transform(
//      transform: transform,
//      alignment: alignment,
//      child: child,
//    );
//  }
//}
//
//class RotateDemo extends StatefulWidget {
//  State createState() => new RotateDemoState();
//}
//
//class RotateDemoState extends State<RotateDemo> with TickerProviderStateMixin {
//  AnimationController _animationController;
//
//  @override
//  initState() {
//    super.initState();
//    _animationController = new AnimationController(
//      duration: const Duration(milliseconds: 3000),
//      vsync: this,
//    )..repeat();
//  }
//
//  @override
//  dispose() {
//    _animationController.dispose();
//    super.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//      body: new Center(
//        child: new PivotTransition(
//          turns: _animationController,
//          alignment: FractionalOffset.bottomRight,
//          child: new Container(
//            decoration: new BoxDecoration(color: Colors.grey.shade200),
//            width: 100.0,
//            child: new FlutterLogo(style: FlutterLogoStyle.horizontal),
//          ),
//        ),
//      ),
//    );
//  }
//}
