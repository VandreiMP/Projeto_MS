import 'package:flutter/material.dart';

class WaitingScreen extends StatefulWidget {
  final String acao;
  WaitingScreen(this.acao);

  @override
  _WaitingScreenState createState() => _WaitingScreenState(acao);
}

class _WaitingScreenState extends State<WaitingScreen> {
  final String acao;
  _WaitingScreenState(this.acao);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(100, 0, 0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Body(acao),
        ],
      ),
    );
  }
}

class Body extends StatefulWidget {
  final String acao;

  Body(this.acao);
  @override
  _BodyState createState() => _BodyState(acao);
}

class _BodyState extends State<Body> {
  final String acao;
  _BodyState(this.acao);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            acao,
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                decoration: TextDecoration.none),
                          ),
                          CircularProgressIndicator(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
