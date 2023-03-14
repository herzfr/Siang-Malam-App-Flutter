import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/order/table_form_controller.dart';

class TableFormBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TableFormController());
  }
}
