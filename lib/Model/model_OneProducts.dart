// To parse this JSON data, do
//
//     final modelOneProducts = modelOneProductsFromJson(jsonString);

import 'dart:convert';

ModelOneProducts modelOneProductsFromJson(String str) =>
    ModelOneProducts.fromJson(json.decode(str));

String modelOneProductsToJson(ModelOneProducts data) =>
    json.encode(data.toJson());

class ModelOneProducts {
  bool status;
  String message;
  OneProduct data;

  ModelOneProducts({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ModelOneProducts.fromJson(Map<String, dynamic> json) =>
      ModelOneProducts(
        status: json["status"],
        message: json["message"],
        data: OneProduct.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class OneProduct {
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

  OneProduct({
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
  });

  factory OneProduct.fromJson(Map<String, dynamic> json) => OneProduct(
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
      };
}
