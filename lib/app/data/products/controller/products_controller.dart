import 'package:get/get.dart';
import 'package:istiqamah_cula_cula_app/app/data/products/entities/product_entities.dart';
import 'package:istiqamah_cula_cula_app/app/data/products/usescases/get_all_products.dart';
import 'package:istiqamah_cula_cula_app/app/data/products/usescases/get_product_by_id.dart';
import 'package:istiqamah_cula_cula_app/app/data/products/usescases/search_product.dart';

class ProductsController extends GetxController {
  final GetAllProducts _getAllProducts = GetAllProducts();
  final GetProductById _getProductById = GetProductById();
  final SearchProduct _searchProduct = SearchProduct();

  /// Mengambil semua produk
  Future<List<ProductEntities>> getAllProducts() async {
    final result = await _getAllProducts();
    return result.fold(
      (failure) {
        Get.snackbar("Gagal", failure.message ?? "Terjadi kesalahan");
        return [];
      },
      (data) => data,
    );
  }

  /// Mengambil produk berdasarkan ID
  Future<ProductEntities?> getProductById(int id) async {
    final result = await _getProductById(id);
    return result.fold(
      (failure) {
        Get.snackbar("Gagal", failure.message ?? "Terjadi kesalahan");
        return null;
      },
      (data) => data,
    );
  }

  /// Mencari produk berdasarkan keyword
  Future<List<ProductEntities>> searchProduct(String keyword) async {
    final result = await _searchProduct(keyword);
    return result.fold(
      (failure) {
        Get.snackbar("Gagal", failure.message ?? "Terjadi kesalahan");
        return [];
      },
      (data) => data,
    );
  }
}
