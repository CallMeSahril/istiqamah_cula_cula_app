import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:istiqamah_cula_cula_app/app/core/utils/fungsi_format.dart';
import 'package:istiqamah_cula_cula_app/app/data/product_category/controller/products_category_controller.dart';
import 'package:istiqamah_cula_cula_app/app/data/product_category/entities/product_category_entities.dart';
import 'package:istiqamah_cula_cula_app/app/data/products/controller/products_controller.dart';
import 'package:istiqamah_cula_cula_app/app/data/products/entities/product_entities.dart';
import 'package:istiqamah_cula_cula_app/app/modules/cart/cart_page.dart';
import 'package:istiqamah_cula_cula_app/app/modules/detail_produk/detail_produk_page.dart';
import 'package:istiqamah_cula_cula_app/app/modules/katagori/views/katagori_view.dart';
import 'package:istiqamah_cula_cula_app/app/routes/app_pages.dart';

class BerandaPage extends StatefulWidget {
  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  final ProductsController controller = Get.put(ProductsController());
  final ProductCategoryController categoryController =
      Get.put(ProductCategoryController());

  List<ProductEntities> products = [];
  List<ProductCategoryEntities> categories = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
    fetchCategories();
  }

  void fetchProducts() async {
    products = await controller.getAllProducts();
    if (!mounted) return;
    setState(() {});
  }

  void fetchCategories() async {
    categories = await categoryController.getAllCategories();
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffFF2B2A),
        title: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            decoration: InputDecoration(
              fillColor: Colors.white,
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.white70),
            ),
            style: TextStyle(color: Colors.white),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Add your cart action here
              Get.to(CartPage());
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: ListView(
          children: [
            Image.asset('assets/images/image.png'),
            Text("Kategori",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            categories.length == 0
                ? Text("Tidak Ada Kategori")
                : Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.to(KatagoriView(
                                  id: category.id,
                                ));
                              },
                              child: Container(
                                margin: EdgeInsets.all(10),
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: Color(0xffD9D9D9),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.category,
                                    color: Colors.black,
                                    size: 24,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              category.name.capitalize ?? "Kategori",
                              style: TextStyle(fontSize: 12),
                            )
                          ],
                        );
                      },
                    ),
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Produk",
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Text(
                  "Lihat Semua",
                  style: TextStyle(color: Colors.red),
                )
              ],
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 3 / 4,
              ),
              itemCount: products.length > 10 ? 10 : products.length,
              itemBuilder: (context, index) {
                final product = products[index];

                return GestureDetector(
                  onTap: () {
                    Get.to(DetailProdukPage(id: product.id!));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Gambar produk
                        Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(10)),
                            image: DecorationImage(
                              image: NetworkImage(product.image ?? ''),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // Spacer kecil
                        SizedBox(height: 8),
                        // Expanded text content agar tidak overflow
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${product.name?.capitalize}",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                formatter.format(product.price ?? 0),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
