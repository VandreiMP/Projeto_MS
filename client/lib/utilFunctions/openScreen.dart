import 'dart:js';

import 'package:flutter/widgets.dart';

openScreen(BuildContext context, String route) async {
  await Navigator.of(context).pushNamed(route);
}
