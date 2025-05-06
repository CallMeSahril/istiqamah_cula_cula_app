class ProductEntities {
  final int? id;
  final String? name;
  final String? image;
  final int? price;
  final int? stock;
  final String? description;
  final int? categoryId;

  ProductEntities({
    this.id,
    this.name,
    this.image,
    this.price,
    this.stock,
    this.description,
    this.categoryId,
  });

  factory ProductEntities.fromJson(Map<String, dynamic> json) {
    return ProductEntities(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      price: json['price'],
      stock: json['stock'],
      description: json['description'],
      categoryId: json['category_id'],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "price": price,
    "stock": stock,
    "description": description,
    "category_id": categoryId,
  };
}
