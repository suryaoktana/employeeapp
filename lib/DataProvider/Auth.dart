import 'dart:convert';
import 'package:employeeapp/Bloc/AuthBloc.dart';
import 'package:employeeapp/DataProvider/serverInfo.dart';
import 'package:http/http.dart' show Client;

class Auth{
  Client client = Client();
  Future<ModelLogin> Login(AuthEvent event) async {
    final response = await client.post(
      "${ServerInfo.endpoint}login",
      headers: {"content-type": "application/json"},
      body: json.encode({'email': event.email.trim().toLowerCase(), 'password': event.password}));
    if (response.statusCode == 200 || response.statusCode == 400) {
      print(response.body);
      return modelLoginFromJson(response.body);
    } else {
      return null;
    }
  }
}


ModelLogin modelLoginFromJson(String str) => ModelLogin.fromJson(json.decode(str));

String modelLoginToJson(ModelLogin data) => json.encode(data.toJson());

class ModelLogin {
  ModelLogin({
    this.token,
    this.error,
  });

  String token;
  String error;

  factory ModelLogin.fromJson(Map<String, dynamic> json) => ModelLogin(
    token: json["token"] == null ? null : json["token"],
    error: json["error"] == null ? null : json["error"],
  );

  Map<String, dynamic> toJson() => {
    "token": token == null ? null : token,
    "error": error == null ? null : error,
  };
}


