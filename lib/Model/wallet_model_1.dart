// // To parse this JSON data, do
// //
// //     final wallet1Model = wallet1ModelFromJson(jsonString);

// import 'dart:convert';

// Wallet1Model wallet1ModelFromJson(String str) =>
//     Wallet1Model.fromJson(json.decode(str));

// String wallet1ModelToJson(Wallet1Model data) => json.encode(data.toJson());

// class Wallet1Model {
//   List<WalletHistory> walletHistory;
//   int walletBalance;
//   bool status;

//   Wallet1Model({
//     required this.walletHistory,
//     required this.walletBalance,
//     required this.status,
//   });

//   factory Wallet1Model.fromJson(Map<String, dynamic> json) => Wallet1Model(
//         walletHistory: List<WalletHistory>.from(
//             json["wallet_history"].map((x) => WalletHistory.fromJson(x))),
//         walletBalance: json["wallet_balance"],
//         status: json["status"],
//       );

//   Map<String, dynamic> toJson() => {
//         "wallet_history":
//             List<dynamic>.from(walletHistory.map((x) => x.toJson())),
//         "wallet_balance": walletBalance,
//         "status": status,
//       };
// }

// class WalletHistory {
//   int walletId;
//   int employeeId;
//   int orderId;
//   int amount;
//   int ledgerAmount;
//   DateTime createdAt;
//   String updatedAt;

//   WalletHistory({
//     required this.walletId,
//     required this.employeeId,
//     required this.orderId,
//     required this.amount,
//     required this.ledgerAmount,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory WalletHistory.fromJson(Map<String, dynamic> json) => WalletHistory(
//         walletId: json["wallet_id"],
//         employeeId: json["employee_id"],
//         orderId: json["order_id"],
//         amount: json["amount"],
//         ledgerAmount: json["ledger_amount"],
//         // createdAt: json["created_at"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"],
//       );

//   Map<String, dynamic> toJson() => {
//         "wallet_id": walletId,
//         "employee_id": employeeId,
//         "order_id": orderId,
//         "amount": amount,
//         "ledger_amount": ledgerAmount,
//         // "created_at": createdAt,
//         "created_at":
//             "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
//         "updated_at": updatedAt,
//       };
// }

// To parse this JSON data, do
//
//     final wallet1Model = wallet1ModelFromJson(jsonString);

import 'dart:convert';

Wallet1Model wallet1ModelFromJson(String str) =>
    Wallet1Model.fromJson(json.decode(str));

String wallet1ModelToJson(Wallet1Model data) => json.encode(data.toJson());

class Wallet1Model {
  List<WalletHistory>? walletHistory;
  int? walletBalance;
  bool? status;

  Wallet1Model({
    this.walletHistory,
    this.walletBalance,
    this.status,
  });

  factory Wallet1Model.fromJson(Map<String, dynamic> json) => Wallet1Model(
        walletHistory: List<WalletHistory>.from(
            json["wallet_history"].map((x) => WalletHistory.fromJson(x))),
        walletBalance: json["wallet_balance"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "wallet_history":
            List<dynamic>.from(walletHistory!.map((x) => x.toJson())),
        "wallet_balance": walletBalance,
        "status": status,
      };
}

class WalletHistory {
  int? walletId;
  int? employeeId;
  int? orderId;
  int? amount;
  int? ledgerAmount;
  DateTime? createdAt;
  String? updatedAt;
  String? type;
  String? debitWithdrawalApprove;
  dynamic reason;
  String? createdBy;

  WalletHistory({
    this.walletId,
    this.employeeId,
    this.orderId,
    this.amount,
    this.ledgerAmount,
    this.createdAt,
    this.updatedAt,
    this.type,
    this.debitWithdrawalApprove,
    this.reason,
    this.createdBy,
  });

  factory WalletHistory.fromJson(Map<String, dynamic> json) => WalletHistory(
        walletId: json["wallet_id"],
        employeeId: json["employee_id"],
        orderId: json["order_id"],
        amount: json["amount"],
        ledgerAmount: json["ledger_amount"],
        // createdAt: json["created_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
        type: json["type"],
        debitWithdrawalApprove: json["debit_withdrawal_approve"],
        reason: json["reason"],
        createdBy: json["created_by"],
      );

  Map<String, dynamic> toJson() => {
        "wallet_id": walletId,
        "employee_id": employeeId,
        "order_id": orderId,
        "amount": amount,
        "ledger_amount": ledgerAmount,
        // "created_at": createdAt,
        "created_at":
            "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
        "updated_at": updatedAt,
        "type": type,
        "debit_withdrawal_approve": debitWithdrawalApprove,
        "reason": reason,
        "created_by": createdBy,
      };
}
