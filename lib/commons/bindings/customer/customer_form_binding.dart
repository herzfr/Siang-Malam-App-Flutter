import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/customer/customer_form_controller.dart';

class CustomerFormBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CustomerFormController());
  }
}
