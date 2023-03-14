import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/product/stock_product_form_controller.dart';

class StockProductFormBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StockProductFormController());
  }
}
