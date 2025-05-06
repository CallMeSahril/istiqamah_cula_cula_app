import 'package:get/get.dart';
import 'package:istiqamah_cula_cula_app/app/data/product_category/entities/product_category_entities.dart';
import 'package:istiqamah_cula_cula_app/app/data/product_category/usescases/get_all_categories.dart';
import 'package:istiqamah_cula_cula_app/app/data/product_category/usescases/get_categories_by_id.dart';

class ProductCategoryController extends GetxController {
  final GetAllCategories _getAllCategories = GetAllCategories();
  final GetCategoryById _getCategoryById = GetCategoryById();

  Future<List<ProductCategoryEntities>> getAllCategories() async {
    final result = await _getAllCategories();
    return result.fold(
      (failure) {
        Get.snackbar("Gagal", failure.message ?? "Terjadi kesalahan");
        return [];
      },
      (data) => data,
    );
  }

  Future<ProductCategoryEntities?> getCategoryDetail(int id) async {
    final result = await _getCategoryById(id);
    return result.fold(
      (failure) {
        Get.snackbar("Gagal", failure.message ?? "Terjadi kesalahan");
        return null;
      },
      (data) => data,
    );
  }
}
