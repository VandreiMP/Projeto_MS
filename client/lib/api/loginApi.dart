import 'dart:convert';

import 'package:http/http.dart';

class LoginApi {
  Future<Response> postRequest(Map<String, String> json) async {
    final url = Uri.parse('http://localhost:3000/login');

    Response response = await post(
      url,
      headers: <String, String>{
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Headers': '*',
        'Access-Control-Allow-Methods': 'GET,PUT,POST,DELETE',
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(json),
    );

    return response;
  }

  Future<String> getRequest(Map<String, String> json) async {
    final url = Uri.parse('http://localhost:3000/login');

    Response response = await get(
      url,
      headers: <String, String>{
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Headers': '*',
        'Access-Control-Allow-Methods': 'GET,PUT,POST,DELETE',
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );

    return response.body;
  }
}
