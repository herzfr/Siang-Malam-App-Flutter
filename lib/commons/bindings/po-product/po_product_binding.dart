import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/po-product/po_product_controller.dart';

class PoProductBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      PoProductController(),
    );
  }
}
