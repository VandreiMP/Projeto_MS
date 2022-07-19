import 'package:flutter/widgets.dart';

closeScreen(BuildContext context, int numberScrens) async {
  for (int count = 1; count <= numberScrens; count++) {
    await Navigator.of(context).pop();
  }
}
