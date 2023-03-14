import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/discount/discount_form_controller.dart';

class DiscountFormBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DiscountFormController());
  }
}
