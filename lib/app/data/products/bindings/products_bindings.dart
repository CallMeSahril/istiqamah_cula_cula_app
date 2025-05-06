import 'package:get/get.dart';
import 'package:istiqamah_cula_cula_app/app/data/products/controller/products_controller.dart';

class ProductsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductsController>(() => ProductsController());
  }
}