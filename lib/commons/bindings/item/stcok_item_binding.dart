import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/item/stock_item_controller.dart';

class StockItemBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      StockItemController(),
    );
  }
}
