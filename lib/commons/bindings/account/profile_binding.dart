import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/profile/account_controller.dart';

/* Created By Dwi Sutrisno */

class AccountBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AccountController());
  }
}
