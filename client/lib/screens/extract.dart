import 'dart:convert';
import 'package:cliente_flutter/api/accountApi.dart';
import 'package:cliente_flutter/api/transactionApi.dart';
import 'package:cliente_flutter/components/actionFormField.dart';
import 'package:cliente_flutter/components/alert.dart';
import 'package:cliente_flutter/components/scroll.dart';
import 'package:cliente_flutter/utilFunctions/consultaContaBancaria.dart';
import 'package:cliente_flutter/utilFunctions/consultaExtrato.dart';
import 'package:http/http.dart';
import 'package:cliente_flutter/api/loginApi.dart';
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

class Extract extends StatefulWidget {
  @override
  State<Extract> createState() => _ExtractState();
}

class _ExtractState extends State<Extract> {
  final tExtract = TextEditingController();
  final tIdAccount = TextEditingController();
  final tDsBankAccount = TextEditingController();
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
                      'Extrato',
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              ActionFormField(
                                controller: tIdAccount,
                                enabled: true,
                                fontSize: 14,
                                fontSizeLabel: 14,
                                height: 30,
                                onChanged: (String valor) async {
                                  tDsBankAccount.text =
                                      await consultaContaBancaria(
                                          context, tIdAccount.text);
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
                                  tExtract.text = await consultaExtrato(
                                      context, tIdAccount.text);
                                },
                                'Consultar',
                                Colors.white,
                                Colors.black,
                                Colors.blueGrey,
                                'Consulta o extrato',
                              ),
                            ],
                          ),
                        ],
                      ),
                      //extrato
                      Container(
                        height: 300,
                        child: Scroll(
                          child: Row(
                            children: [
                              SimpleFormField(
                                controller: tExtract,
                                enabled: true,
                                fontSize: 14,
                                fontSizeLabel: 14,
                                height: 250,
                                hideField: false,
                                label: '',
                                lines: 30,
                                width: 500,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          500),
    );
  }
}
