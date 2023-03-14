import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/home/attendance_history_controller.dart';

/* Created By Dwi Sutrisno */

class AttendanceHistoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AttendanceHistoryController());
  }
}
