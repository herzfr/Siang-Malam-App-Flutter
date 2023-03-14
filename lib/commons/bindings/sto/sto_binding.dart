import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/sto/sto_controller.dart';

class StoBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(StoController());
  }
}
