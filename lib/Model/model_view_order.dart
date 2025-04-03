// To parse this JSON data, do
//
//     final modelViewOrder = modelViewOrderFromJson(jsonString);

import 'dart:convert';

ModelViewOrder modelViewOrderFromJson(String str) =>
    ModelViewOrder.fromJson(json.decode(str));

String modelViewOrderToJson(ModelViewOrder data) => json.encode(data.toJson());

class ModelViewOrder {
  bool status;
  String message;
  ViewOrder data;

  ModelViewOrder({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ModelViewOrder.fromJson(Map<String, dynamic> json) => ModelViewOrder(
        status: json["status"],
        message: json["message"],
        data: ViewOrder.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class ViewOrder {
  int id;
  String status;
  DateTime orderDate;
  String actionBy;
  String paymentId;
  List<Order> order;

  ViewOrder({
    required this.id,
    required this.status,
    required this.orderDate,
    required this.actionBy,
    required this.paymentId,
    required this.order,
  });

  factory ViewOrder.fromJson(Map<String, dynamic> json) => ViewOrder(
        id: json["id"],
        status: json["status"],
        orderDate: DateTime.parse(json["order_date"]),
        actionBy: json["action_by"],
        paymentId: json["payment_id"],
        order: List<Order>.from(json["order"].map((x) => Order.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "order_date":
            "${orderDate.year.toString().padLeft(4, '0')}-${orderDate.month.toString().padLeft(2, '0')}-${orderDate.day.toString().padLeft(2, '0')}",
        "action_by": actionBy,
        "payment_id": paymentId,
        "order": List<dynamic>.from(order.map((x) => x.toJson())),
      };
}

class Order {
  int productId;
  String productName;
  int quantity;
  int price;

  Order({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.price,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        productId: json["product_id"],
        productName: json["product_name"],
        quantity: json["quantity"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "product_name": productName,
        "quantity": quantity,
        "price": price,
      };
}
