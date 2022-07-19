import 'dart:convert';
import 'package:cliente_flutter/api/accountApi.dart';
import 'package:cliente_flutter/components/actionFormField.dart';
import 'package:cliente_flutter/components/alert.dart';
import 'package:cliente_flutter/utilFunctions/consultaContaBancaria.dart';
import 'package:http/http.dart';
import 'package:cliente_flutter/api/loginApi.dart';
import 'package:cliente_flutter/api/transactionApi.dart';
import 'package:cliente_flutter/components/section.dart';
import 'package:cliente_flutter/components/simpleFormField.dart';
import 'package:cliente_flutter/components/textButton.dart';
import 'package:cliente_flutter/components/waitingScreen.dart';
import 'package:cliente_flutter/constants/masks.dart';
import 'package:cliente_flutter/screens/screenPattern.dart';
import 'package:cliente_flutter/utilFunctions/closeScreen.dart';
import 'package:cliente_flutter/utilFunctions/openScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class Expense extends StatefulWidget {
  @override
  State<Expense> createState() => _ExpenseState();
}

class _ExpenseState extends State<Expense> {
  final tSeqExpense = TextEditingController();
  final tDsBankAccount = TextEditingController();
  final tBank = TextEditingController();
  final tBankCode = TextEditingController();
  final tValue = TextEditingController();
  final tDateTransaction = MaskedTextController(mask: mascaraData);

  @override
  Widget build(BuildContext context) {
    return ScreenPattern(
      child: Section(
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Despesas',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ActionFormField(
                            controller: tBank,
                            enabled: true,
                            fontSize: 14,
                            fontSizeLabel: 14,
                            height: 30,
                            onChanged: (String valor) async {
                              tDsBankAccount.text = await consultaContaBancaria(
                                  context, tBank.text);
                            },
                            hideField: false,
                            label: 'Conta Bancária',
                            lines: 1,
                            width: 100,
                          ),
                          SimpleFormField(
                            controller: tDsBankAccount,
                            enabled: false,
                            fontSize: 14,
                            fontSizeLabel: 14,
                            height: 30,
                            hideField: false,
                            label: '',
                            lines: 1,
                            width: 250,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SimpleFormField(
                            controller: tValue,
                            enabled: true,
                            fontSize: 14,
                            fontSizeLabel: 14,
                            height: 30,
                            hideField: false,
                            label: 'Valor',
                            lines: 1,
                            width: 150,
                          ),
                          SimpleFormField(
                            controller: tDateTransaction,
                            enabled: true,
                            fontSize: 14,
                            fontSizeLabel: 14,
                            height: 30,
                            hideField: false,
                            label: 'Data/Hora',
                            lines: 1,
                            width: 150,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Button(
                    () async {
                      await openScreen(context, '/HomePage');
                    },
                    'Home',
                    Colors.white,
                    Colors.black,
                    Colors.blueGrey,
                    'Retorna à home page',
                  ),
                  Button(
                    () async {
                      await closeScreen(context, 1);
                    },
                    'Retornar',
                    Colors.white,
                    Colors.black,
                    Colors.blueGrey,
                    'Retorna à tela anterior',
                  ),
                  Button(
                    () async {
                      Navigator.of(context).push(PageRouteBuilder(
                        opaque: false,
                        transitionDuration: Duration(milliseconds: 1),
                        pageBuilder: (_, __, ___) =>
                            WaitingScreen('Salvando registro...'),
                      ));
                      TransactionApi api = TransactionApi();
                      Response returnRequest = await api.postRequest(
                        {
                          'sequencial': null,
                          'codigoConta': tBank.text,
                          'valor': tValue.text,
                          'data': tDateTransaction.text,
                          'origem': 'D'
                        },
                      );
                      closeScreen(context, 1);
                      if (jsonDecode(returnRequest.body)['sequencial']
                                  .toString() !=
                              null ||
                          jsonDecode(returnRequest.body)['sequencial']
                                  .toString() !=
                              '' ||
                          jsonDecode(returnRequest.body)['sequencial']
                              .toString()
                              .isNotEmpty) {
                        tSeqExpense.text =
                            jsonDecode(returnRequest.body)['sequencial']
                                .toString();
                      } else {
                        tSeqExpense.text = '';
                      }
                      tSeqExpense.text = '';
                      alert(
                          context,
                          'Sucesso',
                          jsonDecode(returnRequest.body)['mensagem'].toString(),
                          'SUCESSO');
                      tSeqExpense.text = '';
                      tBank.text = '';
                      tValue.text = '';
                      tDateTransaction.text = '';
                      tDsBankAccount.text = '';
                    },
                    'Salvar',
                    Colors.white,
                    Colors.black,
                    Colors.blueGrey,
                    'Salva os dados do formulário',
                  ),
                ],
              ),
            ],
          ),
          300),
    );
  }
}
