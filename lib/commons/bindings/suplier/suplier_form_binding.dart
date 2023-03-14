import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/suplier/suplier_form_controller.dart';

class SuplierFormBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SuplierFormController());
  }
}
