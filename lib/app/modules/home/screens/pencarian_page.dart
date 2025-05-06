import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:istiqamah_cula_cula_app/app/data/products/controller/products_controller.dart';
import 'package:istiqamah_cula_cula_app/app/data/products/entities/product_entities.dart';
import 'package:istiqamah_cula_cula_app/app/modules/cart/cart_page.dart';
import 'package:istiqamah_cula_cula_app/app/modules/detail_produk/detail_produk_page.dart';

class PencarianPage extends StatefulWidget {
  @override
  State<PencarianPage> createState() => _PencarianPageState();
}

class _PencarianPageState extends State<PencarianPage> {
  final TextEditingController searchController = TextEditingController();
  final ProductsController productsController = Get.put(ProductsController());

  List<ProductEntities> searchResults = [];
  bool isLoading = false;

  void performSearch(String keyword) async {
    if (keyword.isEmpty) return;

    setState(() {
      isLoading = true;
    });

    final results = await productsController.searchProduct(keyword);

    if (!mounted) return;
    setState(() {
      searchResults = results;
      isLoading = false;
    });
  }

  final formatter =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xffFF2B2A),
        centerTitle: true,
        title: Text(
          "Pencarian",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              Get.to(CartPage());
              // Add your cart action here
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: searchController,
                onSubmitted: performSearch,
                decoration: InputDecoration(
                  hintText: "Cari sesuatu...",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                ),
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(height: 20),
            Text("Pencarian Terbaru",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
            if (isLoading)
              Center(child: CircularProgressIndicator())
            else if (searchResults.isEmpty)
              Text("Tidak ada hasil.")
            else
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  final product = searchResults[index];
                  return GestureDetector(
                    onTap: () {
                      Get.to(DetailProdukPage(id: product.id!));
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Image.network(
                            product.image ?? '',
                            width: 50,
                            height: 50,
                            errorBuilder: (_, __, ___) =>
                                Icon(Icons.image, size: 50, color: Colors.grey),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(product.name ?? '',
                                    style: TextStyle(fontSize: 16)),
                                Text(
                                  formatter.format(product.price ?? 0),
                                  style: TextStyle(
                                      fontSize: 12, color: Color(0xff51B1A6)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            SizedBox(height: 20),
            // Text("Popular product",
            //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
            // ListView.builder(
            //     shrinkWrap: true,
            //     physics: NeverScrollableScrollPhysics(),
            //     itemCount: 10,
            //     itemBuilder: (context, index) {
            //       return GestureDetector(
            //         onTap: () {
            //           // Add your action here
            //         },
            //         child: Container(
            //           margin: EdgeInsets.all(10),
            //           padding: EdgeInsets.all(10),
            //           decoration: BoxDecoration(
            //             color: Colors.grey[50],
            //             borderRadius: BorderRadius.circular(10),
            //           ),
            //           child: Row(
            //             children: [
            //               Icon(Icons.image, size: 50, color: Colors.grey),
            //               SizedBox(width: 10),
            //               Expanded(
            //                 child: Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Text(
            //                       "Produk ${index + 1}",
            //                       style: TextStyle(fontSize: 16),
            //                     ),
            //                     Text(
            //                       "Ro 150.000",
            //                       style: TextStyle(
            //                           fontSize: 12, color: Color(0xff51B1A6)),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       );
            //     }),
          ],
        ),
      ),
    );
  }
}
