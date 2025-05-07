// // // To parse this JSON data, do
// // //
// // //     final modelAllAds = modelAllAdsFromJson(jsonString);

// // import 'dart:convert';

// // ModelAllAds modelAllAdsFromJson(String str) =>
// //     ModelAllAds.fromJson(json.decode(str));

// // String modelAllAdsToJson(ModelAllAds data) => json.encode(data.toJson());

// // class ModelAllAds {
// //   bool status;
// //   List<ViewAds> data;

// //   ModelAllAds({
// //     required this.status,
// //     required this.data,
// //   });

// //   factory ModelAllAds.fromJson(Map<String, dynamic> json) => ModelAllAds(
// //         status: json["status"],
// //         data: List<ViewAds>.from(json["data"].map((x) => ViewAds.fromJson(x))),
// //       );

// //   Map<String, dynamic> toJson() => {
// //         "status": status,
// //         "data": List<dynamic>.from(data.map((x) => x.toJson())),
// //       };
// // }

// // class ViewAds {
// //   int adsId;
// //   String image;

// //   ViewAds({
// //     required this.adsId,
// //     required this.image,
// //   });

// //   factory ViewAds.fromJson(Map<String, dynamic> json) => ViewAds(
// //         adsId: json["ads_id"],
// //         image: json["image"],
// //       );

// //   Map<String, dynamic> toJson() => {
// //         "ads_id": adsId,
// //         "image": image,
// //       };
// // }

// // To parse this JSON data, do
// //
// //     final modelAllAds = modelAllAdsFromJson(jsonString);

// import 'dart:convert';

// ModelAllAds modelAllAdsFromJson(String str) =>
//     ModelAllAds.fromJson(json.decode(str));

// String modelAllAdsToJson(ModelAllAds data) => json.encode(data.toJson());

// class ModelAllAds {
//   bool status;
//   List<ViewAds> data;
//   int adsId;

//   ModelAllAds({
//     required this.status,
//     required this.data,
//     required this.adsId,
//   });

//   factory ModelAllAds.fromJson(Map<String, dynamic> json) => ModelAllAds(
//         status: json["status"],
//         data: List<ViewAds>.from(json["data"].map((x) => ViewAds.fromJson(x))),
//         adsId: json["ads_id"],
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//         "ads_id": adsId,
//       };
// }

// class ViewAds {
//   String ads;

//   ViewAds({
//     required this.ads,
//   });

//   factory ViewAds.fromJson(Map<String, dynamic> json) => ViewAds(
//         ads: json["ads"],
//       );

//   Map<String, dynamic> toJson() => {
//         "ads": ads,
//       };
// }



// To parse this JSON data, do
//
//     final modelAllAds = modelAllAdsFromJson(jsonString);

import 'dart:convert';

ModelAllAds modelAllAdsFromJson(String str) => ModelAllAds.fromJson(json.decode(str));

String modelAllAdsToJson(ModelAllAds data) => json.encode(data.toJson());

class ModelAllAds {
    List<Ad> ads;

    ModelAllAds({
        required this.ads,
    });

    factory ModelAllAds.fromJson(Map<String, dynamic> json) => ModelAllAds(
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
