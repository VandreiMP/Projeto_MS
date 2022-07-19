import 'dart:convert';

import 'package:cliente_flutter/api/loginApi.dart';
import 'package:cliente_flutter/components/alert.dart';
import 'package:cliente_flutter/components/waitingScreen.dart';
import 'package:http/http.dart';
import 'package:cliente_flutter/api/userApi.dart';
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

class User extends StatefulWidget {
  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  final tIdUser = TextEditingController();
  final tNameUser = TextEditingController();
  final tCpf = MaskedTextController(mask: mascaraCpf);
  final tPhoneNumber = MaskedTextController(mask: mascaraTelefone);
  final tCellPhone = MaskedTextController(mask: mascaraCelular);
  final tLogin = TextEditingController();
  final tPassword = TextEditingController();

  UserApi userApi = UserApi();

  void getValues() async {
    // Navigator.of(context).push(PageRouteBuilder(
    //   opaque: false,
    //   transitionDuration: Duration(milliseconds: 1),
    //   pageBuilder: (_, __, ___) => WaitingScreen('Consultando registro...'),
    // ));

    Response returnRequest = await userApi.getRequest({"id": 1});


    tIdUser.text = jsonDecode(returnRequest.body)['id'].toString();
    tNameUser.text = jsonDecode(returnRequest.body)['nome'].toString();
    tCpf.text = jsonDecode(returnRequest.body)['cpf'].toString();
    tPhoneNumber.text = jsonDecode(returnRequest.body)['telefone'].toString();
    tCellPhone.text = jsonDecode(returnRequest.body)['celular'].toString();
    tLogin.text = jsonDecode(returnRequest.body)['login'].toString();
    tPassword.text = jsonDecode(returnRequest.body)['senha'].toString();

    // closeScreen(context, 1);
  }

  @override
  Widget build(BuildContext context) {
    getValues();

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
                      'Cadastro de Usuário',
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
                            controller: tIdUser,
                            enabled: false,
                            fontSize: 14,
                            fontSizeLabel: 14,
                            height: 30,
                            hideField: false,
                            label: 'Código',
                            lines: 1,
                            width: 50,
                          ),
                          SimpleFormField(
                            controller: tNameUser,
                            enabled: true,
                            fontSize: 14,
                            fontSizeLabel: 14,
                            height: 30,
                            hideField: false,
                            label: 'Nome',
                            lines: 1,
                            width: 300,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SimpleFormField(
                            controller: tCpf,
                            enabled: true,
                            fontSize: 14,
                            fontSizeLabel: 14,
                            height: 30,
                            mask: new MaskedTextController(
                              mask: mascaraCpf,
                            ),
                            hideField: false,
                            label: 'CPF',
                            lines: 1,
                            width: 150,
                          ),
                          SimpleFormField(
                            controller: tPhoneNumber,
                            enabled: true,
                            fontSize: 14,
                            fontSizeLabel: 14,
                            height: 30,
                            mask: new MaskedTextController(
                              mask: mascaraTelefone,
                            ),
                            hideField: false,
                            label: 'Telefone',
                            lines: 1,
                            width: 150,
                          ),
                          SimpleFormField(
                            controller: tCellPhone,
                            enabled: true,
                            fontSize: 14,
                            fontSizeLabel: 14,
                            height: 30,
                            mask: new MaskedTextController(
                              mask: mascaraCelular,
                            ),
                            hideField: false,
                            label: 'Celular',
                            lines: 1,
                            width: 150,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SimpleFormField(
                            controller: tLogin,
                            enabled: true,
                            fontSize: 14,
                            fontSizeLabel: 14,
                            height: 30,
                            hideField: false,
                            label: 'Login',
                            lines: 1,
                            width: 150,
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
                      UserApi api = UserApi();
                      Response returnRequest = await api.postRequest(
                        {
                          'id': tIdUser.text,
                          'nome': tNameUser.text,
                          'cpf': tCpf.text,
                          'telefone': tPhoneNumber.text,
                          'celular': tCellPhone.text,
                          'login': tLogin.text,
                          'senha': tPassword.text,
                        },
                      );
                      closeScreen(context, 1);
                      tIdUser.text =
                          jsonDecode(returnRequest.body)['id'].toString();
                      alert(
                          context,
                          'Sucesso',
                          jsonDecode(returnRequest.body)['mensagem'].toString(),
                          'SUCESSO');
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
                      UserApi api = UserApi();
                      Response returnRequest = await api.deleteRequest(
                        {
                          'id': tIdUser.text,
                        },
                      );
                      tIdUser.text = '';
                      tNameUser.text = '';
                      tCpf.text = 'null';
                      tPhoneNumber.text = '';
                      tCellPhone.text = '';
                      tLogin.text = '';
                      tPassword.text = '';
                      closeScreen(context, 1);
                      alert(
                          context,
                          'Sucesso',
                          jsonDecode(returnRequest.body)['mensagem'].toString(),
                          'SUCESSO');
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
          380),
    );
  }
}
