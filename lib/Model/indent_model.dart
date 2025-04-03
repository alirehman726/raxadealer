// // To parse this JSON data, do
// //
// //     final indentData = indentDataFromJson(jsonString);

// import 'dart:convert';

// IndentData indentDataFromJson(String str) =>
//     IndentData.fromJson(json.decode(str));

// String indentDataToJson(IndentData data) => json.encode(data.toJson());

// class IndentData {
//   String message;
//   List<ProductWise> productWise;
//   List<TextureWise> textureWise;
//   bool status;

//   IndentData({
//     required this.message,
//     required this.productWise,
//     required this.textureWise,
//     required this.status,
//   });

//   factory IndentData.fromJson(Map<String, dynamic> json) => IndentData(
//         message: json["message"],
//         productWise: List<ProductWise>.from(
//             json["product_wise"].map((x) => ProductWise.fromJson(x))),
//         textureWise: List<TextureWise>.from(
//             json["texture_wise"].map((x) => TextureWise.fromJson(x))),
//         status: json["status"],
//       );

//   Map<String, dynamic> toJson() => {
//         "message": message,
//         "product_wise": List<dynamic>.from(productWise.map((x) => x.toJson())),
//         "texture_wise": List<dynamic>.from(textureWise.map((x) => x.toJson())),
//         "status": status,
//       };
// }

// class ProductWise {
//   String productName;
//   double total;

//   ProductWise({
//     required this.productName,
//     required this.total,
//   });

//   factory ProductWise.fromJson(Map<String, dynamic> json) => ProductWise(
//         productName: json["product_name"] ?? "",
//         total: json["total"]?.toDouble() ?? "",
//       );

//   Map<String, dynamic> toJson() => {
//         "product_name": productName,
//         "total": total,
//       };
// }

// class TextureWise {
//   String productName;
//   String variant;
//   String? texture;
//   String qty;

//   TextureWise({
//     required this.productName,
//     required this.variant,
//     required this.texture,
//     required this.qty,
//   });

//   factory TextureWise.fromJson(Map<String, dynamic> json) => TextureWise(
//         productName: json["product_name"] ?? "",
//         variant: json["variant"] ?? "",
//         texture: json["texture"] ?? "",
//         qty: json["qty"] ?? "",
//       );

//   Map<String, dynamic> toJson() => {
//         "product_name": productName,
//         "variant": variant,
//         "texture": texture,
//         "qty": qty,
//       };
// }

// To parse this JSON data, do
//
//     final indentData = indentDataFromJson(jsonString);

import 'dart:convert';

IndentData indentDataFromJson(String str) =>
    IndentData.fromJson(json.decode(str));

String indentDataToJson(IndentData data) => json.encode(data.toJson());

class IndentData {
  String message;
  List<ProductWise> productWise;
  List<TextureWise> textureWise;
  bool status;

  IndentData({
    required this.message,
    required this.productWise,
    required this.textureWise,
    required this.status,
  });

  factory IndentData.fromJson(Map<String, dynamic> json) => IndentData(
        message: json["message"],
        productWise: List<ProductWise>.from(
            json["product_wise"].map((x) => ProductWise.fromJson(x))),
        textureWise: List<TextureWise>.from(
            json["texture_wise"].map((x) => TextureWise.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "product_wise": List<dynamic>.from(productWise.map((x) => x.toJson())),
        "texture_wise": List<dynamic>.from(textureWise.map((x) => x.toJson())),
        "status": status,
      };
}

class ProductWise {
  String productName;
  String total;
  String fine;
  String medium;
  String coarse;
  String is_pop_show;
  // double total;

  ProductWise({
    required this.productName,
    required this.total,
    required this.fine,
    required this.medium,
    required this.coarse,
    required this.is_pop_show,
  });

  factory ProductWise.fromJson(Map<String, dynamic> json) => ProductWise(
        productName: json["product_name"],
        total: json["total"],
        // total: json["total"]?.toDouble(),
        fine: json["Fine (महीन)"],
        medium: json["Medium (मध्यम)"],
        coarse: json["Coarse (दरदरा)"],
        is_pop_show: json["is_pop_show"],
      );

  Map<String, dynamic> toJson() => {
        "product_name": productName,
        "total": total,
        "Fine (महीन)": fine,
        "Medium (मध्यम)": medium,
        "Coarse (दरदरा)": coarse,
        "is_pop_show": is_pop_show,
      };
}

class TextureWise {
  String productName;
  String variant;
  String? texture;
  String qty;
  String image;

  TextureWise({
    required this.productName,
    required this.variant,
    required this.texture,
    required this.qty,
    required this.image,
  });

  factory TextureWise.fromJson(Map<String, dynamic> json) => TextureWise(
        productName: json["product_name"],
        variant: json["variant"],
        texture: json["texture"],
        qty: json["qty"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "product_name": productName,
        "variant": variant,
        "texture": texture,
        "qty": qty,
        "image": image,
      };
}
