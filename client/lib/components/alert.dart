import 'package:cliente_flutter/utilFunctions/closeScreen.dart';
import 'package:flutter/material.dart';

alert(BuildContext context, String texto, String msg, String tipoAlerta,
    {Function callback}) async {
  Color corAlerta;
  IconData iconeAlerta;

  if (tipoAlerta == 'ALERTA') {
    corAlerta = Colors.yellow;
    iconeAlerta = Icons.info;
  } else if (tipoAlerta == 'SUCESSO') {
    corAlerta = Colors.green;
    iconeAlerta = Icons.check_circle;
  }

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: Text("$texto",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          backgroundColor: Colors.black,
          contentTextStyle:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          content: Row(
            children: [
              Text(
                "$msg",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: <Widget>[
            FloatingActionButton(
              child: Text(
                "OK",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                closeScreen(context, 1);
                if (callback != null) {
                  callback();
                }
              },
            )
          ],
        ),
      );
    },
  );
}

alertConfirm(BuildContext context, String texto, String msg,
    {Function confirmCallback}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          backgroundColor: Colors.black,
          title: Text(
            texto,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          content: Text(
            msg,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            FloatingActionButton(
              child: Text(
                "Sim",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                closeScreen(context, 1);
                if (confirmCallback != null) {
                  confirmCallback();
                }
              },
            ),
            FloatingActionButton(
              child: Text(
                "Não",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                closeScreen(context, 1);
              },
            ),
          ],
        ),
      );
    },
  );
}
