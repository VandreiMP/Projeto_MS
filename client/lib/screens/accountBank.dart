import 'dart:convert';

import 'package:cliente_flutter/api/accountApi.dart';
import 'package:cliente_flutter/api/loginApi.dart';
import 'package:cliente_flutter/components/alert.dart';
import 'package:cliente_flutter/components/waitingScreen.dart';
import 'package:http/http.dart';
import 'package:cliente_flutter/components/iconButton.dart';
import 'package:cliente_flutter/components/section.dart';
import 'package:cliente_flutter/components/simpleFormField.dart';
import 'package:cliente_flutter/components/textButton.dart';
import 'package:cliente_flutter/constants/masks.dart';
import 'package:cliente_flutter/screens/screenPattern.dart';
import 'package:cliente_flutter/utilFunctions/closeScreen.dart';
import 'package:cliente_flutter/utilFunctions/openScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class AccountBank extends StatefulWidget {
  @override
  State<AccountBank> createState() => _AccountBankState();
}

class _AccountBankState extends State<AccountBank> {
  final tIdAccountBank = TextEditingController();
  final tBank = TextEditingController();
  final tBankName = TextEditingController();
  final tAgency = TextEditingController();
  final tAccount = TextEditingController();

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
                      'Cadastro de Conta Bancária',
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
                          SimpleFormField(
                            controller: tIdAccountBank,
                            enabled: false,
                            fontSize: 14,
                            fontSizeLabel: 14,
                            height: 30,
                            hideField: false,
                            label: 'Código',
                            lines: 1,
                            width: 50,
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SimpleFormField(
                            controller: tBank,
                            enabled: true,
                            fontSize: 14,
                            fontSizeLabel: 14,
                            height: 30,
                            hideField: false,
                            label: 'Banco',
                            lines: 1,
                            width: 90,
                          ),
                          SimpleFormField(
                            controller: tBankName,
                            enabled: true,
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
                            controller: tAgency,
                            enabled: true,
                            fontSize: 14,
                            fontSizeLabel: 14,
                            height: 30,
                            hideField: false,
                            label: 'Agência',
                            lines: 1,
                            width: 150,
                          ),
                          SimpleFormField(
                            controller: tAccount,
                            enabled: true,
                            fontSize: 14,
                            fontSizeLabel: 14,
                            height: 30,
                            hideField: false,
                            label: 'Conta',
                            lines: 1,
                            width: 120,
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
                  ButtonIcon(
                    () async {
                      await openScreen(context, '/HomePage');
                    },
                    'Home Page',
                    Icons.home,
                    30,
                    Colors.white,
                    true,
                    30,
                    Colors.black,
                  ),
                  ButtonIcon(
                    () async {
                      await closeScreen(context, 1);
                    },
                    'Retornar',
                    Icons.arrow_back,
                    30,
                    Colors.white,
                    true,
                    30,
                    Colors.black,
                  ),
                  ButtonIcon(
                    () async {
                      Navigator.of(context).push(PageRouteBuilder(
                        opaque: false,
                        transitionDuration: Duration(milliseconds: 1),
                        pageBuilder: (_, __, ___) =>
                            WaitingScreen('Salvando registro...'),
                      ));
                      AccountApi api = AccountApi();
                      Response returnRequest = await api.postRequest(
                        {
                          'id': tIdAccountBank.text,
                          'codigoBanco': tBank.text,
                          'nomeBanco': tBankName.text,
                          'agencia': tAgency.text,
                          'conta': tAccount.text,
                        },
                      );
                      closeScreen(context, 1);
                      if (jsonDecode(returnRequest.body)['id'].toString() !=
                              null ||
                          jsonDecode(returnRequest.body)['id'].toString() !=
                              '' ||
                          jsonDecode(returnRequest.body)['id']
                              .toString()
                              .isNotEmpty) {
                        tIdAccountBank.text =
                            jsonDecode(returnRequest.body)['id'].toString();
                      } else {
                        tIdAccountBank.text = '';
                      }
                      tIdAccountBank.text = '';
                      alert(
                          context,
                          'Sucesso',
                          jsonDecode(returnRequest.body)['mensagem'].toString(),
                          'SUCESSO');
                      tIdAccountBank.text = '';
                      tBank.text = '';
                      tBankName.text = '';
                      tAgency.text = '';
                      tAccount.text = '';
                    },
                    'Salvar',
                    Icons.save,
                    30,
                    Colors.white,
                    true,
                    30,
                    Colors.black,
                  ),
                  ButtonIcon(
                    () async {
                      Navigator.of(context).push(PageRouteBuilder(
                        opaque: false,
                        transitionDuration: Duration(milliseconds: 1),
                        pageBuilder: (_, __, ___) =>
                            WaitingScreen('Apagando registro...'),
                      ));
                      // AccountBankApi api = AccountBankApi();
                      // Response returnRequest = await api.deleteRequest(
                      //   {
                      //     'id': tIdAccountBank.text,
                      //   },
                      // );
                      tIdAccountBank.text = '';
                      tBank.text = '';
                      tBankName.text = '';
                      tAgency.text = '';
                      tAccount.text = '';

                      closeScreen(context, 1);
                      // alert(
                      //     context,
                      //     'Sucesso',
                      //     jsonDecode(returnRequest.body)['mensagem'].toString(),
                      //     'SUCESSO');
                    },
                    'Apagar',
                    Icons.delete,
                    30,
                    Colors.white,
                    true,
                    30,
                    Colors.black,
                  ),
                ],
              ),
            ],
          ),
          340),
    );
  }
}
