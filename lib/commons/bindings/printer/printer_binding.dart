import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/printer/printer_controller.dart';

class PrinterBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      PrinterController(),
    );
  }
}
