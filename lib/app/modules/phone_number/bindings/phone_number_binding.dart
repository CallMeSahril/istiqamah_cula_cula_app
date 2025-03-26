import 'package:get/get.dart';

import '../controllers/phone_number_controller.dart';

class PhoneNumberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PhoneNumberController>(
      () => PhoneNumberController(),
    );
  }
}
