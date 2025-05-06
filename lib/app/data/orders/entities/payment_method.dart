class PaymentMethod {
  final String paymentMethod;
  final String paymentName;
  final String paymentImage;
  final String totalFee;

  PaymentMethod({
    required this.paymentMethod,
    required this.paymentName,
    required this.paymentImage,
    required this.totalFee,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return PaymentMethod(
      paymentMethod: json['paymentMethod'] ?? '',
      paymentName: json['paymentName'] ?? '',
      paymentImage: json['paymentImage'] ?? '',
      totalFee: json['totalFee'] ?? '',
    );
  }
}
