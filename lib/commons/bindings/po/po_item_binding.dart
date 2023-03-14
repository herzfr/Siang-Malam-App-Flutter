import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/po/po_item_controller.dart';

class PoItemBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      PoItemController(),
    );
  }
}
