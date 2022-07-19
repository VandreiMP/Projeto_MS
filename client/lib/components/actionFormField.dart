import 'package:flutter/material.dart';

class ActionFormField extends StatelessWidget {
  final String label;
  final double width;
  final double height;
  final bool enabled;
  final bool required;
  final TextEditingController mask;
  final TextEditingController controller;
  final int lines;
  final bool hideField;
  final Function onChanged;
  final double fontSize;
  final double fontSizeLabel;

  const ActionFormField({
    this.label,
    this.width,
    this.height,
    this.enabled,
    this.required,
    this.mask,
    this.onChanged,
    this.controller,
    this.lines,
    this.hideField,
    this.fontSize,
    this.fontSizeLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 4.0,
        bottom: 8.0,
        right: 8.0,
      ),
      child: Container(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    label,
                    style: TextStyle(
                      fontFamily: 'Cardo',
                      fontSize: fontSizeLabel,
                      decoration: TextDecoration.underline,
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(0)),
                        border: new Border.all(
                          color: Colors.grey[300],
                        ),
                      ),
                      height: height,
                      width: width ?? double.maxFinite,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          obscureText: hideField,
                          onFieldSubmitted: onChanged,
                          maxLines: lines,
                          enabled: enabled,
                          controller: controller,
                          decoration: new InputDecoration(
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                            fontFamily: 'Cardo',
                            fontSize: fontSize,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
