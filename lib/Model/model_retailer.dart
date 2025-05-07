// To parse this JSON data, do
//
//     final modelAllRetailer = modelAllRetailerFromJson(jsonString);

import 'dart:convert';

ModelAllRetailer modelAllRetailerFromJson(String str) => ModelAllRetailer.fromJson(json.decode(str));

String modelAllRetailerToJson(ModelAllRetailer data) => json.encode(data.toJson());

class ModelAllRetailer {
    String message;
    List<Retailer> data;

    ModelAllRetailer({
        required this.message,
        required this.data,
    });

    factory ModelAllRetailer.fromJson(Map<String, dynamic> json) => ModelAllRetailer(
        message: json["message"],
        data: List<Retailer>.from(json["data"].map((x) => Retailer.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Retailer {
    int id;
    String name;
    String username;
    String status;
    String colorCode;
    String profileImage;

    Retailer({
        required this.id,
        required this.name,
        required this.username,
        required this.status,
        required this.colorCode,
        required this.profileImage,
    });

    factory Retailer.fromJson(Map<String, dynamic> json) => Retailer(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        status: json["status"],
        colorCode: json["color_code"],
        profileImage: json["profile_image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "status": status,
        "color_code": colorCode,
        "profile_image": profileImage,
    };
}
