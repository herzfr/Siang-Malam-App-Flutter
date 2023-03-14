import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/product/transfer_product_controller.dart';
import 'package:siangmalam/commons/controllers/product/transfer_product_form_controller.dart';
import 'package:siangmalam/commons/controllers/product/transfer_product_receive_controller.dart';

class TransferProductBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      TransferProductController(),
    );
  }
}

class TransferFormProductBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      TransferFormProductController(),
    );
  }
}

class TransferReceiveProductBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      TransferReceiveProductController(),
    );
  }
}
