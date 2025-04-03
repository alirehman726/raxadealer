// // To parse this JSON data, do
// //
// //     final orderHistoryModel = orderHistoryModelFromJson(jsonString);

// import 'dart:convert';

// OrderHistoryModel orderHistoryModelFromJson(String str) =>
//     OrderHistoryModel.fromJson(json.decode(str));

// String orderHistoryModelToJson(OrderHistoryModel data) =>
//     json.encode(data.toJson());

// class OrderHistoryModel {
//   List<OrderHistory> data;

//   OrderHistoryModel({
//     required this.data,
//   });

//   factory OrderHistoryModel.fromJson(Map<String, dynamic> json) =>
//       OrderHistoryModel(
//         data: List<OrderHistory>.from(
//             json["data"].map((x) => OrderHistory.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//       };
// }

// class OrderHistory {
//   String name;
//   String variant;
//   String quantity;
//   String price;
//   String note;

//   OrderHistory({
//     required this.name,
//     required this.variant,
//     required this.quantity,
//     required this.price,
//     required this.note,
//   });

//   factory OrderHistory.fromJson(Map<String, dynamic> json) => OrderHistory(
//         name: json["name"],
//         variant: json["variant"],
//         quantity: json["quantity"],
//         price: json["price"],
//         note: json["note"],
//       );

//   get additionalNote => null;

//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "variant": variant,
//         "quantity": quantity,
//         "price": price,
//         "note": note,
//       };
// }

// To parse this JSON data, do
//
//     final orderHistoryModel = orderHistoryModelFromJson(jsonString);

import 'dart:convert';

OrderHistoryModel orderHistoryModelFromJson(String str) =>
    OrderHistoryModel.fromJson(json.decode(str));

String orderHistoryModelToJson(OrderHistoryModel data) =>
    json.encode(data.toJson());

class OrderHistoryModel {
  List<OrderHistory> data;

  OrderHistoryModel({
    required this.data,
  });

  factory OrderHistoryModel.fromJson(Map<String, dynamic> json) =>
      OrderHistoryModel(
        data: List<OrderHistory>.from(
            json["data"].map((x) => OrderHistory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class OrderHistory {
  String name;
  String variant;
  String quantity;
  String price;
  List<String> note;

  OrderHistory({
    required this.name,
    required this.variant,
    required this.quantity,
    required this.price,
    required this.note,
  });

  factory OrderHistory.fromJson(Map<String, dynamic> json) => OrderHistory(
        name: json["name"],
        variant: json["variant"],
        quantity: json["quantity"],
        price: json["price"],
        note: List<String>.from(json["note"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "variant": variant,
        "quantity": quantity,
        "price": price,
        "note": List<dynamic>.from(note.map((x) => x)),
      };
}
