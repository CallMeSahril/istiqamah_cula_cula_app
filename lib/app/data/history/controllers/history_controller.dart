import 'package:get/get.dart';
import 'package:istiqamah_cula_cula_app/app/data/history/entities/history_entities.dart';
import 'package:istiqamah_cula_cula_app/app/data/history/usecases/get_history.dart';

class HistoryController extends GetxController {
  final GetHistory _getHistory = GetHistory();

  Future<List<HistoryEntities>> fetchHistory() async {
    final result = await _getHistory();
    return result.fold(
      (failure) {
        Get.snackbar("Gagal", failure.message ?? "Terjadi kesalahan");
        return [];
      },
      (data) => data,
    );
  }
}
