import 'package:get/get.dart';
import 'package:istiqamah_cula_cula_app/app/data/orders/entities/order_entities.dart';
import 'package:istiqamah_cula_cula_app/app/data/orders/entities/payment_method.dart';
import 'package:istiqamah_cula_cula_app/app/data/orders/usecase/orders_usecase.dart';

class OrdersController extends GetxController {
  final createOrderUsecase = CreateOrderUsecase();
  final getOrdersByStatusUsecase = GetOrdersByStatusUsecase();
  final getPaymentMethodsUsecase = GetPaymentMethodsUsecase();
  final checkPaymentStatusUsecase = CheckPaymentStatusUsecase();

  RxList<OrderEntities> orders = <OrderEntities>[].obs;
  RxList<PaymentMethod> paymentMethods = <PaymentMethod>[].obs;
  RxBool isLoading = false.obs;

  Future<bool> createOrder(Map<String, dynamic> body) async {
    isLoading.value = true;
    final result = await createOrderUsecase(body);
    bool isSuccess = false;
    result.fold(
      (failure) {
        Get.snackbar("Gagal", failure.message ?? "Terjadi kesalahan");
      },
      (data) {
        Get.snackbar("Berhasil", "Order dibuat dengan ID: $data");
        isSuccess = true;
      },
    );
    isLoading.value = false;
    return isSuccess;
  }

  Future<void> loadOrders(String status) async {
    isLoading.value = true;
    final result = await getOrdersByStatusUsecase(status);
    result.fold(
      (failure) =>
          Get.snackbar("Gagal", failure.message ?? "Terjadi kesalahan"),
      (data) => orders.assignAll(data),
    );
    isLoading.value = false;
  }

  Future<void> loadPaymentMethods(int amount) async {
    isLoading.value = true;
    final result = await getPaymentMethodsUsecase(amount);
    result.fold(
      (failure) =>
          Get.snackbar("Gagal", failure.message ?? "Terjadi kesalahan"),
      (data) => paymentMethods.assignAll(data),
    );
    isLoading.value = false;
  }

  Future<bool> checkPaymentStatus(String merchantOrderId) async {
    final result = await checkPaymentStatusUsecase(merchantOrderId);
    return result.fold((failure) => false, (success) => success);
  }
}
