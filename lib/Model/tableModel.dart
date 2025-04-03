// To parse this JSON data, do
//
//     final tableModel = tableModelFromJson(jsonString);

import 'dart:convert';

TableModel tableModelFromJson(String str) =>
    TableModel.fromJson(json.decode(str));

String tableModelToJson(TableModel data) => json.encode(data.toJson());

class TableModel {
  bool status;
  String message;
  List<TableData> data;

  TableModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory TableModel.fromJson(Map<String, dynamic> json) => TableModel(
        status: json["status"],
        message: json["message"],
        data: List<TableData>.from(
            json["data"].map((x) => TableData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class TableData {
  int tableId;
  String tableNumber;
  String status;
  String tableFullName;
  String type;

  TableData({
    required this.tableId,
    required this.tableNumber,
    required this.status,
    required this.tableFullName,
    required this.type,
  });

  factory TableData.fromJson(Map<String, dynamic> json) => TableData(
        tableId: json["table_id"],
        tableNumber: json["table_number"],
        status: json["status"],
        tableFullName: json["table_full_name"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "table_id": tableId,
        "table_number": tableNumber,
        "status": status,
        "table_full_name": tableFullName,
        "type": type,
      };
}
