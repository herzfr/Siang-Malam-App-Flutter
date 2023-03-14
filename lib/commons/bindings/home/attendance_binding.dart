import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/home/attendance_controller.dart';

/* Created By Dwi Sutrisno */

class AttendanceBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AttendanceController());
  }
}
