import 'dart:convert';
import 'package:employeeapp/DataProvider/serverInfo.dart';
import 'package:http/http.dart' show Client;

class Employee{
  Client client = Client();
  Future<ModelEmployee> GetListEmployee() async {
    final response = await client.get(
        "${ServerInfo.endpoint}users?page=1",
        headers: {"content-type": "application/json"},
       );
    if (response.statusCode == 200 || response.statusCode == 400) {
      return modelEmployeeFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<ModelCreateEmployee> CreateEmployee(ModelCreateEmployee data) async {
    final response = await client.post(
      "${ServerInfo.endpoint}users",
      headers: {"content-type": "application/json"},
        body: json.encode({'name': data.name, 'job': data.job}));
    if (response.statusCode == 201 || response.statusCode == 400) {
      return modelCreateEmployeeFromJson(response.body);
    } else {
      return null;
    }
  }
}


ModelEmployee modelEmployeeFromJson(String str) => ModelEmployee.fromJson(json.decode(str));

String modelEmployeeToJson(ModelEmployee data) => json.encode(data.toJson());

class ModelEmployee {
  ModelEmployee({
    this.page,
    this.perPage,
    this.total,
    this.totalPages,
    this.data,
    this.ad,
  });

  int page;
  int perPage;
  int total;
  int totalPages;
  List<Datum> data;
  Ad ad;

  factory ModelEmployee.fromJson(Map<String, dynamic> json) => ModelEmployee(
    page: json["page"] == null ? null : json["page"],
    perPage: json["per_page"] == null ? null : json["per_page"],
    total: json["total"] == null ? null : json["total"],
    totalPages: json["total_pages"] == null ? null : json["total_pages"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    ad: json["ad"] == null ? null : Ad.fromJson(json["ad"]),
  );

  Map<String, dynamic> toJson() => {
    "page": page == null ? null : page,
    "per_page": perPage == null ? null : perPage,
    "total": total == null ? null : total,
    "total_pages": totalPages == null ? null : totalPages,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    "ad": ad == null ? null : ad.toJson(),
  };
}

class Ad {
  Ad({
    this.company,
    this.url,
    this.text,
  });

  String company;
  String url;
  String text;

  factory Ad.fromJson(Map<String, dynamic> json) => Ad(
    company: json["company"] == null ? null : json["company"],
    url: json["url"] == null ? null : json["url"],
    text: json["text"] == null ? null : json["text"],
  );

  Map<String, dynamic> toJson() => {
    "company": company == null ? null : company,
    "url": url == null ? null : url,
    "text": text == null ? null : text,
  };
}

class Datum {
  Datum({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
  });

  int id;
  String email;
  String firstName;
  String lastName;
  String avatar;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    email: json["email"] == null ? null : json["email"],
    firstName: json["first_name"] == null ? null : json["first_name"],
    lastName: json["last_name"] == null ? null : json["last_name"],
    avatar: json["avatar"] == null ? null : json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "email": email == null ? null : email,
    "first_name": firstName == null ? null : firstName,
    "last_name": lastName == null ? null : lastName,
    "avatar": avatar == null ? null : avatar,
  };
}


ModelCreateEmployee modelCreateEmployeeFromJson(String str) => ModelCreateEmployee.fromJson(json.decode(str));

String modelCreateEmployeeToJson(ModelCreateEmployee data) => json.encode(data.toJson());

class ModelCreateEmployee {
  ModelCreateEmployee({
    this.name,
    this.job,
    this.id,
    this.createdAt,
  });

  String name;
  String job;
  String id;
  DateTime createdAt;

  factory ModelCreateEmployee.fromJson(Map<String, dynamic> json) => ModelCreateEmployee(
    name: json["name"] == null ? null : json["name"],
    job: json["job"] == null ? null : json["job"],
    id: json["id"] == null ? null : json["id"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "job": job == null ? null : job,
    "id": id == null ? null : id,
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
  };
}


