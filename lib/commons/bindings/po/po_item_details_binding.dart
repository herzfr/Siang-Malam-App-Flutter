import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/po/po_item_details_controller.dart';

class PoItemDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PoItemDetailsController());
  }
}
