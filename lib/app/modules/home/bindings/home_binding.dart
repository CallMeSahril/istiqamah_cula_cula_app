import 'package:get/get.dart';
import 'package:istiqamah_cula_cula_app/app/data/banner/controller/banner_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  
  }
}
