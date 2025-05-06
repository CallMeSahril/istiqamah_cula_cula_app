import 'package:get/get.dart';
import 'package:istiqamah_cula_cula_app/app/data/auth/controller/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
