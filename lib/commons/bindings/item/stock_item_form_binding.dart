import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/item/stock_item_form_controller.dart';

class StockItemFormBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StockItemFormController());
  }
}
