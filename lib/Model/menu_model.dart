// To parse this JSON data, do
//
//     final menuModel = menuModelFromJson(jsonString);

import 'dart:convert';

MenuModel menuModelFromJson(String str) => MenuModel.fromJson(json.decode(str));

String menuModelToJson(MenuModel data) => json.encode(data.toJson());

class MenuModel {
  bool status;
  String message;
  List<MenuData> data;

  MenuModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) => MenuModel(
        status: json["status"],
        message: json["message"],
        data:
            List<MenuData>.from(json["data"].map((x) => MenuData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class MenuData {
  int id;
  String categoryName;
  List<GetSubcategory> getSubcategories;

  MenuData({
    required this.id,
    required this.categoryName,
    required this.getSubcategories,
  });

  factory MenuData.fromJson(Map<String, dynamic> json) => MenuData(
        id: json["id"],
        categoryName: json["category_name"],
        getSubcategories: List<GetSubcategory>.from(
            json["get_subcategories"].map((x) => GetSubcategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_name": categoryName,
        "get_subcategories":
            List<dynamic>.from(getSubcategories.map((x) => x.toJson())),
      };
}

class GetSubcategory {
  int id;
  String itemName;
  int status;
  int menuCategoryId;
  List<GetVarient> getVarient;

  GetSubcategory({
    required this.id,
    required this.itemName,
    required this.status,
    required this.menuCategoryId,
    required this.getVarient,
  });

  factory GetSubcategory.fromJson(Map<String, dynamic> json) => GetSubcategory(
        id: json["id"],
        itemName: json["item_name"],
        status: json["status"],
        menuCategoryId: json["menu_category_id"],
        getVarient: List<GetVarient>.from(
            json["get_varient"].map((x) => GetVarient.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "item_name": itemName,
        "status": status,
        "menu_category_id": menuCategoryId,
        "get_varient": List<dynamic>.from(getVarient.map((x) => x.toJson())),
      };
}

class GetVarient {
  int skuPrice;
  String skuVarient;
  int menuProductId;

  GetVarient({
    required this.skuPrice,
    required this.skuVarient,
    required this.menuProductId,
  });

  factory GetVarient.fromJson(Map<String, dynamic> json) => GetVarient(
        skuPrice: json["sku_price"],
        skuVarient: json["sku_varient"],
        menuProductId: json["menu_product_id"],
      );

  Map<String, dynamic> toJson() => {
        "sku_price": skuPrice,
        "sku_varient": skuVarient,
        "menu_product_id": menuProductId,
      };
}
