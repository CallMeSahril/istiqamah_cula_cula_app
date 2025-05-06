class HistoryEntities {
  final int totalAmount;
  final String status;
  final DateTime completedAt;
  final String name;
  final String address;

  HistoryEntities({
    required this.totalAmount,
    required this.status,
    required this.completedAt,
    required this.name,
    required this.address,
  });

  factory HistoryEntities.fromJson(Map<String, dynamic> json) {
    return HistoryEntities(
      totalAmount: json['total_amount'],
      status: json['status'],
      completedAt: DateTime.parse(json['completed_at']),
      name: json['name'],
      address: json['address'],
    );
  }
}
