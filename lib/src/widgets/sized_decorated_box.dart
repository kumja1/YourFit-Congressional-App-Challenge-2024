import 'package:flutter/material.dart';

class SizedDecoratedBox extends StatelessWidget {
  final double width;

  final double height;

  final Widget child ;

  final Decoration decoration;

  SizedDecoratedBox(
      {required this.width,
      required this.height,
      required this.decoration,
      required this.child,});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child:SizedBox(
      width: width,
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(),
        child: child,
      ),
    ));
  }
}
