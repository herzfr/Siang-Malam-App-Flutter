import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/po-product/po_product_details_controller.dart';

class PoProductDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PoProductDetailsController());
  }
}
