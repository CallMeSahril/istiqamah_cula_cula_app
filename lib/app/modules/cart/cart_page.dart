import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:istiqamah_cula_cula_app/app/data/carts/controller/carts_controller.dart';
import 'package:istiqamah_cula_cula_app/app/modules/pembelian/pembelian_page.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartController controller = Get.put(CartController());
  final formatter =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
  int getFinalPrice(product) {
    if (product.discount != null && product.discount!.isNotEmpty) {
      final potongan = product.discount!.first.potonganDiskon ?? 0;
      return (product.price! * (100 - potongan)) ~/ 100;
    }
    return product.price!;
  }

  @override
  void initState() {
    super.initState();
    controller.fetchCarts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Keranjang Saya"),
        centerTitle: true,
        backgroundColor: Color(0xffFF2B2A),
      ),
      body: Obx(() {
        if (controller.carts.isEmpty) {
          return Center(child: Text("Keranjang kosong"));
        }

        return ListView.builder(
          itemCount: controller.carts.length,
          padding: EdgeInsets.all(10),
          itemBuilder: (context, index) {
            final cart = controller.carts[index];
            final product = cart.product;

            return Container(
              margin: EdgeInsets.symmetric(vertical: 6),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      product.image ?? '',
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Icon(Icons.image, size: 60),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product.name ?? '',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        SizedBox(height: 4),
                        product.discount != null && product.discount!.isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    formatter
                                        .format(product.price ?? 0)
                                        .replaceAll('Rp', 'IDR')
                                        .trim(),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    formatter
                                        .format(getFinalPrice(product))
                                        .replaceAll('Rp', 'IDR')
                                        .trim(),
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              )
                            : Text(
                                'IDR ${formatter.format(product.price ?? 0).replaceAll('Rp', '').trim()}',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      // Tombol - (kurang jumlah)
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Color(0xFFFF6B00),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon:
                              Icon(Icons.remove, size: 18, color: Colors.white),
                          onPressed: cart.quantity > 1
                              ? () => controller.updateQuantity(
                                  cartId: cart.cartId,
                                  quantity: cart.quantity - 1)
                              : null,
                        ),
                      ),
                      SizedBox(width: 8),

                      // Jumlah item
                      Text(cart.quantity.toString(),
                          style: TextStyle(fontSize: 16)),
                      SizedBox(width: 8),

                      // Tombol + (tambah jumlah)
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Color(0xFFFF6B00),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(Icons.add, size: 18, color: Colors.white),
                          onPressed: () => controller.updateQuantity(
                              cartId: cart.cartId, quantity: cart.quantity + 1),
                        ),
                      ),
                      SizedBox(width: 8),

                      // 🗑️ Tombol Hapus
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.red.shade400,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon:
                              Icon(Icons.delete, size: 18, color: Colors.white),
                          onPressed: () {
                            controller.removeCart(cart.cartId);
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        );
      }),
      bottomNavigationBar: Obx(() {
        if (controller.carts.isEmpty) return SizedBox.shrink();
        return Container(
          padding: EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: () {
              Get.to(() => PembelianPage(carts: controller.carts.toList()));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFFF2B2A),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.symmetric(vertical: 14),
            ),
            child: Text("Pembayaran"),
          ),
        );
      }),
    );
  }
}
