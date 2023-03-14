import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/customer/customer_controller.dart';

class CustomerBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      CustomerController(),
    );
  }
}
