import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raxaadmin/Model/reminder_form_model.dart';

class EventModel {
  String eventId;
  String title;
  String icon;
  List<CustomFieldModel> customFields;
  List<EventModel> subcategories;
  String createdAt;
  bool isSelected;

  EventModel(
      {required this.eventId,
      required this.title,
      required this.icon,
      required this.customFields,
      required this.subcategories,
      required this.createdAt,
      required this.isSelected});

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
      eventId: json['_id'] ?? "",
      title: json['title'] ?? "",
      icon: json['icon'] ?? "",
      customFields: json['custom_field'] ?? <dynamic>[],
      subcategories: json['subCategories'] ?? <dynamic>[],
      createdAt: json['createdAt'] ?? "",
      isSelected: false);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = eventId;
    data['title'] = title;
    data['icon'] = icon;
    data['custom_field'] = customFields;
    data['subCategories'] = subcategories;
    data['createdAt'] = createdAt;
    return data;
  }

  @override
  String toString() {
    return "{_id: $eventId, "
        "title=$title,"
        "icon=$icon,"
        "custom_field=$customFields,"
        "subCategories=$subcategories,"
        "createdAt=$createdAt}";
  }
}

class CustomFieldModel {
  String type;
  String name;
  String hint;

  CustomFieldModel(
      {required this.type, required this.name, required this.hint});

  factory CustomFieldModel.fromJson(Map<String, dynamic> json) =>
      CustomFieldModel(
          type: json['type'], name: json['name'], hint: json['hint']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['name'] = name;
    data['hint'] = hint;
    return data;
  }

  @override
  String toString() {
    return "{type: $type, "
        "name=$name,"
        "hint=$hint}";
  }
}

/// Convert String into EventModel JSON
List<EventModel> eventModalFromJson(data) {
  List<EventModel> items = <EventModel>[];
  for (var d in data) {
    if (d['custom_field'] != null && d['custom_field'].length > 0) {
      d['custom_field'] = customFieldModalFromJson(d['custom_field']);
    } else {
      d['custom_field'] = <CustomFieldModel>[];
    }
    if (d['subCategories'] != null && d['subCategories'].length > 0) {
      d['subCategories'] = eventModalFromJson(d['subCategories']);
    } else {
      d['subCategories'] = <EventModel>[];
    }
    EventModel event = EventModel.fromJson(d);
    items.add(event);
  }
  return items;
}

/// Convert String into CustomFieldModel JSON
List<CustomFieldModel> customFieldModalFromJson(data) {
  List<CustomFieldModel> items = <CustomFieldModel>[];
  for (var d in data) {
    CustomFieldModel customField = CustomFieldModel.fromJson(d);
    items.add(customField);
  }
  return items;
}

/// Function to get Icon Based on CustomField Type
IconData getCustomFieldIconData(CustomFieldModel model) {
  switch (model.type) {
    case "text":
      return Icons.text_fields_rounded;
    case "date":
      return Icons.calendar_today_rounded;
    case "number":
      return Icons.numbers_rounded;
    default:
      return Icons.abc_rounded;
  }
}
