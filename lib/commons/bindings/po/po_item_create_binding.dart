import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/po/po_item_create_controller.dart';

class PoItemCreateBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PoItemCreateController());
  }
}
