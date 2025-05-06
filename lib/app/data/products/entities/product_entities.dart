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
