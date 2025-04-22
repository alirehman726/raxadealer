// To parse this JSON data, do
//
//     final modelAllTrackOrder = modelAllTrackOrderFromJson(jsonString);

import 'dart:convert';

ModelAllTrackOrder modelAllTrackOrderFromJson(String str) => ModelAllTrackOrder.fromJson(json.decode(str));

String modelAllTrackOrderToJson(ModelAllTrackOrder data) => json.encode(data.toJson());

class ModelAllTrackOrder {
    bool status;
    List<TrackOrder> data;

    ModelAllTrackOrder({
        required this.status,
        required this.data,
    });

    factory ModelAllTrackOrder.fromJson(Map<String, dynamic> json) => ModelAllTrackOrder(
        status: json["status"],
        data: List<TrackOrder>.from(json["data"].map((x) => TrackOrder.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class TrackOrder {
    int id;
    String status;
    DateTime orderDate;
    String actionBy;
    String colorCode;
    String time;

    TrackOrder({
        required this.id,
        required this.status,
        required this.orderDate,
        required this.actionBy,
        required this.colorCode,
        required this.time,
    });

    factory TrackOrder.fromJson(Map<String, dynamic> json) => TrackOrder(
        id: json["id"],
        status: json["status"],
        orderDate: DateTime.parse(json["order_date"]),
        actionBy: json["action_by"],
        colorCode: json["color_code"],
        time: json["time"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "order_date": "${orderDate.year.toString().padLeft(4, '0')}-${orderDate.month.toString().padLeft(2, '0')}-${orderDate.day.toString().padLeft(2, '0')}",
        "action_by": actionBy,
        "color_code": colorCode,
        "time": time,
    };
}
