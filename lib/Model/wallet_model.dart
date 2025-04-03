// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  bool? status;
  String? message;
  List<Data>? data;

  CategoryModel({
    this.status,
    this.message,
    this.data,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        status: json["status"],
        message: json["message"],
        data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Data {
  String? id;
  String? title;
  String? description;
  String? icon;
  List<CustomField>? customField;
  List<SubCategory>? subCategories;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Data({
    this.id,
    this.title,
    this.description,
    this.icon,
    this.customField,
    this.subCategories,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        icon: json["icon"],
        customField: List<CustomField>.from(
            json["custom_field"].map((x) => CustomField.fromJson(x))),
        subCategories: List<SubCategory>.from(
            json["subCategories"].map((x) => SubCategory.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "icon": icon,
        "custom_field": List<dynamic>.from(customField!.map((x) => x.toJson())),
        "subCategories":
            List<dynamic>.from(subCategories!.map((x) => x.toJson())),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class CustomField {
  Type? type;
  String? name;
  String? hint;

  CustomField({
    this.type,
    this.name,
    this.hint,
  });

  factory CustomField.fromJson(Map<String, dynamic> json) => CustomField(
        type: typeValues.map[json["type"]],
        name: json["name"],
        hint: json["hint"],
      );

  Map<String, dynamic> toJson() => {
        "type": typeValues.reverse[type],
        "name": name,
        "hint": hint,
      };
}

enum Type { TEXT, DATE, NUMBER, DROPDOWN }

final typeValues = EnumValues({
  "date": Type.DATE,
  "dropdown": Type.DROPDOWN,
  "number": Type.NUMBER,
  "text": Type.TEXT
});

class SubCategory {
  String? title;
  String? description;
  List<CustomField>? customField;
  String? id;

  SubCategory({
    this.title,
    this.description,
    this.customField,
    this.id,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        title: json["title"],
        description: json["description"],
        customField: List<CustomField>.from(
            json["custom_field"].map((x) => CustomField.fromJson(x))),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "custom_field": List<dynamic>.from(customField!.map((x) => x.toJson())),
        "_id": id,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
