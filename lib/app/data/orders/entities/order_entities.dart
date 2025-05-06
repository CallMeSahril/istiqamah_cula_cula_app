import 'dart:convert';

import 'package:istiqamah_cula_cula_app/app/data/products/entities/product_entities.dart';

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
  final List<Item>? items;

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
    this.items,
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
      items: json["items"] == null
          ? []
          : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
    );
  }
}

class Item {
  final int? id;
  final int? orderId;
  final int? productId;
  final int? quantity;
  final int? subtotal;
  final dynamic createdAt;
  final dynamic updatedAt;
  final ProductEntities? product;

  Item({
    this.id,
    this.orderId,
    this.productId,
    this.quantity,
    this.subtotal,
    this.createdAt,
    this.updatedAt,
    this.product,
  });

  factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        orderId: json["order_id"],
        productId: json["product_id"],
        quantity: json["quantity"],
        subtotal: json["subtotal"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        product: json["product"] == null
            ? null
            : ProductEntities.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "product_id": productId,
        "quantity": quantity,
        "subtotal": subtotal,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "product": product?.toJson(),
      };
}
