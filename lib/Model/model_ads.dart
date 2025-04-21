// To parse this JSON data, do
//
//     final modelAds = modelAdsFromJson(jsonString);

import 'dart:convert';

ModelAds modelAdsFromJson(String str) => ModelAds.fromJson(json.decode(str));

String modelAdsToJson(ModelAds data) => json.encode(data.toJson());

class ModelAds {
    List<Ad> ads;

    ModelAds({
        required this.ads,
    });

    factory ModelAds.fromJson(Map<String, dynamic> json) => ModelAds(
        ads: List<Ad>.from(json["ads"].map((x) => Ad.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ads": List<dynamic>.from(ads.map((x) => x.toJson())),
    };
}

class Ad {
    String ads;

    Ad({
        required this.ads,
    });

    factory Ad.fromJson(Map<String, dynamic> json) => Ad(
        ads: json["ads"],
    );

    Map<String, dynamic> toJson() => {
        "ads": ads,
    };
}
