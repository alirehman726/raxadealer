// // To parse this JSON data, do
// //
// //     final orderForm = orderFormFromJson(jsonString);

// import 'dart:convert';

// OrderForm orderFormFromJson(String str) => OrderForm.fromJson(json.decode(str));

// String orderFormToJson(OrderForm data) => json.encode(data.toJson());

// class OrderForm {
//     List<DeliveryData> deliveryData;
//     List<PendingOrder> pendingOrder;
//     bool status;

//     OrderForm({
//         required this.deliveryData,
//         required this.pendingOrder,
//         required this.status,
//     });

//     factory OrderForm.fromJson(Map<String, dynamic> json) => OrderForm(
//         deliveryData: List<DeliveryData>.from(json["delivery_data"].map((x) => DeliveryData.fromJson(x))),
//         pendingOrder: List<PendingOrder>.from(json["pending_order"].map((x) => PendingOrder.fromJson(x))),
//         status: json["status"],
//     );

//     Map<String, dynamic> toJson() => {
//         "delivery_data": List<dynamic>.from(deliveryData.map((x) => x.toJson())),
//         "pending_order": List<dynamic>.from(pendingOrder.map((x) => x.toJson())),
//         "status": status,
//     };
// }

// class DeliveryData {
//     int orderId;
//     int customerId;
//     int addressId;
//     int price;
//     int discountPrice;
//     int shippingCharge;
//     dynamic promocodeId;
//     int promocodeDiscount;
//     int totalPaybleAmount;
//     DateTime deliveryDate;
//     String orderStatus;
//     String paymentStatus;
//     dynamic paymentType;
//     dynamic eventId;
//     String createdAt;
//     String updatedAt;
//     String firstName;
//     dynamic lastName;
//     String contactNo;
//     String email;
//     String city;
//     String source;
//     String area;
//     String referralCode;
//     dynamic referredByCustomer;
//     String shortLinkCode;
//     String link;
//     String dnd;
//     String systemType;
//     dynamic religion;
//     // dynamic hashCode;
//     dynamic utmSource;
//     dynamic utmMedium;
//     dynamic utmCampaign;
//     dynamic utmTerm;
//     dynamic utmContent;

//     DeliveryData({
//         required this.orderId,
//         required this.customerId,
//         required this.addressId,
//         required this.price,
//         required this.discountPrice,
//         required this.shippingCharge,
//         this.promocodeId,
//         required this.promocodeDiscount,
//         required this.totalPaybleAmount,
//         required this.deliveryDate,
//         required this.orderStatus,
//         required this.paymentStatus,
//         this.paymentType,
//         this.eventId,
//         required this.createdAt,
//         required this.updatedAt,
//         required this.firstName,
//         this.lastName,
//         required this.contactNo,
//         required this.email,
//         required this.city,
//         required this.source,
//         required this.area,
//         required this.referralCode,
//         this.referredByCustomer,
//         required this.shortLinkCode,
//         required this.link,
//         required this.dnd,
//         required this.systemType,
//         this.religion,
//         // this.hashCode,
//         this.utmSource,
//         this.utmMedium,
//         this.utmCampaign,
//         this.utmTerm,
//         this.utmContent,
//     });

//     factory DeliveryData.fromJson(Map<String, dynamic> json) => DeliveryData(
//         orderId: json["order_id"] ?? "",
//         customerId: json["customer_id"] ?? "",
//         addressId: json["address_id"] ?? "",
//         price: json["price"] ?? "",
//         discountPrice: json["discount_price"] ?? "",
//         shippingCharge: json["shipping_charge"] ?? "",
//         promocodeId: json["promocode_id"] ?? "",
//         promocodeDiscount: json["promocode_discount"] ?? "",
//         totalPaybleAmount: json["total_payble_amount"] ?? "",
//         deliveryDate: DateTime.parse(json["delivery_date"]),
//         orderStatus: json["order_status"] ?? "",
//         paymentStatus: json["payment_status"] ?? "",
//         paymentType: json["payment_type"] ?? "",
//         eventId: json["event_id"] ?? "",
//         createdAt: json["created_at"] ?? "",
//         updatedAt: json["updated_at"] ?? "",
//         firstName: json["first_name"] ?? "",
//         lastName: json["last_name"] ?? "",
//         contactNo: json["contact_no"] ?? "",
//         email: json["email"] ?? "",
//         city: json["city"] ?? "",
//         source: json["source"] ?? "",
//         area: json["area"] ?? "",
//         referralCode: json["referral_code"] ?? "",
//         referredByCustomer: json["referred_by_customer"] ?? "",
//         shortLinkCode: json["short_link_code"] ?? "",
//         link: json["link"] ?? "",
//         dnd: json["dnd"] ?? "",
//         systemType: json["system_type"] ?? "",
//         religion: json["religion"] ?? "",
//         // hashCode: json["hash_code"] ?? "",
//         utmSource: json["utm_source"] ?? "",
//         utmMedium: json["utm_medium"] ?? "",
//         utmCampaign: json["utm_campaign"] ?? "",
//         utmTerm: json["utm_term"] ?? "",
//         utmContent: json["utm_content"] ?? "",
//     );

//     Map<String, dynamic> toJson() => {
//         "order_id": orderId,
//         "customer_id": customerId,
//         "address_id": addressId,
//         "price": price,
//         "discount_price": discountPrice,
//         "shipping_charge": shippingCharge,
//         "promocode_id": promocodeId,
//         "promocode_discount": promocodeDiscount,
//         "total_payble_amount": totalPaybleAmount,
//         "delivery_date": "${deliveryDate.year.toString().padLeft(4, '0')}-${deliveryDate.month.toString().padLeft(2, '0')}-${deliveryDate.day.toString().padLeft(2, '0')}",
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
//     };
// }

// class PendingOrder {
//     int pendingOrderCount;

//     PendingOrder({
//         required this.pendingOrderCount,
//     });

//     factory PendingOrder.fromJson(Map<String, dynamic> json) => PendingOrder(
//         pendingOrderCount: json["pending_order_count"] ?? "",
//     );

//     Map<String, dynamic> toJson() => {
//         "pending_order_count": pendingOrderCount,
//     };
// }

// To parse this JSON data, do
//
//     final orderForm = orderFormFromJson(jsonString);

import 'dart:convert';

OrderForm orderFormFromJson(String str) => OrderForm.fromJson(json.decode(str));

String orderFormToJson(OrderForm data) => json.encode(data.toJson());

class OrderForm {
  List<DeliveryData> deliveryData;
  List<PendingOrder> pendingOrder;
  bool status;

  OrderForm({
    required this.deliveryData,
    required this.pendingOrder,
    required this.status,
  });

  factory OrderForm.fromJson(Map<String, dynamic> json) => OrderForm(
        deliveryData: List<DeliveryData>.from(
            json["delivery_data"].map((x) => DeliveryData.fromJson(x))),
        pendingOrder: List<PendingOrder>.from(
            json["pending_order"].map((x) => PendingOrder.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "delivery_data":
            List<dynamic>.from(deliveryData.map((x) => x.toJson())),
        "pending_order":
            List<dynamic>.from(pendingOrder.map((x) => x.toJson())),
        "status": status,
      };
}

class DeliveryData {
  int orderId;
  int customerId;
  int addressId;
  int price;
  int discountPrice;
  int shippingCharge;
  dynamic promocodeId;
  int promocodeDiscount;
  int totalPaybleAmount;
  DateTime deliveryDate;
  String orderStatus;
  String orderType;
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
  String? source;
  String area;
  String referralCode;
  String? referredByCustomer;
  String shortLinkCode;
  String link;
  String dnd;
  String systemType;
  dynamic religion;
  // dynamic hashCode;
  String? utmSource;
  String? utmMedium;
  String? utmCampaign;
  String? utmTerm;
  String? utmContent;
  int customerAddressId;
  String name;
  int pincode;
  String building;
  String? landmark;
  String state;
  String mobile;
  String addressTitle;
  dynamic locationLink;
  String isDeleted;
  String apartmentName;
  String originalContactNo;

  DeliveryData({
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
    required this.orderType,
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
    this.source,
    required this.area,
    required this.referralCode,
    this.referredByCustomer,
    required this.shortLinkCode,
    required this.link,
    required this.dnd,
    required this.systemType,
    this.religion,
    // this.hashCode,
    this.utmSource,
    this.utmMedium,
    this.utmCampaign,
    this.utmTerm,
    this.utmContent,
    required this.customerAddressId,
    required this.name,
    required this.pincode,
    required this.building,
    this.landmark,
    required this.state,
    required this.mobile,
    required this.addressTitle,
    this.locationLink,
    required this.isDeleted,
    required this.apartmentName,
    required this.originalContactNo,
  });

  factory DeliveryData.fromJson(Map<String, dynamic> json) => DeliveryData(
        orderId: json["order_id"] ?? "",
        customerId: json["customer_id"] ?? "",
        addressId: json["address_id"] ?? "",
        price: json["price"] ?? "",
        discountPrice: json["discount_price"] ?? "",
        shippingCharge: json["shipping_charge"] ?? "",
        promocodeId: json["promocode_id"] ?? "",
        promocodeDiscount: json["promocode_discount"] ?? "",
        totalPaybleAmount: json["total_payble_amount"] ?? "",
        deliveryDate: DateTime.parse(json["delivery_date"]),
        orderStatus: json["order_status"] ?? "",
        orderType: json["order_type"] ?? "",
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
        apartmentName: json["apartment_name"] ?? "",
        originalContactNo: json["original_contact_no"] ?? "",
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
        "delivery_date":
            "${deliveryDate.year.toString().padLeft(4, '0')}-${deliveryDate.month.toString().padLeft(2, '0')}-${deliveryDate.day.toString().padLeft(2, '0')}",
        "order_status": orderStatus,
        "order_type": orderType,
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
        "apartment_name": apartmentName,
        "original_contact_no": originalContactNo,
      };
}

class PendingOrder {
  int pendingOrderCount;
  int deliveredCount;

  PendingOrder({
    required this.pendingOrderCount,
    required this.deliveredCount,
  });

  factory PendingOrder.fromJson(Map<String, dynamic> json) => PendingOrder(
        pendingOrderCount: json["pending_order_count"],
        deliveredCount: json["delivered_count"],
      );

  Map<String, dynamic> toJson() => {
        "pending_order_count": pendingOrderCount,
        "delivered_count": deliveredCount,
      };
}
