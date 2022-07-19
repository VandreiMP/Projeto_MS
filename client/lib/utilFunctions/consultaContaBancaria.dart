import 'dart:convert';

import 'package:cliente_flutter/components/alert.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:cliente_flutter/api/accountApi.dart';

Future<String> consultaContaBancaria(
    BuildContext context, String idConta) async {
  AccountApi api = AccountApi();

  var dsConta;

  Response returnRequest = await api.getRequest({
    'codigoConta': idConta,
  });
  if (returnRequest.body.isEmpty) {
    dsConta = '';
    alert(context, 'Atenção', 'Conta bancária não cadastrada!', 'ALERTA');
  } else {
    dsConta = await jsonDecode(returnRequest.body)['nomeBanco'] +
        '-' +
        jsonDecode(returnRequest.body)['agencia'] +
        '/' +
        jsonDecode(returnRequest.body)['conta'];
  }
  return dsConta;
}
