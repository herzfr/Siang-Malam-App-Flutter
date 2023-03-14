import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/saving/saving_controller.dart';

class SavingBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(SavingController());
  }
}
