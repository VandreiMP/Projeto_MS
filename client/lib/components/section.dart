import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Section extends StatelessWidget {
  final Widget fields;
  final double height;
  const Section(this.fields, this.height);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(2)),
          border: new Border.all(
            color: Colors.grey[300],
          ),
        ),
        child: fields,
      ),
    );
  }
}
