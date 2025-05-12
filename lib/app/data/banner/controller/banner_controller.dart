import 'package:get/get.dart';
import 'package:istiqamah_cula_cula_app/app/data/banner/model/banner_model.dart';
import 'package:istiqamah_cula_cula_app/app/data/banner/usecases/get_banner.dart';
import 'package:istiqamah_cula_cula_app/app/data/banner/usecases/get_iklan.dart';

class BannerController extends GetxController {
  final GetBanner _getBanner = GetBanner();
  final GetIklan _getIklan = GetIklan();

  var bannerList = <BannerEntities>[].obs;
  var iklanList = <BannerEntities>[].obs;

  Future<void> fetchBanners() async {
    final result = await _getBanner.call();
    result.fold(
      (failure) => print("Banner Error: ${failure.message}"),
      (data) => bannerList.value = data,
    );
  }

  Future<void> fetchIklan() async {
    final result = await _getIklan.call();
    result.fold(
      (failure) => print("Iklan Error: ${failure.message}"),
      (data) => iklanList.value = data,
    );
  }
}
