import 'package:get/get.dart';
import 'package:istiqamah_cula_cula_app/app/data/carts/entities/carts_entities.dart';
import 'package:istiqamah_cula_cula_app/app/data/carts/remote_datasource.dart/cart_remote_data_source.dart';

class CartController extends GetxController {
  final CartRemoteDatasource _datasource = CartRemoteDatasource();

  RxList<CartEntities> carts = <CartEntities>[].obs;
  RxBool isLoading = false.obs;

  /// ✅ Ambil semua keranjang
  Future<void> fetchCarts() async {
    isLoading.value = true;
    final result = await _datasource.getCarts();
    result.fold(
      (failure) =>
          Get.snackbar("Error", failure.message ?? "Gagal mengambil keranjang"),
      (data) => carts.assignAll(data),
    );
    isLoading.value = false;
  }

  /// ✅ Tambah ke keranjang
  Future<void> addToCart({required int productId, int quantity = 1}) async {
    final result =
        await _datasource.addCart(productId: productId, quantity: quantity);
    result.fold(
      (failure) => Get.snackbar(
          "Error", failure.message ?? "Gagal menambahkan ke keranjang"),
      (success) {
        if (success) fetchCarts();
      },
    );
  }

  /// ✅ Update kuantitas produk di keranjang
  Future<void> updateQuantity(
      {required int cartId, required int quantity}) async {
    final result = await _datasource.updateCartQuantity(
        cartId: cartId, quantity: quantity);
    result.fold(
      (failure) => Get.snackbar(
          "Error", failure.message ?? "Gagal update jumlah produk"),
      (success) {
        if (success) fetchCarts();
      },
    );
  }

  /// ✅ Hapus item dari keranjang
  Future<void> removeCart(int cartId) async {
    final result = await _datasource.deleteCart(cartId);
    result.fold(
      (failure) =>
          Get.snackbar("Error", failure.message ?? "Gagal menghapus produk"),
      (success) {
        if (success) fetchCarts();
      },
    );
  }

  /// ✅ Hitung total harga keranjang
  int get totalPrice {
    return carts.fold(0, (sum, cart) {
      final price = cart.product.price ?? 0;
      final quantity = cart.quantity;
      return sum + (price * quantity);
    });
  }
}
