import 'package:get/get.dart';
import 'package:istiqamah_cula_cula_app/app/data/banner/controller/banner_controller.dart';

class BannerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BannerController>(() => BannerController());
  }
}
