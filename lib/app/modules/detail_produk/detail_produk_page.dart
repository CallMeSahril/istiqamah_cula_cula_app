import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:istiqamah_cula_cula_app/app/data/carts/controller/carts_controller.dart';
import 'package:istiqamah_cula_cula_app/app/data/products/controller/products_controller.dart';
import 'package:istiqamah_cula_cula_app/app/data/products/entities/product_entities.dart';
import 'package:istiqamah_cula_cula_app/app/modules/pembelian/pembelian_page.dart';

class DetailProdukPage extends StatefulWidget {
  final int id;
  DetailProdukPage({required this.id});
  @override
  State<DetailProdukPage> createState() => _DetailProdukPageState();
}

class _DetailProdukPageState extends State<DetailProdukPage> {
  final ProductsController _controller = Get.put(ProductsController());
  final CartController _cartController = Get.put(CartController());

  ProductEntities? product;
  final formatter =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

  @override
  void initState() {
    super.initState();
    fetchProduct(widget.id);
  }

  void fetchProduct(int id) async {
    final result = await _controller.getProductById(id);
    if (!mounted) return;
    setState(() {
      product = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (product == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Detail Produk"),
          backgroundColor: Color(0xffFF2B2A),
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Detail Produk"),
        backgroundColor: Color(0xffFF2B2A),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              product!.image ?? '',
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Icon(Icons.broken_image, size: 100),
            ),
            SizedBox(height: 16),
            Text(
              product!.name!.capitalize ?? '',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              formatter.format(product!.price ?? 0),
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.store, color: Colors.grey),
                SizedBox(width: 8),
                Text("Istiqamah Cula-Cula Store",
                    style: TextStyle(fontWeight: FontWeight.w600)),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text("Official Store", style: TextStyle(fontSize: 12)),
                )
              ],
            ),
            SizedBox(height: 20),
            Text("Deskripsi:", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(product!.description ?? "Tidak ada deskripsi"),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  if (product != null && product!.id != null) {
                    _cartController.addToCart(productId: product!.id!);
                    Get.snackbar("Berhasil", "Produk dimasukkan ke keranjang");
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFF6B00), // warna orange
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text("Masukkan Keranjang"),
              ),
            ),
            // SizedBox(width: 10),
            // Expanded(
            //   child: ElevatedButton(
            //     onPressed: () {
            //       if (product != null) {
            //         Get.to(() => PembelianPage(products: [product!]));
            //       }
            //     },
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: Color(0xFFFF2B2A), // warna merah
            //       foregroundColor: Colors.white,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(12),
            //       ),
            //       padding: EdgeInsets.symmetric(vertical: 14),
            //     ),
            //     child: Text("Beli Sekarang"),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
