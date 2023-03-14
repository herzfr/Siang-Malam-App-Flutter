import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/discount/discount_controller.dart';

class DiscountBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      DiscountController(),
    );
  }
}
