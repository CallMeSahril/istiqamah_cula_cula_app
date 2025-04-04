import 'package:get/get.dart';

import '../controllers/katagori_controller.dart';

class KatagoriBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KatagoriController>(
      () => KatagoriController(),
    );
  }
}
