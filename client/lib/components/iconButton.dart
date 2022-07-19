import 'package:flutter/material.dart';

class ButtonIcon extends StatelessWidget {
  final Function onTap;
  final String toolTip;
  final IconData icon;
  final double iconSize;
  final Color colorIcon;
  final Color colorButton;
  final double height;
  final bool enabled;

  const ButtonIcon(this.onTap, this.toolTip, this.icon, this.iconSize,
      this.colorIcon, this.enabled, this.height, this.colorButton);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: enabled
          ? Tooltip(
              message: toolTip,
              child: AnimatedContainer(
                height: height,
                duration: Duration(seconds: 2),
                child: Material(
                  color: colorButton,
                  child: InkWell(
                    onTap: onTap,
                    child: Icon(
                      icon,
                      size: iconSize,
                      color: colorIcon,
                    ),
                  ),
                ),
              ),
            )
          : Container(
              child: Icon(
                icon,
                size: iconSize,
                color: Colors.grey,
              ),
            ),
    );
  }
}
