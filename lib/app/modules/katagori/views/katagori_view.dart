import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:istiqamah_cula_cula_app/app/data/product_category/controller/products_category_controller.dart';
import 'package:istiqamah_cula_cula_app/app/data/product_category/entities/product_category_entities.dart';
import 'package:istiqamah_cula_cula_app/app/data/products/entities/product_entities.dart';
import 'package:istiqamah_cula_cula_app/app/modules/detail_produk/detail_produk_page.dart';

class KatagoriView extends StatefulWidget {
  final int id;
  const KatagoriView({super.key, required this.id});

  @override
  State<KatagoriView> createState() => _KatagoriViewState();
}

class _KatagoriViewState extends State<KatagoriView> {
  final ProductCategoryController _categoryController =
      Get.put(ProductCategoryController());

  ProductCategoryEntities? category;
  List<ProductEntities> products = [];

  final formatter =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

  @override
  void initState() {
    super.initState();
    fetchCategoryDetail();
  }

  void fetchCategoryDetail() async {
    final result = await _categoryController.getCategoryDetail(widget.id);
    if (!mounted) return;
    setState(() {
      category = result;
      products = result?.products ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          category?.name?.capitalize ?? "",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: products.isEmpty
            ? Center(child: Text("Produk tidak ditemukan"))
            : GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 3 / 4,
                ),
                itemCount: products.length,
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
                          Container(
                            height: 150,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(10)),
                              image: DecorationImage(
                                image: NetworkImage(product.image ?? ''),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              product.name ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              formatter.format(product.price ?? 0),
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
