import 'package:get/get.dart';
import 'package:istiqamah_cula_cula_app/app/data/rajaongkir/entities/city.dart';
import 'package:istiqamah_cula_cula_app/app/data/rajaongkir/entities/courier.dart';
import 'package:istiqamah_cula_cula_app/app/data/rajaongkir/entities/ongkir_service.dart';
import 'package:istiqamah_cula_cula_app/app/data/rajaongkir/entities/province.dart';
import 'package:istiqamah_cula_cula_app/app/data/rajaongkir/usescases/check_ongkir.dart';
import 'package:istiqamah_cula_cula_app/app/data/rajaongkir/usescases/get_cities.dart';
import 'package:istiqamah_cula_cula_app/app/data/rajaongkir/usescases/get_couriers.dart';
import 'package:istiqamah_cula_cula_app/app/data/rajaongkir/usescases/get_provinces.dart';

class RajaOngkirController extends GetxController {
  final provinces = <Province>[].obs;
  final cities = <City>[].obs;
  final couriers = <Courier>[].obs;
  final services = <OngkirService>[].obs;

  final getProvincesUseCase = GetProvinces();
  final getCitiesUseCase = GetCities();
  final getCouriersUseCase = GetCouriers();
  final checkOngkirUseCase = CheckOngkir();

  Future<void> fetchProvinces() async {
    final result = await getProvincesUseCase();
    result.fold(
      (failure) =>
          Get.snackbar('Gagal', failure.message ?? 'Terjadi kesalahan'),
      (data) => provinces.assignAll(data),
    );
  }

  Future<void> fetchCities(int provinceId) async {
    final result = await getCitiesUseCase(provinceId);
    result.fold(
      (failure) =>
          Get.snackbar('Gagal', failure.message ?? 'Terjadi kesalahan'),
      (data) => cities.assignAll(data),
    );
  }

  Future<void> fetchCouriers() async {
    final result = await getCouriersUseCase();
    result.fold(
      (failure) =>
          Get.snackbar('Gagal', failure.message ?? 'Terjadi kesalahan'),
      (data) => couriers.assignAll(data),
    );
  }

  Future<void> fetchOngkir({
    required int origin,
    required int destination,
    required int weight,
    required String courier,
  }) async {
    final result = await checkOngkirUseCase(
      origin: origin,
      destination: destination,
      weight: weight,
      courier: courier,
    );
    result.fold(
      (failure) =>
          Get.snackbar('Gagal', failure.message ?? 'Terjadi kesalahan'),
      (data) => services.assignAll(data),
    );
  }
}
