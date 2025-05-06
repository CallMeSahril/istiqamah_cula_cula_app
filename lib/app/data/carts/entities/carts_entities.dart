import 'package:istiqamah_cula_cula_app/app/data/products/entities/product_entities.dart';

class CartEntities {
  final int cartId;
  final int quantity;
  final ProductEntities product;

  CartEntities({
    required this.cartId,
    required this.quantity,
    required this.product,
  });

  factory CartEntities.fromJson(Map<String, dynamic> json) => CartEntities(
        cartId: json['cart_id'],
        quantity: json['quantity'],
        product: ProductEntities.fromJson(json['product']),
      );
}
