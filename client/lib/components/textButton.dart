import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Function onPress;
  final String label;
  final Color labelColor;
  final Color buttonColor;
  final Color hoverColor;
  final String toolTip;

  Button(this.onPress, this.label, this.labelColor, this.buttonColor,
      this.hoverColor, this.toolTip);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Tooltip(
        message: toolTip,
        child: AnimatedContainer(
          duration: Duration(seconds: 2),
          child: Material(
            color: buttonColor,
            type: MaterialType.button,
            child: InkWell(
              hoverColor: hoverColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  label,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onTap: onPress,
            ),
          ),
        ),
      ),
    );
  }
}
