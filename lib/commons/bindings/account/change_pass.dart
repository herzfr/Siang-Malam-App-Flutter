import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/profile/change_pass_controller.dart';

/* Created By Dwi Sutrisno */

class ChangePassBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ChangePassController());
  }
}
