class GroupModel {
  String groupId;
  String groupName;
  List<GroupContact> contacts;
  bool isSpam;
  String createdAt;
  String updatedAt;
  String createdBy;
  bool isSelected;

  GroupModel({
    required this.groupId,
    required this.groupName,
    required this.contacts,
    required this.isSpam,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    this.isSelected = false
  });

  factory GroupModel.fromJson(Map<String, dynamic > json) => GroupModel(
    groupId: json['_id'],
    groupName: json['group_name'],
    contacts: json['contacts'],
    isSpam: json['is_spam'],
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt'],
    createdBy: json['created_by']
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = groupId;
    data['group_name'] = groupName;
    data['contacts'] = contacts;
    data['is_spam'] = isSpam;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['created_by'] = createdBy;

    return data;
  }

  @override
  String toString() {
    return "{ _id: $groupId,"
        "group_name: $groupName,"
        "contacts: $contacts,"
        "is_spam: $isSpam,"
        "createdAt: $createdAt,"
        "updatedAt: $updatedAt,"
        "created_by: $createdBy }";
  }
}

/// Convert String into GroupModal JSON
List<GroupModel> groupModalFromJson(data) {
  List<GroupModel> items = <GroupModel>[];
  for (var d in data) {
    d['contacts'] = groupContactModalFromJson(d['contacts']);
    GroupModel group = GroupModel.fromJson(d);
    items.add(group);
  }
  return items;
}

/// Convert String into GroupModal JsonObj
GroupModel groupModalObjFromJson(data) {
  data['contacts'] = groupContactModalFromJson(data['contacts']);
  return GroupModel.fromJson(data);
}

class GroupContact {
  String contactId;
  String userName;
  String mobileNumber;

  GroupContact({ required this.contactId, required this.userName, required this.mobileNumber });

  factory GroupContact.fromJson(Map<String, dynamic> json) => GroupContact(
    contactId: json['_id'],
    userName: json['user_name'],
    mobileNumber: json['mobile_number']
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = contactId;
    data['user_name'] = userName;
    data['mobile_number'] = mobileNumber;
    return data;
  }

  @override
  String toString() {
    return "{ _id: $contactId, user_name: $userName, mobile_number: $mobileNumber }";
  }
}

/// Convert String into GroupContactModal JSON
List<GroupContact> groupContactModalFromJson(data) {
  List<GroupContact> items = <GroupContact>[];
  for (var c in data) {
    GroupContact contact = GroupContact.fromJson(c);
    items.add(contact);
  }
  return items;
}