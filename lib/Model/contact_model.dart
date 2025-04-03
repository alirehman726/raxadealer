import 'dart:convert';

class ContactModal {
  String userName, mobileNumber;
  bool isSelected;

  ContactModal({ required this.userName, required this.mobileNumber, required this.isSelected });

  factory ContactModal.fromJson(Map<String, dynamic> json) => ContactModal(
    userName: json['user_name'],
    mobileNumber: json['mobile_number'],
    isSelected: true
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_name'] = userName;
    data['mobile_number'] = "+91${mobileNumber.replaceAll("+91", "").replaceAll(RegExp('[)( -]'), "")}";
    return data;
  }

  @override
  String toString() {
    return "{ user_name: $userName, mobile_number: $mobileNumber, is_selected: $isSelected}";
  }


  /// Convert json into ContactModal List
  List<ContactModal> contactModalFromJson(data) {
    List<ContactModal> items = <ContactModal>[];
    for (var c in data) {
      ContactModal contact = ContactModal.fromJson(c);
      items.add(contact);
    }
    return items;
  }

  /// Convert ContactModal List into Array
  String contactModalToJsonArray(List<ContactModal> items) {
    return jsonEncode(items.map((e) => e.toJson()).toList());
  }

  /// Convert ContactModal List into String
  String contactModalToJson(ContactModal data) => json.encode(data.toJson());
}