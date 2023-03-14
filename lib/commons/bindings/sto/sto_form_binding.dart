import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/sto/sto_form_controller.dart';

class StoFormBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StoFormController());
  }
}
