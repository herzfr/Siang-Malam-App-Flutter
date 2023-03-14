import 'package:get/get.dart';
// import 'package:logger/logger.dart';
import 'package:siangmalam/models/transfer/transfer.dart';
import 'package:siangmalam/models/transfer/upsert_transfer.dart';
import 'package:siangmalam/services/app_static.dart';
import 'package:siangmalam/services/product/product_service.dart';

class TransferReceiveProductController extends GetxController {
  // var log = Logger();
  late int? branchId = AppStatic.userBranchData.id;
  int? subBranchId;
  var level = AppStatic.userData.level;
  var role = AppStatic.userData.role;

  var productUpsert = <ProductsUpsertTransfer>[].obs;
  var upsertTf = UpsertTransfer().obs;
  var transfer = TransferList();

  @override
  void onInit() async {
    super.onInit();
    await getTransferDatas();
    await getProduct();
    // log.d(transfer.toJson());
    // log.d(productUpsert.toJson());
  }

  /* Get User Data Function */
  getTransferDatas() {
    transfer = Get.arguments;
  }

  getProduct() {
    for (var item in transfer.products!) {
      var product = ProductsUpsertTransfer();
      product.name = item.name;
      product.productId = item.productId;
      product.id = item.id;
      product.quantity = item.quantity;
      product.quantityFrom = item.quantity;
      productUpsert.add(product);
    }
    productUpsert.refresh();
  }

  plus(int index) {
    // log.d(index);
    if (productUpsert.elementAt(index).quantityFrom! > 0) {
      productUpsert.elementAt(index).quantity =
          (productUpsert.elementAt(index).quantity! + 1);
      productUpsert.refresh();
    }
  }

  minus(int index) {
    // log.d(index);
    if (productUpsert.elementAt(index).quantity! > 1) {
      productUpsert.elementAt(index).quantity =
          (productUpsert.elementAt(index).quantity! - 1);
      productUpsert.refresh();
    }
  }

  doConfirm() async {
    upsertTf.update((val) {
      val?.id = transfer.id;
      val?.frmWarehouseId = transfer.frmWarehouseId;
      val?.destWarehouseId = transfer.destWarehouseId;
      val?.note = transfer.note;
      val?.products = productUpsert;
      val?.isBack = transfer.isBack;
      val?.isDelivery = false;
      val?.isSenderApproved = true;
      val?.isReceiverApproved = true;
      val?.sendBy = transfer.sendBy;
      val?.sendApprover = transfer.sendApprover;
      val?.receiveBy = AppStatic.userData.username;
      val?.receiveApprover = AppStatic.userData.username;
    });
    // log.d(upsertTf.toJson());
    updateTransfer();
  }

  Future<void> updateTransfer() async {
    await ProductService.updateTransferList(upsertTf.value);
  }

  // @override
  // void onClose() {
  //   // TODO: implement onClose
  //   super.onClose();
  // }
}
