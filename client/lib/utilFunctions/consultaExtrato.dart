import 'dart:convert';

import 'package:cliente_flutter/api/transactionApi.dart';
import 'package:cliente_flutter/components/alert.dart';
import 'package:cliente_flutter/components/waitingScreen.dart';
import 'package:cliente_flutter/utilFunctions/closeScreen.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';

Future<String> consultaExtrato(BuildContext context, String idConta) async {
  var extract;
  Navigator.of(context).push(PageRouteBuilder(
    opaque: false,
    transitionDuration: Duration(milliseconds: 1),
    pageBuilder: (_, __, ___) => WaitingScreen('Consultando extrato...'),
  ));
  TransactionApi api = TransactionApi();
  Response returnRequest = await api.getRequest(
    {
      'codigoConta': idConta,
    },
  );
  closeScreen(context, 1);
  if (idConta.isEmpty) {
    alert(context, 'Atenção', 'Conta bancária não informada!', 'ALERTA');
  } else {
    if (returnRequest.body.isNotEmpty) {
      extract = jsonDecode(returnRequest.body)['extrato'];
    } else {
      alert(context, 'Atenção',
          'A conta bancária não possui transações registradas!', 'ALERTA');
    }
  }
  return extract;
}
