import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/product/spa_controller.dart';
import 'package:siangmalam/commons/controllers/product/spa_form_controller.dart';

class SpaBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      SpaController(),
    );
  }
}

class SpaFormBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      SpaFormController(),
    );
  }
}
