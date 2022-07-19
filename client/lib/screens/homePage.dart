import 'dart:convert';

import 'package:cliente_flutter/api/transactionApi.dart';
import 'package:cliente_flutter/components/iconButton.dart';
import 'package:cliente_flutter/components/section.dart';
import 'package:cliente_flutter/components/simpleFormField.dart';
import 'package:cliente_flutter/components/textButton.dart';
import 'package:cliente_flutter/constants/masks.dart';
import 'package:cliente_flutter/screens/screenPattern.dart';
import 'package:cliente_flutter/utilFunctions/openScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final tTotalReceitas = TextEditingController();
  final tTotalDespesas = TextEditingController();
  final tSaldoGeral = TextEditingController();

  consultaSaldos() async {
    TransactionApi api = TransactionApi();
    Response response = await api.getRequest({"codigoConta": null});
    tTotalReceitas.text = jsonDecode(response.body)['ganhos'];
    tTotalDespesas.text = jsonDecode(response.body)['despesas'];
    tSaldoGeral.text = jsonDecode(response.body)['saldoGeral'].toString();
  }

  @override
  Widget build(BuildContext context) {
    consultaSaldos();
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SimpleFormField(
                  controller: tTotalReceitas,
                  enabled: false,
                  fontSize: 14,
                  fontSizeLabel: 14,
                  height: 30,
                  hideField: false,
                  label: 'Receitas',
                  lines: 1,
                  width: 150,
                ),
                SimpleFormField(
                  controller: tTotalDespesas,
                  enabled: false,
                  fontSize: 14,
                  fontSizeLabel: 14,
                  height: 30,
                  hideField: false,
                  label: 'Despesas',
                  lines: 1,
                  width: 150,
                ),
                SimpleFormField(
                  controller: tSaldoGeral,
                  enabled: false,
                  fontSize: 14,
                  fontSizeLabel: 14,
                  height: 30,
                  hideField: false,
                  label: 'Saldo',
                  lines: 1,
                  width: 150,
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ButtonIcon(
                    () async {
                      await openScreen(context, '/Revenue');
                    },
                    'Receitas',
                    Icons.attach_money,
                    200,
                    Colors.white,
                    true,
                    200,
                    Colors.green,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ButtonIcon(
                    () async {
                      await openScreen(context, '/Expense');
                    },
                    'Despesas',
                    Icons.attach_money,
                    200,
                    Colors.white,
                    true,
                    200,
                    Colors.red,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ButtonIcon(
                    () async {
                      await openScreen(context, '/Extract');
                    },
                    'Transações',
                    Icons.list,
                    200,
                    Colors.white,
                    true,
                    200,
                    Colors.blue[900],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ButtonIcon(
                    () async {
                      await openScreen(context, '/User');
                    },
                    'Usuário',
                    Icons.paste,
                    200,
                    Colors.white,
                    true,
                    200,
                    Colors.yellow[700],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ButtonIcon(
                    () async {
                      await openScreen(context, '/AccountBank');
                    },
                    'Conta',
                    Icons.cases_outlined,
                    200,
                    Colors.white,
                    true,
                    200,
                    Colors.deepOrange,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
