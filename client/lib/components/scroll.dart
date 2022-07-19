import 'package:flutter/material.dart';

class Scroll extends StatelessWidget {
  const Scroll(
      {this.child,
      this.width,
      this.height,
      this.color,
      this.alignment,
      this.padding});

  final Widget child;
  final double width;
  final double height;
  final Color color;
  final Alignment alignment;
  final EdgeInsets padding;

  Widget build(BuildContext context) {
    double width2;
    double height2;

    if (width == null) {
      width2 = null;
    } else {
      width2 = width;
    }
    if (height == null) {
      height2 = null;
    } else {
      height2 = height;
    }

    return Container(
      alignment: alignment,
      padding: padding,
      width: width2,
      height: height2,
      color: color,
      child: SingleChildScrollView(
        // scrollDirection: Axis.horizontal,
        primary: true,
        child: child,
      ),
    );
  }
}
