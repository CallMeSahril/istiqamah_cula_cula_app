import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:istiqamah_cula_cula_app/app/core/utils/fungsi_format.dart';
import 'package:istiqamah_cula_cula_app/app/data/banner/controller/banner_controller.dart';
import 'package:istiqamah_cula_cula_app/app/data/banner/model/banner_model.dart';
import 'package:istiqamah_cula_cula_app/app/data/product_category/controller/products_category_controller.dart';
import 'package:istiqamah_cula_cula_app/app/data/product_category/entities/product_category_entities.dart';
import 'package:istiqamah_cula_cula_app/app/data/products/controller/products_controller.dart';
import 'package:istiqamah_cula_cula_app/app/data/products/entities/product_entities.dart';
import 'package:istiqamah_cula_cula_app/app/modules/cart/cart_page.dart';
import 'package:istiqamah_cula_cula_app/app/modules/detail_produk/detail_produk_page.dart';
import 'package:istiqamah_cula_cula_app/app/modules/katagori/views/katagori_view.dart';
import 'package:istiqamah_cula_cula_app/app/modules/lihat_semua_produk/semua_produk_page.dart';
import 'package:video_player/video_player.dart';

class BerandaPage extends StatefulWidget {
  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  final ProductsController controller = Get.put(ProductsController());
  final BannerController bannerController = Get.put(BannerController());

  final ProductCategoryController categoryController =
      Get.put(ProductCategoryController());

  List<ProductEntities> products = [];
  List<ProductCategoryEntities> categories = [];
  List<BannerEntities> bannerList = [];
  BannerEntities? iklan;

  @override
  void initState() {
    super.initState();
    fetchProducts();
    fetchCategories();
    fetchBannersAndIklan();
  }

  void fetchBannersAndIklan() async {
    await bannerController.fetchBanners();
    await bannerController.fetchIklan();
    bannerList = bannerController.bannerList;
    iklan = bannerController.iklanList.value;
    if (!mounted) return;
    setState(() {});
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
              border: InputBorder.none,
              hintText: "Cari produk...",
              hintStyle: TextStyle(color: Colors.black38),
            ),
            style: TextStyle(color: Colors.black),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Get.to(CartPage());
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: ListView(
          children: [
// Banner Carousel
            if (bannerList.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 180.0,
                      autoPlay: true,
                      enlargeCenterPage: true,
                    ),
                    items: bannerList.map((banner) {
                      return Builder(
                        builder: (BuildContext context) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: banner.image ?? '',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              placeholder: (context, url) =>
                                  Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.broken_image),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16),
                ],
              ),

// Iklan
            if (iklan?.image != null && iklan!.image!.endsWith('.mp4'))
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Iklan",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: VideoIklanWidget(videoUrl: iklan!.image!),
                  ),
                  SizedBox(height: 16),
                ],
              ),

            SizedBox(height: 10),
            Text(
              "Kategori",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            categories.isEmpty
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
                                Get.to(KatagoriView(id: category.id));
                              },
                              child: Container(
                                margin: EdgeInsets.all(10),
                                height: 50,
                                width: 50,
                                child: ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl: category.image ?? '',
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        Icon(Icons.image),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.broken_image),
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
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Produk",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(SemuaProdukPage());
                  },
                  child: Text(
                    "Lihat Semua",
                    style: TextStyle(color: Colors.red),
                  ),
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
                        ClipRRect(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(10)),
                          child: CachedNetworkImage(
                            imageUrl: product.image ?? '',
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                Center(child: Icon(Icons.image)),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.broken_image),
                          ),
                        ),
                        SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name?.capitalize ?? '',
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
            ),
          ],
        ),
      ),
    );
  }
}

class VideoIklanWidget extends StatefulWidget {
  final String videoUrl;

  const VideoIklanWidget({Key? key, required this.videoUrl}) : super(key: key);

  @override
  State<VideoIklanWidget> createState() => _VideoIklanWidgetState();
}

class _VideoIklanWidgetState extends State<VideoIklanWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        _controller.setLooping(true);
        _controller.play();
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
        : Container(
            height: 200,
            child: Center(child: CircularProgressIndicator()),
          );
  }
}
