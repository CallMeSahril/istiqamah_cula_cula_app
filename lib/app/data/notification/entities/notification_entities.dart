class NotificationEntities {
  final int id;
  final int userId;
  final String title;
  final String message;
  final DateTime createdAt;
  final DateTime updatedAt;

  NotificationEntities({
    required this.id,
    required this.userId,
    required this.title,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NotificationEntities.fromJson(Map<String, dynamic> json) {
    return NotificationEntities(
      id: json['id'],
      userId: json['user_id'],
      title: json['title'],
      message: json['message'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}