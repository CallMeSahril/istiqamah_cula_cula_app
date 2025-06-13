import 'dart:convert';

class ProductEntities {
  final int? id;
  final String? name;
  final String? image;
  final int? price;
  final int? stock;
  final String? description;
  final int? categoryId;
  final List<ImageData>? images;
  final String? urlPhoto;
  final List<DiscountData>? discount;

  ProductEntities({
    this.id,
    this.name,
    this.image,
    this.price,
    this.stock,
    this.description,
    this.categoryId,
    this.images,
    this.urlPhoto,
    this.discount,
  });

  factory ProductEntities.fromJson(Map<String, dynamic> json) {
    return ProductEntities(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      images: json["images"] == null
          ? []
          : List<ImageData>.from(
              json["images"]!.map((x) => ImageData.fromJson(x))),
      price: json['price'],
      stock: json['stock'],
      description: json['description'],
      categoryId: json['category_id'],
      urlPhoto: json["url_photo"],
      discount: json["discount"] == null
          ? []
          : List<DiscountData>.from(
              json["discount"].map((x) => DiscountData.fromJson(x))),
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

class ImageData {
  final int? id;
  final String? image;
  final String? urlPhoto;

  ImageData({
    this.id,
    this.image,
    this.urlPhoto,
  });

  factory ImageData.fromRawJson(String str) =>
      ImageData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ImageData.fromJson(Map<String, dynamic> json) => ImageData(
        id: json["id"],
        image: json["image"],
        urlPhoto: json["url_photo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "url_photo": urlPhoto,
      };
}

class DiscountData {
  final int? id;
  final int? productId;
  final int? potonganDiskon;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  DiscountData({
    this.id,
    this.productId,
    this.potonganDiskon,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory DiscountData.fromJson(Map<String, dynamic> json) => DiscountData(
        id: json['id'],
        productId: int.tryParse(json['product_id'].toString()),
        potonganDiskon: int.tryParse(json['potongan_diskon'].toString()),
        status: json['status'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'product_id': productId,
        'potongan_diskon': potonganDiskon,
        'status': status,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}
