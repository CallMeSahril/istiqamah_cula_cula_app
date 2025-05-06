import 'package:istiqamah_cula_cula_app/app/data/products/entities/product_entities.dart';

class ProductCategoryEntities {
  final int id;
  final String name;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<ProductEntities>? products;

  ProductCategoryEntities({
    required this.id,
    required this.name,
    this.createdAt,
    this.updatedAt,
    this.products,
  });

  factory ProductCategoryEntities.fromJson(Map<String, dynamic> json) {
    return ProductCategoryEntities(
      id: json['id'],
      name: json['name'],
      createdAt: DateTime.tryParse(json['created_at'] ?? ''),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? ''),
      products: json['products'] != null
          ? List<ProductEntities>.from(
              json['products'].map((x) => ProductEntities.fromJson(x)))
          : null,
    );
  }
}
