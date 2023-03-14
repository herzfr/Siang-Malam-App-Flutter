import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/profile/profile_form_controller.dart';

/* Created By Dwi Sutrisno */

class ProfileFormBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileFormController());
  }
}
