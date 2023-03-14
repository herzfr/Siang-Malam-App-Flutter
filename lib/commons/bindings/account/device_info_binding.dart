import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/profile/device_info_controller.dart';

/* Created By Dwi Sutrisno */

class DeviceInfoBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(DeviceInfoController());
  }
}
