class OrderEntities {
  final int id;
  final int userId;
  final int totalAmount;
  final int addressId;
  final String merchantOrderId;
  final String paymentUrl;
  final String vaNumber;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  OrderEntities({
    required this.id,
    required this.userId,
    required this.totalAmount,
    required this.addressId,
    required this.merchantOrderId,
    required this.paymentUrl,
    required this.vaNumber,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OrderEntities.fromJson(Map<String, dynamic> json) {
    return OrderEntities(
      id: json['id'],
      userId: json['user_id'],
      totalAmount: json['total_amount'],
      addressId: json['address_id'],
      merchantOrderId: json['merchant_order_id'],
      paymentUrl: json['payment_url'],
      vaNumber: json['va_number'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
