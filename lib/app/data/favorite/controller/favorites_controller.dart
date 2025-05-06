import 'package:get/get.dart';
import 'package:istiqamah_cula_cula_app/app/data/favorite/usescases/get_favorites.dart';
import 'package:istiqamah_cula_cula_app/app/data/favorite/usescases/post_favorite.dart';

import '../../products/entities/product_entities.dart';

class FavoritesController extends GetxController {
  final GetFavorites _getFavorites = GetFavorites();
  final PostFavorite _postFavorite = PostFavorite();

  var favorites = <ProductEntities>[].obs;

  Future<void> fetchFavorites() async {
    final result = await _getFavorites();
    result.fold(
      (failure) =>
          Get.snackbar("Error", failure.message ?? 'Gagal mengambil data'),
      (data) => favorites.value = data,
    );
  }

  Future<bool> addFavorite(int productId) async {
    final result = await _postFavorite(productId);
    return result.fold(
      (failure) {
        Get.snackbar("Error", failure.message ?? 'Gagal menambah favorit');
        return false;
      },
      (success) => true,
    );
  }
}
