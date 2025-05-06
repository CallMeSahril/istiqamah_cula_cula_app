class FavoriteEntities {
  final int id;
  final int userId;
  final int productId;

  FavoriteEntities({
    required this.id,
    required this.userId,
    required this.productId,
  });

  factory FavoriteEntities.fromJson(Map<String, dynamic> json) {
    return FavoriteEntities(
      id: json['id'],
      userId: json['user_id'],
      productId: json['product_id'],
    );
  }
}
