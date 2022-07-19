import 'dart:convert';
import 'dart:io';
import 'package:cliente_flutter/screens/accountBank.dart';
import 'package:cliente_flutter/screens/expenses.dart';
import 'package:cliente_flutter/screens/extract.dart';
import 'package:cliente_flutter/screens/homePage.dart';
import 'package:cliente_flutter/screens/login.dart';
import 'package:cliente_flutter/screens/revenues.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:cliente_flutter/screens/user.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Banking',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [const Locale('pt', 'BR'), const Locale('pt')],
      initialRoute: '/Login',
      routes: {
        '/Login': (context) => Login(),
        '/User': (context) => User(),
        '/HomePage': (context) => HomePage(),
        '/AccountBank': (context) => AccountBank(),
        '/Revenue': (context) => Revenue(),
        '/Expense': (context) => Expense(),
        '/Extract': (context) => Extract()
      },
    );
  }
}
