// To parse this JSON data, do
//
//     final modelAllOrder = modelAllOrderFromJson(jsonString);

import 'dart:convert';

ModelAllOrder modelAllOrderFromJson(String str) =>
    ModelAllOrder.fromJson(json.decode(str));

String modelAllOrderToJson(ModelAllOrder data) => json.encode(data.toJson());

class ModelAllOrder {
  bool status;
  List<AllOrder> data;

  ModelAllOrder({
    required this.status,
    required this.data,
  });

  factory ModelAllOrder.fromJson(Map<String, dynamic> json) => ModelAllOrder(
        status: json["status"],
        data:
            List<AllOrder>.from(json["data"].map((x) => AllOrder.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class AllOrder {
  int id;
  String status;
  DateTime orderDate;
  String actionBy;
  String paymentId;
  String colorCode;
  String time;

  AllOrder({
    required this.id,
    required this.status,
    required this.orderDate,
    required this.actionBy,
    required this.paymentId,
    required this.colorCode,
    required this.time,
  });

  factory AllOrder.fromJson(Map<String, dynamic> json) => AllOrder(
        id: json["id"],
        status: json["status"],
        orderDate: DateTime.parse(json["order_date"]),
        actionBy: json["action_by"],
        paymentId: json["payment_id"],
        colorCode: json["color_code"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "order_date":
            "${orderDate.year.toString().padLeft(4, '0')}-${orderDate.month.toString().padLeft(2, '0')}-${orderDate.day.toString().padLeft(2, '0')}",
        
        "action_by": actionBy,
        "payment_id": paymentId,
        "color_code": colorCode,
        "time": time,
      };
}
