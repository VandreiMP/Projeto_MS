import 'package:cliente_flutter/components/waitingScreen.dart';
import 'package:cliente_flutter/utilFunctions/closeScreen.dart';
import 'package:http/http.dart';
import 'package:cliente_flutter/api/loginApi.dart';
import 'package:cliente_flutter/components/alert.dart';
import 'package:cliente_flutter/components/section.dart';
import 'package:cliente_flutter/components/simpleFormField.dart';
import 'package:cliente_flutter/components/textButton.dart';
import 'package:cliente_flutter/constants/masks.dart';
import 'package:cliente_flutter/screens/screenPattern.dart';
import 'package:cliente_flutter/utilFunctions/openScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final tLogin = TextEditingController();
  final tPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScreenPattern(
      child: Column(
        children: [
          Section(
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
                          'Login',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SimpleFormField(
                            controller: tLogin,
                            enabled: true,
                            fontSize: 14,
                            fontSizeLabel: 14,
                            height: 30,
                            hideField: false,
                            label: 'Usuário',
                            lines: 1,
                            width: 300,
                          ),
                          SimpleFormField(
                            controller: tPassword,
                            enabled: true,
                            fontSize: 14,
                            fontSizeLabel: 14,
                            height: 30,
                            hideField: true,
                            label: 'Senha',
                            lines: 1,
                            width: 300,
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
                          Navigator.of(context).push(PageRouteBuilder(
                            opaque: false,
                            transitionDuration: Duration(milliseconds: 1),
                            pageBuilder: (_, __, ___) =>
                                WaitingScreen('Autenticando usuário...'),
                          ));
                          LoginApi api = LoginApi();
                          Response returnRequest = await api.postRequest(
                            {
                              'login': tLogin.text,
                              'senha': tPassword.text,
                            },
                          );

                          if (returnRequest.statusCode.toString() != '200') {
                            closeScreen(context, 1);
                            alert(context, 'Atenção',
                                returnRequest.body.toString(), 'ALERTA');
                          } else {
                            closeScreen(context, 1);
                            openScreen(context, '/HomePage');
                          }
                        },
                        'Entrar',
                        Colors.white,
                        Colors.black,
                        Colors.blueGrey,
                        'Efetua o login no sistema',
                      ),
                      Button(
                        () async {
                          openScreen(context, '/User');
                        },
                        'Cadastrar Usuário',
                        Colors.white,
                        Colors.black,
                        Colors.blueGrey,
                        'Abre a rotina para o cadastro do usuário',
                      ),
                    ],
                  ),
                ],
              ),
              270),
        ],
      ),
    );
  }
}
