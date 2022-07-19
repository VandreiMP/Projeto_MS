import 'package:flutter/material.dart';
/*
Modelo padrão de tela para o sistema
Usar este modelo para construir todos os formulários
*/

class ScreenPattern extends StatelessWidget {
  const ScreenPattern({
    this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   elevation: 4,
      //   backgroundColor: Colors.black,
      //   title: Padding(
      //     padding: const EdgeInsets.all(0.0),
      //     child: Row(
      //       children: [
      //         Container(
      //           child: Text(
      //             title,
      //             style: TextStyle(
      //               fontFamily: 'Cardo',
      //               color: Colors.white,
      //               height: 40,
      //               fontSize: 16,
      //               fontWeight: FontWeight.bold,
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(child: child),
            ],
          ),
        ],
      ),
    );
  }
}
