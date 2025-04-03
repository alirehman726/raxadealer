// To parse this JSON data, do
//
//     final expences = expencesFromJson(jsonString);

import 'dart:convert';

Expences expencesFromJson(String str) => Expences.fromJson(json.decode(str));

String expencesToJson(Expences data) => json.encode(data.toJson());

class Expences {
  bool status;
  String balance;
  String income;
  String expence;
  String selectedDate;
  List<Data> data;

  Expences({
    required this.status,
    required this.balance,
    required this.income,
    required this.expence,
    required this.selectedDate,
    required this.data,
  });

  factory Expences.fromJson(Map<String, dynamic> json) => Expences(
        status: json["status"] ?? false,
        balance: json["balance"] ?? "",
        income: json["income"] ?? "",
        expence: json["expence"] ?? "",
        selectedDate: json["selected_date"] ?? "",
        data: json["data"] != null
            ? List<Data>.from(json["data"].map((x) => Data.fromJson(x)))
            : [], // Handle null case by providing an empty list
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "balance": balance,
        "income": income,
        "expence": expence,
        "selected_date": selectedDate,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Data {
  String id;
  String amount;
  String comment;
  String type;

  Data({
    required this.id,
    required this.amount,
    required this.comment,
    required this.type,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        amount: json["amount"],
        comment: json["comment"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "comment": comment,
        "type": type,
      };
}
