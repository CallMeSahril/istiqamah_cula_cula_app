import 'package:get/get.dart';
import 'package:istiqamah_cula_cula_app/app/data/notification/entities/notification_entities.dart';
import 'package:istiqamah_cula_cula_app/app/data/notification/usescases/get_notifications.dart';

class NotificationController extends GetxController {
  final GetNotifications _getNotifications;
  NotificationController(this._getNotifications);

  RxList<NotificationEntities> notifications = <NotificationEntities>[].obs;
  RxBool isLoading = false.obs;

  Future<void> fetchNotifications() async {
    isLoading.value = true;
    final result = await _getNotifications();
    result.fold(
      (failure) =>
          Get.snackbar("Gagal", failure.message ?? "Terjadi kesalahan"),
      (data) => notifications.value = data,
    );
    isLoading.value = false;
  }
}
