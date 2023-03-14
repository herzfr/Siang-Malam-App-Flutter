import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/po-purchasing/item/po-item-credit.controller.dart';
import 'package:siangmalam/commons/controllers/po-purchasing/item/po-item-form.controller.dart';
import 'package:siangmalam/commons/controllers/po-purchasing/item/po-item-upload.controller.dart';
import 'package:siangmalam/commons/controllers/po-purchasing/item/po-item.controller.dart';
import 'package:siangmalam/commons/controllers/po-purchasing/product/po-product-form.controller.dart';
import 'package:siangmalam/commons/controllers/po-purchasing/product/po-product.controller.dart';
import 'package:siangmalam/commons/controllers/po-purchasing/product/po_product_credit.controller.dart';
import 'package:siangmalam/commons/controllers/po-purchasing/product/po_product_upload.controller.dart';

class PoProductBindingV2 implements Bindings {
  @override
  void dependencies() {
    Get.put(
      PoProductControllerV2(),
    );
  }
}

class PoProductFormBindingV2 implements Bindings {
  @override
  void dependencies() {
    Get.put(
      PoProductFormControllerV2(),
    );
  }
}

class PoProdUploadBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      PoUploadController(),
    );
  }
}

class PoProdCreditBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      PoProductCreditController(),
    );
  }
}

class PoItemBindingV2 implements Bindings {
  @override
  void dependencies() {
    Get.put(
      PoItemControllerV2(),
    );
  }
}

class PoItemFormBindingV2 implements Bindings {
  @override
  void dependencies() {
    Get.put(
      PoItemFormControllerV2(),
    );
  }
}

class PoItemUploadBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      PoItemUploadControllerV2(),
    );
  }
}

class PoItemCreditBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      PoItemCreditControllerV2(),
    );
  }
}
