import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/home/leave_permission_controller.dart';

/* Created By Dwi Sutrisno */

class LeavePermissionBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(LeavePermissionController());
  }
}
