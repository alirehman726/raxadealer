// To parse this JSON data, do
//
//     final modelAllProducts = modelAllProductsFromJson(jsonString);

import 'dart:convert';

ModelAllProducts modelAllProductsFromJson(String str) =>
    ModelAllProducts.fromJson(json.decode(str));

String modelAllProductsToJson(ModelAllProducts data) =>
    json.encode(data.toJson());

class ModelAllProducts {
  bool status;
  String message;
  List<AllProducts> data;

  ModelAllProducts({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ModelAllProducts.fromJson(Map<String, dynamic> json) =>
      ModelAllProducts(
        status: json["status"],
        message: json["message"],
        data: List<AllProducts>.from(
            json["data"].map((x) => AllProducts.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class AllProducts {
  int id;
  String productName;
  String discription;
  String image;
  int price;
  int quantity;
  String stock;
  String weight;
  String packingType;
  String flavour;
  // String? addedDate;
  int? status;

  AllProducts({
    required this.id,
    required this.productName,
    required this.discription,
    required this.image,
    required this.price,
    required this.quantity,
    required this.stock,
    required this.weight,
    required this.packingType,
    required this.flavour,
    // required this.addedDate,
    required this.status,
  });

  factory AllProducts.fromJson(Map<String, dynamic> json) => AllProducts(
        id: json["id"],
        productName: json["product_name"],
        discription: json["discription"],
        image: json["image"],
        price: json["price"],
        quantity: json["quantity"],
        stock: json["stock"],
        weight: json["weight"],
        packingType: json["packing_type"],
        flavour: json["flavour"],
        // addedDate: json['added_date'],
        status: json['status'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_name": productName,
        "discription": discription,
        "image": image,
        "price": price,
        "quantity": quantity,
        "stock": stock,
        "weight": weight,
        "packing_type": packingType,
        "flavour": flavour,
        "status": status,
      };
}
