import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/dashboard/dashboard_controller.dart';
import 'package:siangmalam/commons/controllers/home/home_controller.dart';
import 'package:siangmalam/commons/controllers/profile/account_controller.dart';

class DashboardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => AccountController());
  }
}
