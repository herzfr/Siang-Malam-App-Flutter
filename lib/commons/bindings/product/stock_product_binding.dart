import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/product/stock_product_controller.dart';

class StockProductBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      StockProductController(),
    );
  }
}
