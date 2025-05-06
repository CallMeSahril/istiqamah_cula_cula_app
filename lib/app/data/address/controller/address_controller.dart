import 'package:get/get.dart';
import 'package:istiqamah_cula_cula_app/app/data/address/entities/address_entities.dart';
import 'package:istiqamah_cula_cula_app/app/data/address/usescases/add_addresses.dart';
import 'package:istiqamah_cula_cula_app/app/data/address/usescases/delete_address.dart';
import 'package:istiqamah_cula_cula_app/app/data/address/usescases/get_addresses.dart';
import 'package:istiqamah_cula_cula_app/app/data/address/usescases/update_address.dart';

class AddressController extends GetxController {
  final GetAddresses _getAddresses = GetAddresses();
  final AddAddress _addAddress = AddAddress();
  final UpdateAddress _updateAddress = UpdateAddress();
  final DeleteAddress _deleteAddress = DeleteAddress();

  RxList<AddressEntities> addresses = <AddressEntities>[].obs;
  RxBool isLoading = false.obs;

  Future<void> fetchAddresses() async {
    isLoading.value = true;
    final result = await _getAddresses();
    result.fold(
      (failure) =>
          Get.snackbar("Gagal", failure.message ?? "Terjadi kesalahan"),
      (data) => addresses.value = data,
    );
    isLoading.value = false;
  }

  Future<bool> addAddress(AddressEntities address) async {
    final result = await _addAddress(address);
    return result.fold(
      (failure) {
        Get.snackbar("Gagal", failure.message ?? "Gagal menambah alamat");
        return false;
      },
      (success) => true,
    );
  }

  Future<bool> updateAddress(int id, AddressEntities address) async {
    final result = await _updateAddress(id, address);
    return result.fold(
      (failure) {
        Get.snackbar("Gagal", failure.message ?? "Gagal memperbarui alamat");
        return false;
      },
      (success) => true,
    );
  }

  Future<bool> deleteAddress(int id) async {
    final result = await _deleteAddress(id);
    return result.fold(
      (failure) {
        Get.snackbar("Gagal", failure.message ?? "Gagal menghapus alamat");
        return false;
      },
      (success) => true,
    );
  }
}
