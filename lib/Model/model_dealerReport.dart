// To parse this JSON data, do
//
//     final modelDealerReport = modelDealerReportFromJson(jsonString);

import 'dart:convert';

ModelDealerReport modelDealerReportFromJson(String str) =>
    ModelDealerReport.fromJson(json.decode(str));

String modelDealerReportToJson(ModelDealerReport data) =>
    json.encode(data.toJson());

class ModelDealerReport {
  bool status;
  String message;
  List<Report> data;

  ModelDealerReport({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ModelDealerReport.fromJson(Map<String, dynamic> json) =>
      ModelDealerReport(
        status: json["status"],
        message: json["message"],
        data: List<Report>.from(json["data"].map((x) => Report.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Report {
  int id;
  String dealerName;
  int totalPrice;

  Report({
    required this.id,
    required this.dealerName,
    required this.totalPrice,
  });

  factory Report.fromJson(Map<String, dynamic> json) => Report(
        id: json["id"],
        dealerName: json["dealer_name"],
        totalPrice: json["total_price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "dealer_name": dealerName,
        "total_price": totalPrice,
      };
}
