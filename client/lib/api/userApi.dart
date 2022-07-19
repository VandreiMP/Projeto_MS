import 'dart:convert';

import 'package:http/http.dart';

class UserApi {
  Future<Response> postRequest(Map<String, String> json) async {
    final url = Uri.parse('http://localhost:3002/user');

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

  Future<Response> deleteRequest(Map<String, String> json) async {
    final url = Uri.parse('http://localhost:3002/user');

    Response response = await delete(
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

  Future<Response> getRequest(Map<String, int> json) async {
    final url = Uri.parse('http://localhost:3002/getUser');

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
}
