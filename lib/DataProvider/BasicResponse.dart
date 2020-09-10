// To parse this JSON data, do
//
//     final modelBasicResponse = modelBasicResponseFromJson(jsonString);

import 'dart:convert';

ModelBasicResponse modelBasicResponseFromJson(String str) => ModelBasicResponse.fromJson(json.decode(str));

String modelBasicResponseToJson(ModelBasicResponse data) => json.encode(data.toJson());

class ModelBasicResponse {
  ModelBasicResponse({
    this.status,
    this.message,
  });

  bool status;
  String message;

  factory ModelBasicResponse.fromJson(Map<String, dynamic> json) => ModelBasicResponse(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
  };
}
