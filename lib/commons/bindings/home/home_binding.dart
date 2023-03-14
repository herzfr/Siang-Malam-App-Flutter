import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/home/home_controller.dart';

/* Created By Dwi Sutrisno */

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    // Get.put(HomeController());
    Get.lazyPut(() => HomeController(), fenix: true);
  }
}
