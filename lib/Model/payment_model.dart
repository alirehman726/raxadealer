class PaymentModel {
  String paymentId;
  String userId;
  String razorOrderId;
  String razorPaymentId;
  int amount;
  String status;
  String createdAt;
  String updatedAt;

  PaymentModel({
    required this.paymentId,
    required this.userId,
    required this.razorOrderId,
    required this.razorPaymentId,
    required this.amount,
    required this.status,
    required this.createdAt,
    required this.updatedAt
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
    paymentId: json['_id'],
    userId: json['user'],
    razorOrderId: json['order_id'],
    razorPaymentId: json['payment_id'],
    amount: json['amount'],
    status: json['status'],
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt']
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = paymentId;
    data['user'] = userId;
    data['order_id'] = razorOrderId;
    data['payment_id'] = razorPaymentId;
    data['amount'] = amount;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

  @override
  String toString() {
    return "{ _id: $paymentId, "
        "user_id: $userId, "
        "order_id: $razorOrderId, "
        "payment_id: $paymentId, "
        "amount: $amount, "
        "status: $status, "
        "createdAt: $createdAt, "
        "updatedAt: $updatedAt }";
  }
}

/// Convert String into PaymentModal JSON
List<PaymentModel> paymentModelFromJson(data) {
  List<PaymentModel> items = <PaymentModel>[];
  for (var d in data) {
    PaymentModel payment = PaymentModel.fromJson(d);
    items.add(payment);
  }
  return items;
}