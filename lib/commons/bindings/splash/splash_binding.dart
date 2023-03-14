import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/splash/splash_controller.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}
