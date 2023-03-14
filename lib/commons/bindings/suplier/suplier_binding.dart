import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/suplier/suplier_controller.dart';

class SuplierBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      SuplierController(),
    );
  }
}
