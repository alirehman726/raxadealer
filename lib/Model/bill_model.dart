// // To parse this JSON data, do
// //
// //     final billModel = billModelFromJson(jsonString);

// import 'dart:convert';

// BillModel billModelFromJson(String str) => BillModel.fromJson(json.decode(str));

// String billModelToJson(BillModel data) => json.encode(data.toJson());

// class BillModel {
//   Bill bill;
//   bool status;

//   BillModel({
//     required this.bill,
//     required this.status,
//   });

//   factory BillModel.fromJson(Map<String, dynamic> json) => BillModel(
//         bill: Bill.fromJson(json["bill"]),
//         status: json["status"],
//       );

//   Map<String, dynamic> toJson() => {
//         "bill": bill.toJson(),
//         "status": status,
//       };
// }

// class Bill {
//   List<OrderDetail> orderDetail;
//   List<CustomerDetail> customerDetail;
//   String? qrCode;

//   Bill({
//     required this.orderDetail,
//     required this.customerDetail,
//     required this.qrCode,
//   });

//   factory Bill.fromJson(Map<String, dynamic> json) => Bill(
//         orderDetail: List<OrderDetail>.from(
//             json["order_detail"].map((x) => OrderDetail.fromJson(x))),
//         customerDetail: List<CustomerDetail>.from(
//             json["customer_detail"].map((x) => CustomerDetail.fromJson(x))),
//         qrCode: json["qr_code"],
//       );

//   Map<String, dynamic> toJson() => {
//         "order_detail": List<dynamic>.from(orderDetail.map((x) => x.toJson())),
//         "customer_detail":
//             List<dynamic>.from(customerDetail.map((x) => x.toJson())),
//         "qr_code": qrCode,
//       };
// }

// class CustomerDetail {
//   int orderId;
//   int customerId;
//   int addressId;
//   int price;
//   int discountPrice;
//   int shippingCharge;
//   dynamic promocodeId;
//   int promocodeDiscount;
//   int totalPaybleAmount;
//   DateTime deliveryDate;
//   String orderStatus;
//   String paymentStatus;
//   dynamic paymentType;
//   dynamic eventId;
//   String createdAt;
//   String updatedAt;
//   String firstName;
//   String lastName;
//   String contactNo;
//   String email;
//   String city;
//   String source;
//   String area;
//   String referralCode;
//   String referredByCustomer;
//   String shortLinkCode;
//   String link;
//   String dnd;
//   String systemType;
//   dynamic religion;
//   // dynamic hashCode;
//   String utmSource;
//   String utmMedium;
//   String utmCampaign;
//   String utmTerm;
//   String utmContent;
//   int customerAddressId;
//   String name;
//   int pincode;
//   String building;
//   String landmark;
//   String state;
//   String mobile;
//   String addressTitle;
//   dynamic locationLink;
//   String isDeleted;

//   CustomerDetail({
//     required this.orderId,
//     required this.customerId,
//     required this.addressId,
//     required this.price,
//     required this.discountPrice,
//     required this.shippingCharge,
//     this.promocodeId,
//     required this.promocodeDiscount,
//     required this.totalPaybleAmount,
//     required this.deliveryDate,
//     required this.orderStatus,
//     required this.paymentStatus,
//     this.paymentType,
//     this.eventId,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.firstName,
//     required this.lastName,
//     required this.contactNo,
//     required this.email,
//     required this.city,
//     required this.source,
//     required this.area,
//     required this.referralCode,
//     required this.referredByCustomer,
//     required this.shortLinkCode,
//     required this.link,
//     required this.dnd,
//     required this.systemType,
//     this.religion,
//     // this.hashCode,
//     required this.utmSource,
//     required this.utmMedium,
//     required this.utmCampaign,
//     required this.utmTerm,
//     required this.utmContent,
//     required this.customerAddressId,
//     required this.name,
//     required this.pincode,
//     required this.building,
//     required this.landmark,
//     required this.state,
//     required this.mobile,
//     required this.addressTitle,
//     this.locationLink,
//     required this.isDeleted,
//   });

//   factory CustomerDetail.fromJson(Map<String, dynamic> json) => CustomerDetail(
//         orderId: json["order_id"],
//         customerId: json["customer_id"],
//         addressId: json["address_id"],
//         price: json["price"],
//         discountPrice: json["discount_price"],
//         shippingCharge: json["shipping_charge"],
//         promocodeId: json["promocode_id"] ?? "",
//         promocodeDiscount: json["promocode_discount"],
//         totalPaybleAmount: json["total_payble_amount"],
//         deliveryDate: DateTime.parse(json["delivery_date"]),
//         orderStatus: json["order_status"],
//         paymentStatus: json["payment_status"],
//         paymentType: json["payment_type"] ?? "",
//         eventId: json["event_id"] ?? "",
//         createdAt: json["created_at"],
//         updatedAt: json["updated_at"],
//         firstName: json["first_name"],
//         lastName: json["last_name"],
//         contactNo: json["contact_no"],
//         email: json["email"],
//         city: json["city"],
//         source: json["source"],
//         area: json["area"],
//         referralCode: json["referral_code"],
//         referredByCustomer: json["referred_by_customer"],
//         shortLinkCode: json["short_link_code"],
//         link: json["link"],
//         dnd: json["dnd"],
//         systemType: json["system_type"],
//         religion: json["religion"] ?? "",
//         // hashCode: json["hash_code"],
//         utmSource: json["utm_source"],
//         utmMedium: json["utm_medium"],
//         utmCampaign: json["utm_campaign"],
//         utmTerm: json["utm_term"],
//         utmContent: json["utm_content"],
//         customerAddressId: json["customer_address_id"],
//         name: json["name"],
//         pincode: json["pincode"],
//         building: json["building"],
//         landmark: json["landmark"],
//         state: json["state"],
//         mobile: json["mobile"],
//         addressTitle: json["address_title"],
//         locationLink: json["location_link"] ?? "",
//         isDeleted: json["is_deleted"],
//       );

//   Map<String, dynamic> toJson() => {
//         "order_id": orderId,
//         "customer_id": customerId,
//         "address_id": addressId,
//         "price": price,
//         "discount_price": discountPrice,
//         "shipping_charge": shippingCharge,
//         "promocode_id": promocodeId,
//         "promocode_discount": promocodeDiscount,
//         "total_payble_amount": totalPaybleAmount,
//         "delivery_date":
//             "${deliveryDate.year.toString().padLeft(4, '0')}-${deliveryDate.month.toString().padLeft(2, '0')}-${deliveryDate.day.toString().padLeft(2, '0')}",
//         "order_status": orderStatus,
//         "payment_status": paymentStatus,
//         "payment_type": paymentType,
//         "event_id": eventId,
//         "created_at": createdAt,
//         "updated_at": updatedAt,
//         "first_name": firstName,
//         "last_name": lastName,
//         "contact_no": contactNo,
//         "email": email,
//         "city": city,
//         "source": source,
//         "area": area,
//         "referral_code": referralCode,
//         "referred_by_customer": referredByCustomer,
//         "short_link_code": shortLinkCode,
//         "link": link,
//         "dnd": dnd,
//         "system_type": systemType,
//         "religion": religion,
//         // "hash_code": hashCode,
//         "utm_source": utmSource,
//         "utm_medium": utmMedium,
//         "utm_campaign": utmCampaign,
//         "utm_term": utmTerm,
//         "utm_content": utmContent,
//         "customer_address_id": customerAddressId,
//         "name": name,
//         "pincode": pincode,
//         "building": building,
//         "landmark": landmark,
//         "state": state,
//         "mobile": mobile,
//         "address_title": addressTitle,
//         "location_link": locationLink,
//         "is_deleted": isDeleted,
//       };
// }

// class OrderDetail {
//   int orderDetailId;
//   int orderId;
//   int subscriptionId;
//   String orderType;
//   String orderStatus;
//   int productId;
//   int qty;
//   String package;
//   String? varientTexture;
//   int productMrp;
//   int productDiscountPrice;
//   int shippingCharge;
//   int promocodeDiscount;
//   int totalPrice;
//   DateTime deliveryDate;
//   String createdAt;
//   int productPackageId;
//   String productPackageVarient;
//   int mrp;
//   int discountPrice;
//   String subscribeDescription;
//   String isVisible;
//   String isDelete;
//   String createdDate;
//   String updatedDate;
//   int customerId;
//   int addressId;
//   int price;
//   dynamic promocodeId;
//   int totalPaybleAmount;
//   String paymentStatus;
//   dynamic paymentType;
//   dynamic eventId;
//   String updatedAt;
//   int categoryId;
//   int subCategoryId;
//   String srNo;
//   String productName;
//   dynamic productPackage;
//   String productType;
//   String normalProductId;
//   String productSlug;
//   String description;
//   String uspImage1;
//   String uspImageText1;
//   String uspImage2;
//   String uspImageText2;
//   String uspImage3;
//   String uspImageText3;
//   String nutritionalTitle1;
//   String nutritionalDescription1;
//   String nutritionalTitle2;
//   String nutritionalDescription2;
//   String healthBenefits;
//   String isDeleted;
//   dynamic materialId;
//   dynamic materialCode;
//   String createdBy;
//   int variantId;
//   String variant;
//   String variantSlug;
//   String Image;

//   OrderDetail({
//     required this.orderDetailId,
//     required this.orderId,
//     required this.subscriptionId,
//     required this.orderType,
//     required this.orderStatus,
//     required this.productId,
//     required this.qty,
//     required this.package,
//     this.varientTexture,
//     required this.productMrp,
//     required this.productDiscountPrice,
//     required this.shippingCharge,
//     required this.promocodeDiscount,
//     required this.totalPrice,
//     required this.deliveryDate,
//     required this.createdAt,
//     required this.productPackageId,
//     required this.productPackageVarient,
//     required this.mrp,
//     required this.discountPrice,
//     required this.subscribeDescription,
//     required this.isVisible,
//     required this.isDelete,
//     required this.createdDate,
//     required this.updatedDate,
//     required this.customerId,
//     required this.addressId,
//     required this.price,
//     this.promocodeId,
//     required this.totalPaybleAmount,
//     required this.paymentStatus,
//     this.paymentType,
//     this.eventId,
//     required this.updatedAt,
//     required this.categoryId,
//     required this.subCategoryId,
//     required this.srNo,
//     required this.productName,
//     this.productPackage,
//     required this.productType,
//     required this.normalProductId,
//     required this.productSlug,
//     required this.description,
//     required this.uspImage1,
//     required this.uspImageText1,
//     required this.uspImage2,
//     required this.uspImageText2,
//     required this.uspImage3,
//     required this.uspImageText3,
//     required this.nutritionalTitle1,
//     required this.nutritionalDescription1,
//     required this.nutritionalTitle2,
//     required this.nutritionalDescription2,
//     required this.healthBenefits,
//     required this.isDeleted,
//     this.materialId,
//     this.materialCode,
//     required this.createdBy,
//     required this.variantId,
//     required this.variant,
//     required this.variantSlug,
//     required this.Image,
//   });

//   factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
//         orderDetailId: json["order_detail_id"],
//         orderId: json["order_id"],
//         subscriptionId: json["subscription_id"],
//         orderType: json["order_type"],
//         orderStatus: json["order_status"],
//         productId: json["product_id"],
//         qty: json["qty"],
//         package: json["package"],
//         varientTexture: json["varient_texture"],
//         productMrp: json["product_mrp"],
//         productDiscountPrice: json["product_discount_price"],
//         shippingCharge: json["shipping_charge"],
//         promocodeDiscount: json["promocode_discount"],
//         totalPrice: json["total_price"],
//         deliveryDate: DateTime.parse(json["delivery_date"]),
//         createdAt: json["created_at"],
//         productPackageId: json["product_package_id"],
//         productPackageVarient: json["product_package_varient"],
//         mrp: json["mrp"],
//         discountPrice: json["discount_price"],
//         subscribeDescription: json["subscribe_description"] ?? "",
//         isVisible: json["is_visible"],
//         isDelete: json["is_delete"],
//         createdDate: json["created_date"],
//         updatedDate: json["updated_date"],
//         customerId: json["customer_id"],
//         addressId: json["address_id"],
//         price: json["price"],
//         promocodeId: json["promocode_id"] ?? "",
//         totalPaybleAmount: json["total_payble_amount"],
//         paymentStatus: json["payment_status"],
//         paymentType: json["payment_type"] ?? "",
//         eventId: json["event_id"] ?? "",
//         updatedAt: json["updated_at"],
//         categoryId: json["category_id"],
//         subCategoryId: json["sub_category_id"],
//         srNo: json["sr_no"],
//         productName: json["product_name"],
//         productPackage: json["product_package"] ?? "",
//         productType: json["product_type"],
//         normalProductId: json["normal_product_id"],
//         productSlug: json["product_slug"],
//         description: json["description"],
//         uspImage1: json["usp_image_1"],
//         uspImageText1: json["usp_image_text_1"],
//         uspImage2: json["usp_image_2"],
//         uspImageText2: json["usp_image_text_2"],
//         uspImage3: json["usp_image_3"],
//         uspImageText3: json["usp_image_text_3"],
//         nutritionalTitle1: json["nutritional_title_1"],
//         nutritionalDescription1: json["nutritional_description_1"],
//         nutritionalTitle2: json["nutritional_title_2"],
//         nutritionalDescription2: json["nutritional_description_2"],
//         healthBenefits: json["health_benefits"],
//         isDeleted: json["is_deleted"],
//         materialId: json["material_id"] ?? "",
//         materialCode: json["material_code"] ?? "",
//         createdBy: json["created_by"],
//         variantId: json["variant_id"],
//         variant: json["variant"],
//         variantSlug: json["variant_slug"],
//         Image: json["image"],
//       );

//   Map<String, dynamic> toJson() => {
//         "order_detail_id": orderDetailId,
//         "order_id": orderId,
//         "subscription_id": subscriptionId,
//         "order_type": orderType,
//         "order_status": orderStatus,
//         "product_id": productId,
//         "qty": qty,
//         "package": package,
//         "varient_texture": varientTexture,
//         "product_mrp": productMrp,
//         "product_discount_price": productDiscountPrice,
//         "shipping_charge": shippingCharge,
//         "promocode_discount": promocodeDiscount,
//         "total_price": totalPrice,
//         "delivery_date":
//             "${deliveryDate.year.toString().padLeft(4, '0')}-${deliveryDate.month.toString().padLeft(2, '0')}-${deliveryDate.day.toString().padLeft(2, '0')}",
//         "created_at": createdAt,
//         "product_package_id": productPackageId,
//         "product_package_varient": productPackageVarient,
//         "mrp": mrp,
//         "discount_price": discountPrice,
//         "subscribe_description": subscribeDescription,
//         "is_visible": isVisible,
//         "is_delete": isDelete,
//         "created_date": createdDate,
//         "updated_date": updatedDate,
//         "customer_id": customerId,
//         "address_id": addressId,
//         "price": price,
//         "promocode_id": promocodeId,
//         "total_payble_amount": totalPaybleAmount,
//         "payment_status": paymentStatus,
//         "payment_type": paymentType,
//         "event_id": eventId,
//         "updated_at": updatedAt,
//         "category_id": categoryId,
//         "sub_category_id": subCategoryId,
//         "sr_no": srNo,
//         "product_name": productName,
//         "product_package": productPackage,
//         "product_type": productType,
//         "normal_product_id": normalProductId,
//         "product_slug": productSlug,
//         "description": description,
//         "usp_image_1": uspImage1,
//         "usp_image_text_1": uspImageText1,
//         "usp_image_2": uspImage2,
//         "usp_image_text_2": uspImageText2,
//         "usp_image_3": uspImage3,
//         "usp_image_text_3": uspImageText3,
//         "nutritional_title_1": nutritionalTitle1,
//         "nutritional_description_1": nutritionalDescription1,
//         "nutritional_title_2": nutritionalTitle2,
//         "nutritional_description_2": nutritionalDescription2,
//         "health_benefits": healthBenefits,
//         "is_deleted": isDeleted,
//         "material_id": materialId,
//         "material_code": materialCode,
//         "created_by": createdBy,
//         "variant_id": variantId,
//         "variant": variant,
//         "variant_slug": variantSlug,
//         "image": Image,
//       };
// }

// To parse this JSON data, do
//
//     final billModel = billModelFromJson(jsonString);

import 'dart:convert';

BillModel billModelFromJson(String str) => BillModel.fromJson(json.decode(str));

String billModelToJson(BillModel data) => json.encode(data.toJson());

class BillModel {
  Bill bill;
  bool status;

  BillModel({
    required this.bill,
    required this.status,
  });

  factory BillModel.fromJson(Map<String, dynamic> json) => BillModel(
        bill: Bill.fromJson(json["bill"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "bill": bill.toJson(),
        "status": status,
      };
}

class Bill {
  List<OrderDetail> orderDetails;
  List<CustomerDetail> customerDetail;
  String qrCode;

  Bill({
    required this.orderDetails,
    required this.customerDetail,
    required this.qrCode,
  });

  factory Bill.fromJson(Map<String, dynamic> json) => Bill(
        orderDetails: List<OrderDetail>.from(
            json["order_details"].map((x) => OrderDetail.fromJson(x))),
        customerDetail: List<CustomerDetail>.from(
            json["customer_detail"].map((x) => CustomerDetail.fromJson(x))),
        qrCode: json["qr_code"],
      );

  Map<String, dynamic> toJson() => {
        "order_details":
            List<dynamic>.from(orderDetails.map((x) => x.toJson())),
        "customer_detail":
            List<dynamic>.from(customerDetail.map((x) => x.toJson())),
        "qr_code": qrCode,
      };
}

class CustomerDetail {
  int orderId;
  int customerId;
  int addressId;
  int price;
  int discountPrice;
  int shippingCharge;
  dynamic promocodeId;
  int promocodeDiscount;
  int totalPaybleAmount;
  String deliveryDate;
  String orderStatus;
  String paymentStatus;
  dynamic paymentType;
  dynamic eventId;
  String createdAt;
  String updatedAt;
  String firstName;
  String lastName;
  String contactNo;
  String email;
  String city;
  String source;
  String area;
  String referralCode;
  String referredByCustomer;
  String shortLinkCode;
  String link;
  String dnd;
  String systemType;
  dynamic religion;
  // dynamic hashCode;
  String utmSource;
  String utmMedium;
  String utmCampaign;
  String utmTerm;
  String utmContent;
  int customerAddressId;
  String name;
  int pincode;
  String building;
  String landmark;
  String state;
  String mobile;
  String addressTitle;
  dynamic locationLink;
  String isDeleted;
  String latitude;
  String longitude;

  CustomerDetail({
    required this.orderId,
    required this.customerId,
    required this.addressId,
    required this.price,
    required this.discountPrice,
    required this.shippingCharge,
    this.promocodeId,
    required this.promocodeDiscount,
    required this.totalPaybleAmount,
    required this.deliveryDate,
    required this.orderStatus,
    required this.paymentStatus,
    this.paymentType,
    this.eventId,
    required this.createdAt,
    required this.updatedAt,
    required this.firstName,
    required this.lastName,
    required this.contactNo,
    required this.email,
    required this.city,
    required this.source,
    required this.area,
    required this.referralCode,
    required this.referredByCustomer,
    required this.shortLinkCode,
    required this.link,
    required this.dnd,
    required this.systemType,
    this.religion,
    // this.hashCode,
    required this.utmSource,
    required this.utmMedium,
    required this.utmCampaign,
    required this.utmTerm,
    required this.utmContent,
    required this.customerAddressId,
    required this.name,
    required this.pincode,
    required this.building,
    required this.landmark,
    required this.state,
    required this.mobile,
    required this.addressTitle,
    this.locationLink,
    required this.isDeleted,
    required this.latitude,
    required this.longitude,
  });

  factory CustomerDetail.fromJson(Map<String, dynamic> json) => CustomerDetail(
        orderId: json["order_id"] ?? "",
        customerId: json["customer_id"] ?? "",
        addressId: json["address_id"] ?? "",
        price: json["price"] ?? "",
        discountPrice: json["discount_price"] ?? "",
        shippingCharge: json["shipping_charge"] ?? "",
        promocodeId: json["promocode_id"] ?? "",
        promocodeDiscount: json["promocode_discount"] ?? "",
        totalPaybleAmount: json["total_payble_amount"] ?? "",
        deliveryDate: json["delivery_date"] ?? "",
        orderStatus: json["order_status"] ?? "",
        paymentStatus: json["payment_status"] ?? "",
        paymentType: json["payment_type"] ?? "",
        eventId: json["event_id"] ?? "",
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
        firstName: json["first_name"] ?? "",
        lastName: json["last_name"] ?? "",
        contactNo: json["contact_no"] ?? "",
        email: json["email"] ?? "",
        city: json["city"] ?? "",
        source: json["source"] ?? "",
        area: json["area"] ?? "",
        referralCode: json["referral_code"] ?? "",
        referredByCustomer: json["referred_by_customer"] ?? "",
        shortLinkCode: json["short_link_code"] ?? "",
        link: json["link"] ?? "",
        dnd: json["dnd"] ?? "",
        systemType: json["system_type"] ?? "",
        religion: json["religion"] ?? "",
        // hashCode: json["hash_code"] ?? "",
        utmSource: json["utm_source"] ?? "",
        utmMedium: json["utm_medium"] ?? "",
        utmCampaign: json["utm_campaign"] ?? "",
        utmTerm: json["utm_term"] ?? "",
        utmContent: json["utm_content"] ?? "",
        customerAddressId: json["customer_address_id"] ?? "",
        name: json["name"] ?? "",
        pincode: json["pincode"] ?? "",
        building: json["building"] ?? "",
        landmark: json["landmark"] ?? "",
        state: json["state"] ?? "",
        mobile: json["mobile"] ?? "",
        addressTitle: json["address_title"] ?? "",
        locationLink: json["location_link"] ?? "",
        isDeleted: json["is_deleted"] ?? "",
        latitude: json["latitude"] ?? "",
        longitude: json["longitude"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "customer_id": customerId,
        "address_id": addressId,
        "price": price,
        "discount_price": discountPrice,
        "shipping_charge": shippingCharge,
        "promocode_id": promocodeId,
        "promocode_discount": promocodeDiscount,
        "total_payble_amount": totalPaybleAmount,
        // "delivery_date":
        //     "${deliveryDate.year.toString().padLeft(4, '0')}-${deliveryDate.month.toString().padLeft(2, '0')}-${deliveryDate.day.toString().padLeft(2, '0')}",
        "delivery_date": deliveryDate,
        "order_status": orderStatus,
        "payment_status": paymentStatus,
        "payment_type": paymentType,
        "event_id": eventId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "first_name": firstName,
        "last_name": lastName,
        "contact_no": contactNo,
        "email": email,
        "city": city,
        "source": source,
        "area": area,
        "referral_code": referralCode,
        "referred_by_customer": referredByCustomer,
        "short_link_code": shortLinkCode,
        "link": link,
        "dnd": dnd,
        "system_type": systemType,
        "religion": religion,
        // "hash_code": hashCode,
        "utm_source": utmSource,
        "utm_medium": utmMedium,
        "utm_campaign": utmCampaign,
        "utm_term": utmTerm,
        "utm_content": utmContent,
        "customer_address_id": customerAddressId,
        "name": name,
        "pincode": pincode,
        "building": building,
        "landmark": landmark,
        "state": state,
        "mobile": mobile,
        "address_title": addressTitle,
        "location_link": locationLink,
        "is_deleted": isDeleted,
        "latitude": latitude,
        "longitude": longitude,
      };
}

class OrderDetail {
  int orderDetailId;
  int orderId;
  int subscriptionId;
  String orderType;
  String orderStatus;
  int productId;
  int qty;
  String package;
  String? varientTexture;
  int productMrp;
  int productDiscountPrice;
  int shippingCharge;
  int promocodeDiscount;
  int totalPrice;
  DateTime deliveryDate;
  String createdAt;
  int productPackageId;
  String productPackageVarient;
  int mrp;
  int discountPrice;
  String? subscribeDescription;
  String isVisible;
  String isDelete;
  String createdDate;
  String updatedDate;
  int customerId;
  int addressId;
  int price;
  dynamic promocodeId;
  int totalPaybleAmount;
  String paymentStatus;
  dynamic paymentType;
  dynamic eventId;
  String updatedAt;
  int categoryId;
  int subCategoryId;
  String srNo;
  String productName;
  dynamic productPackage;
  String productType;
  String normalProductId;
  String productSlug;
  String description;
  String uspImage1;
  String uspImageText1;
  String uspImage2;
  String uspImageText2;
  String uspImage3;
  String uspImageText3;
  String nutritionalTitle1;
  String nutritionalDescription1;
  String nutritionalTitle2;
  String nutritionalDescription2;
  String healthBenefits;
  String isDeleted;
  dynamic materialId;
  dynamic materialCode;
  String createdBy;
  int variantId;
  String variant;
  String variantSlug;
  String image;

  OrderDetail({
    required this.orderDetailId,
    required this.orderId,
    required this.subscriptionId,
    required this.orderType,
    required this.orderStatus,
    required this.productId,
    required this.qty,
    required this.package,
    this.varientTexture,
    required this.productMrp,
    required this.productDiscountPrice,
    required this.shippingCharge,
    required this.promocodeDiscount,
    required this.totalPrice,
    required this.deliveryDate,
    required this.createdAt,
    required this.productPackageId,
    required this.productPackageVarient,
    required this.mrp,
    required this.discountPrice,
    this.subscribeDescription,
    required this.isVisible,
    required this.isDelete,
    required this.createdDate,
    required this.updatedDate,
    required this.customerId,
    required this.addressId,
    required this.price,
    this.promocodeId,
    required this.totalPaybleAmount,
    required this.paymentStatus,
    this.paymentType,
    this.eventId,
    required this.updatedAt,
    required this.categoryId,
    required this.subCategoryId,
    required this.srNo,
    required this.productName,
    this.productPackage,
    required this.productType,
    required this.normalProductId,
    required this.productSlug,
    required this.description,
    required this.uspImage1,
    required this.uspImageText1,
    required this.uspImage2,
    required this.uspImageText2,
    required this.uspImage3,
    required this.uspImageText3,
    required this.nutritionalTitle1,
    required this.nutritionalDescription1,
    required this.nutritionalTitle2,
    required this.nutritionalDescription2,
    required this.healthBenefits,
    required this.isDeleted,
    this.materialId,
    this.materialCode,
    required this.createdBy,
    required this.variantId,
    required this.variant,
    required this.variantSlug,
    required this.image,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
        orderDetailId: json["order_detail_id"] ?? "",
        orderId: json["order_id"] ?? "",
        subscriptionId: json["subscription_id"] ?? "",
        orderType: json["order_type"] ?? "",
        orderStatus: json["order_status"] ?? "",
        productId: json["product_id"] ?? "",
        qty: json["qty"] ?? "",
        package: json["package"] ?? "",
        varientTexture: json["varient_texture"] ?? "",
        productMrp: json["product_mrp"] ?? "",
        productDiscountPrice: json["product_discount_price"] ?? "",
        shippingCharge: json["shipping_charge"] ?? "",
        promocodeDiscount: json["promocode_discount"] ?? "",
        totalPrice: json["total_price"] ?? "",
        deliveryDate: DateTime.parse(json["delivery_date"] ?? ""),
        createdAt: json["created_at"] ?? "",
        productPackageId: json["product_package_id"] ?? "",
        productPackageVarient: json["product_package_varient"] ?? "",
        mrp: json["mrp"] ?? "",
        discountPrice: json["discount_price"] ?? "",
        subscribeDescription: json["subscribe_description"] ?? "",
        isVisible: json["is_visible"] ?? "",
        isDelete: json["is_delete"] ?? "",
        createdDate: json["created_date"] ?? "",
        updatedDate: json["updated_date"] ?? "",
        customerId: json["customer_id"] ?? "",
        addressId: json["address_id"] ?? "",
        price: json["price"] ?? "",
        promocodeId: json["promocode_id"] ?? "",
        totalPaybleAmount: json["total_payble_amount"] ?? "",
        paymentStatus: json["payment_status"] ?? "",
        paymentType: json["payment_type"] ?? "",
        eventId: json["event_id"] ?? "",
        updatedAt: json["updated_at"] ?? "",
        categoryId: json["category_id"] ?? "",
        subCategoryId: json["sub_category_id"] ?? "",
        srNo: json["sr_no"] ?? "",
        productName: json["product_name"] ?? "",
        productPackage: json["product_package"] ?? "",
        productType: json["product_type"] ?? "",
        normalProductId: json["normal_product_id"] ?? "",
        productSlug: json["product_slug"] ?? "",
        description: json["description"] ?? "",
        uspImage1: json["usp_image_1"] ?? "",
        uspImageText1: json["usp_image_text_1"] ?? "",
        uspImage2: json["usp_image_2"] ?? "",
        uspImageText2: json["usp_image_text_2"] ?? "",
        uspImage3: json["usp_image_3"] ?? "",
        uspImageText3: json["usp_image_text_3"] ?? "",
        nutritionalTitle1: json["nutritional_title_1"] ?? "",
        nutritionalDescription1: json["nutritional_description_1"] ?? "",
        nutritionalTitle2: json["nutritional_title_2"] ?? "",
        nutritionalDescription2: json["nutritional_description_2"] ?? "",
        healthBenefits: json["health_benefits"] ?? "",
        isDeleted: json["is_deleted"] ?? "",
        materialId: json["material_id"] ?? "",
        materialCode: json["material_code"] ?? "",
        createdBy: json["created_by"] ?? "",
        variantId: json["variant_id"] ?? "",
        variant: json["variant"] ?? "",
        variantSlug: json["variant_slug"] ?? "",
        image: json["image"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "order_detail_id": orderDetailId,
        "order_id": orderId,
        "subscription_id": subscriptionId,
        "order_type": orderType,
        "order_status": orderStatus,
        "product_id": productId,
        "qty": qty,
        "package": package,
        "varient_texture": varientTexture,
        "product_mrp": productMrp,
        "product_discount_price": productDiscountPrice,
        "shipping_charge": shippingCharge,
        "promocode_discount": promocodeDiscount,
        "total_price": totalPrice,
        "delivery_date":
            "${deliveryDate.year.toString().padLeft(4, '0')}-${deliveryDate.month.toString().padLeft(2, '0')}-${deliveryDate.day.toString().padLeft(2, '0')}",
        "created_at": createdAt,
        "product_package_id": productPackageId,
        "product_package_varient": productPackageVarient,
        "mrp": mrp,
        "discount_price": discountPrice,
        "subscribe_description": subscribeDescription,
        "is_visible": isVisible,
        "is_delete": isDelete,
        "created_date": createdDate,
        "updated_date": updatedDate,
        "customer_id": customerId,
        "address_id": addressId,
        "price": price,
        "promocode_id": promocodeId,
        "total_payble_amount": totalPaybleAmount,
        "payment_status": paymentStatus,
        "payment_type": paymentType,
        "event_id": eventId,
        "updated_at": updatedAt,
        "category_id": categoryId,
        "sub_category_id": subCategoryId,
        "sr_no": srNo,
        "product_name": productName,
        "product_package": productPackage,
        "product_type": productType,
        "normal_product_id": normalProductId,
        "product_slug": productSlug,
        "description": description,
        "usp_image_1": uspImage1,
        "usp_image_text_1": uspImageText1,
        "usp_image_2": uspImage2,
        "usp_image_text_2": uspImageText2,
        "usp_image_3": uspImage3,
        "usp_image_text_3": uspImageText3,
        "nutritional_title_1": nutritionalTitle1,
        "nutritional_description_1": nutritionalDescription1,
        "nutritional_title_2": nutritionalTitle2,
        "nutritional_description_2": nutritionalDescription2,
        "health_benefits": healthBenefits,
        "is_deleted": isDeleted,
        "material_id": materialId,
        "material_code": materialCode,
        "created_by": createdBy,
        "variant_id": variantId,
        "variant": variant,
        "variant_slug": variantSlug,
        "image": image,
      };
}
