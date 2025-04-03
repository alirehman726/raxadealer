import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:raxaadmin/utils/color.dart';

class TicketModel {
  String ticketId;
  String title;
  String description;
  String userName;
  String userEmail;
  List<dynamic> attachments;
  int status;
  String createdAt;
  List<TicketReply> replies;

  TicketModel({
    required this.ticketId,
    required this.title,
    required this.description,
    required this.userName,
    required this.userEmail,
    required this.attachments,
    required this.status,
    required this.createdAt,
    required this.replies,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) => TicketModel(
      ticketId: json['_id'],
      title: json['title'],
      description: json['description'],
      userName: json['user_name'],
      userEmail: json['user_email'],
      attachments: json['attachments'] ?? <dynamic>[],
      status: json['status'],
      createdAt: json['createdAt'],
      replies: json['replies'] ?? <TicketReply>[]);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ticketId'] = ticketId;
    data['title'] = title;
    data['description'] = description;
    data['user_name'] = userName;
    data['user_email'] = userEmail;
    data['attachments'] = attachments;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['replies'] = replies;
    return data;
  }

  @override
  String toString() {
    return "{ticketId=$ticketId, "
        "title=$title, "
        "description=$description, "
        "user_name=$userName, "
        "user_email=$userEmail, "
        "attachments=$attachments, "
        "status=$status, "
        "createdAt=$createdAt, "
        "replies=$replies}";
  }
}

class TicketReply {
  String replyId;
  String message;
  List<dynamic> attachments;
  String createdAt;
  String updatedAt;
  TicketUser user;
  TicketUser team;

  TicketReply(
      {required this.replyId,
      required this.message,
      required this.attachments,
      required this.createdAt,
      required this.updatedAt,
      required this.user,
      required this.team});

  factory TicketReply.fromJson(Map<String, dynamic> json) => TicketReply(
        replyId: json['_id'],
        message: json['reply_message'],
        attachments: json['attachments'] ?? <dynamic>[],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        user: json['user'] ?? null,
        team: json['team'] ?? null,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = replyId;
    data['reply_message'] = message;
    data['attachments'] = attachments;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['user'] = user;
    data['team'] = team;

    return data;
  }

  @override
  String toString() {
    return "{ _id: $replyId, reply_message: $message, attachments: $attachments, createdAt: $createdAt, updatedAt: $updatedAt, user: $user, team: $team }";
  }
}

class TicketUser {
  String? firstName;
  String? lastName;

  TicketUser({this.firstName, this.lastName});

  factory TicketUser.fromJson(Map<String, dynamic> json) => TicketUser(
      firstName: json['first_name'] ?? '', lastName: json['last_name'] ?? '');

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    return data;
  }

  @override
  String toString() {
    return "{ first_name: $firstName, last_name: $lastName }";
  }
}

/// Convert String into TicketModal JSON Array
List<TicketModel> ticketModalFromJson(data) {
  List<TicketModel> items = <TicketModel>[];
  for (var d in data) {
    if (d['replies'] != null) {
      d['replies'] = ticketRepliesModalFromJson(d['replies']);
    }
    TicketModel ticket = TicketModel.fromJson(d);
    items.add(ticket);
  }
  return items;
}

/// Convert String into TicketModal JSON
TicketModel ticketModalObjFromJson(data) {
  if (data["replies"] != null) {
    data["replies"] = ticketRepliesModalFromJson(data["replies"]);
  }
  return TicketModel.fromJson(data);
}

/// Convert String into TicketReply Modal JSON
List<TicketReply> ticketRepliesModalFromJson(data) {
  List<TicketReply> items = <TicketReply>[];
  for (var d in data) {
    if (d['user'] != null || d['user']['first_name'] != null) {
      d['user'] = ticketUserModalFromJson(d['user']);
    }
    if (d['team'] != null || d['team']['first_name'] != null) {
      d['team'] = ticketUserModalFromJson(d['team']);
    }
    TicketReply ticketReply = TicketReply.fromJson(d);
    items.add(ticketReply);
  }
  return items;
}

/// Convert String into TicketUser Modal JSON
TicketUser ticketUserModalFromJson(data) {
  return TicketUser.fromJson(data);
}

/// Get Ticket Status Text
String getTicketStatusTitle(int status) {
  final String st;
  switch (status) {
    case 0:
      st = 'Close';
      break;
    case 1:
      st = 'Open';
      break;
    case 2:
      st = 'Pending';
      break;
    default:
      st = '';
      break;
  }
  return st;
}

/// Get Ticket Color
Color getTicketStatusColor(int status) {
  final Color color;
  switch (status) {
    case 0:
      color = primaryColor;
      break;
    case 1:
      color = darkGreenColor;
      break;
    case 2:
      color = darkRedColor;
      break;
    default:
      color = primaryColor;
      break;
  }
  return color;
}
