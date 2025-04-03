// To parse this JSON data, do
//
//     final modelAllDealer = modelAllDealerFromJson(jsonString);

import 'dart:convert';

ModelAllDealer modelAllDealerFromJson(String str) =>
    ModelAllDealer.fromJson(json.decode(str));

String modelAllDealerToJson(ModelAllDealer data) => json.encode(data.toJson());

class ModelAllDealer {
  String message;
  List<AllDealer> data;

  ModelAllDealer({
    required this.message,
    required this.data,
  });

  factory ModelAllDealer.fromJson(Map<String, dynamic> json) => ModelAllDealer(
        message: json["message"],
        data: List<AllDealer>.from(
            json["data"].map((x) => AllDealer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class AllDealer {
  int id;
  String name;
  String username;
  String status;
  String colorCode;

  AllDealer({
    required this.id,
    required this.name,
    required this.username,
    required this.status,
    required this.colorCode,
  });

  factory AllDealer.fromJson(Map<String, dynamic> json) => AllDealer(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        status: json["status"],
        colorCode: json["color_code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "status": status,
        "color_code": colorCode,
      };
}
