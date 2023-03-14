import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/po-product/po_product_create_controller.dart';

class PoProductCreateBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PoProductCreateController());
  }
}
