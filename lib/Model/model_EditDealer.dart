// To parse this JSON data, do
//
//     final modelEditDealer = modelEditDealerFromJson(jsonString);

import 'dart:convert';

ModelEditDealer modelEditDealerFromJson(String str) => ModelEditDealer.fromJson(json.decode(str));

String modelEditDealerToJson(ModelEditDealer data) => json.encode(data.toJson());

class ModelEditDealer {
    String message;
    List<EditDealer> data;

    ModelEditDealer({
        required this.message,
        required this.data,
    });

    factory ModelEditDealer.fromJson(Map<String, dynamic> json) => ModelEditDealer(
        message: json["message"],
        data: List<EditDealer>.from(json["data"].map((x) => EditDealer.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class EditDealer {
    int id;
    String name;
    String username;
    String phnNumber;
    String address;
    String email;

    EditDealer({
        required this.id,
        required this.name,
        required this.username,
        required this.phnNumber,
        required this.address,
        required this.email,
    });

    factory EditDealer.fromJson(Map<String, dynamic> json) => EditDealer(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        phnNumber: json["phn_number"],
        address: json["address"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "phn_number": phnNumber,
        "address": address,
        "email": email,
    };
}
