import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:logger/logger.dart';
import 'package:siangmalam/constans/colors.dart';
// import 'package:siangmalam/models/PaginationFilter.dart';
import 'package:siangmalam/models/product/stock_product.dart';
import 'package:siangmalam/models/transfer/upsert_transfer.dart';
import 'package:siangmalam/models/warehouse/warehouse.dart';
import 'package:siangmalam/services/app_static.dart';
import 'package:siangmalam/services/product/product_service.dart';
import 'package:siangmalam/services/warehouse/warehouse_service.dart';
import 'package:siangmalam/widgets/snack_bar.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:sizer/sizer.dart';

class TransferFormProductController extends GetxController {
  // var log = Logger();
  late int? branchId = AppStatic.userData.branchId;
  int? subBranchId;
  var level = AppStatic.userData.level;
  var role = AppStatic.userData.role;

  final formKey = GlobalKey<FormState>();

  final PanelController pcs = PanelController();
  var scrollController = ScrollController().obs;

  // PANEL
  final double _initFabHeight = 10.h;
  double fabHeight = 0;
  double panelHeightOpen = 0;
  double panelHeightClosed = 10.h;

  var textFieldSearch = TextEditingController().obs;
  var textFieldNote = TextEditingController().obs;

  // DROPDOWN
  var warehouseDD = <DropdownMenuItem<ListWarehouse>>[].obs;
  // var warehouseDDF = <DropdownMenuItem<ListWarehouse>>[].obs;

  // Main Filter
  // var mainFilter = PaginationFilter().obs;
  var mainFilter = GetStockProd().obs;
  // var size = 10.obs;
  // var page = 0.obs;
  var search = ''.obs;
  var loadingPage = false.obs;
  // var allloadedPage = false.obs;

  var warehouseTo = ListWarehouse().obs;
  var warehouseFrom = ListWarehouse().obs;

  var listwarehouse = <ListWarehouse>[].obs;
  var resListProduct = RespStockProd().obs;
  var listProduct = <ListProducts>[].obs;
  var productUpsert = <ProductsUpsertTransfer>[].obs;
  var upsertTf = UpsertTransfer().obs;

  @override
  void onInit() async {
    warehouseTo.value = ListWarehouse();
    warehouseFrom.value = ListWarehouse();
    super.onInit();
    // await roleFrom();
    await fetchDataWarehouse();
    // await generateWarehouseDropdownFrom();
  }

  generateWarehouseDropdownTo() {
    warehouseDD.add(const DropdownMenuItem<ListWarehouse>(
        child: Text('Pilih Cabang Tujuan'), value: null));
    for (var item in listwarehouse) {
      if (item.subBranchId != warehouseFrom.value.subBranchId) {
        warehouseDD.add(DropdownMenuItem<ListWarehouse>(
            child: Text(item.name.toString()), value: item));
      }
    }
  }

  // generateWarehouseDropdownFrom() {
  //   for (var item in listwarehouse) {
  //     warehouseDDF.add(DropdownMenuItem<ListWarehouse>(
  //         child: Text(item.name.toString()), value: item));
  //   }
  // }

  initMainWarehouse() {
    int data = listwarehouse.indexWhere((p0) => p0.branchId == branchId);
    // log.d(data);
    warehouseFrom.value = listwarehouse.elementAt(data);
    // log.d(warehouseFrom.toJson());
    generateWarehouseDropdownTo();
    getAllProduList();
  }

  changeDropdownFrom(ListWarehouse list) {
    warehouseFrom.value = list;
    branchId = warehouseFrom.value.branchId;
    subBranchId = warehouseFrom.value.subBranchId;
    getAllProduList();
    warehouseDD.clear();
    generateWarehouseDropdownTo();
    warehouseDD.refresh();
    // // log.d(list.toJson());
    // if (list.subBranchId != warehouseTo.value.subBranchId) {
    //   warehouseFrom.value = list;
    //   branchId = warehouseFrom.value.branchId;
    //   subBranchId = warehouseFrom.value.subBranchId;
    //   getAllProduList();
    //   warehouseDD.clear();
    //   generateWarehouseDropdownTo();
    //   warehouseDD.refresh();
    // } else {
    //   warehouseDDF.clear();
    //   warehouseDDF.refresh();
    //   generateWarehouseDropdownFrom();
    // }
  }

  changePaginationFilter() {
    mainFilter.update((val) {
      val?.branchId = branchId;
      val?.subBranchId = subBranchId;
      val?.search = search.value;
    });
    // log.d(role);
    // log.d(mainFilter.toJson());
  }

  getAllProduList() async {
    changePaginationFilter();
    loadingPage.value = true;
    await fetchListProduct();
    loadingPage.value = false;
  }

  refreshProduct() {
    // size.value = 10;
    // page.value = 0;
    loadingPage.value = false;
  }

  openClosePanelControl() {
    if (pcs.isPanelClosed) {
      pcs.open();
    } else {
      pcs.close();
    }
  }

  insertItemToList(index) {
    var product = ProductsUpsertTransfer();
    product.name = listProduct[index].product!.name ?? '-';
    product.productId = listProduct[index].productId;
    product.id = listProduct[index].id;
    product.quantity = 1;
    product.unit = listProduct[index].product!.unit;
    product.quantityFrom = (listProduct[index].quantity ?? 0) - 1;

    if (!productUpsert.any((e) => e.productId == product.productId)) {
      productUpsert.add(product);
      productUpsert.refresh();
      openClosePanelControl();
      // log.d(productUpsert.toJson());
    } else {
      Snackbar.show("Opps!", "Bahan tidak boleh sama", mtRed600, mtGrey50);
    }
  }

  plus(int index) {
    // log.d(index);
    if (productUpsert.elementAt(index).quantityFrom! > 0) {
      productUpsert.elementAt(index).quantityFrom =
          productUpsert.elementAt(index).quantityFrom! - 1;
      productUpsert.elementAt(index).quantity =
          (productUpsert.elementAt(index).quantity! + 1);
      productUpsert.refresh();
    }
  }

  minus(int index) {
    // log.d(index);
    if (productUpsert.elementAt(index).quantity! > 1) {
      productUpsert.elementAt(index).quantityFrom =
          productUpsert.elementAt(index).quantityFrom! + 1;
      productUpsert.elementAt(index).quantity =
          (productUpsert.elementAt(index).quantity! - 1);
      productUpsert.refresh();
    }
  }

  doTransfer() async {
    if (formKey.currentState!.validate()) {
      upsertTf.update((val) {
        // log.d(warehouseFrom.value.subBranchId);
        val?.frmWarehouseId = warehouseFrom.value.id;
        val?.destWarehouseId = warehouseTo.value.id;
        val?.note = textFieldNote.value.text;
        val?.products = productUpsert;
        val?.isBack = warehouseTo.value.subBranchId != null ? false : true;
        val?.isDelivery = true;
        val?.isSenderApproved = true;
        val?.isReceiverApproved = false;
        val?.sendBy = AppStatic.userData.username;
        val?.sendApprover = AppStatic.userData.username;
        val?.receiveBy = '';
        val?.receiveApprover = '';
      });
      // log.d(upsertTf.toJson());
      createTransfer();
    }
  }

  // ==================================================
  // CALL API
  // ==================================================

  Future<void> fetchDataWarehouse() async {
    // // log.d(reqOrder.toJson());
    WarehouseTransfer warehouse = await WarehouseService.getWarehouseList("");
    listwarehouse.addAll(warehouse.listWarehouse!);
    initMainWarehouse();
  }

  Future<void> fetchListProduct() async {
    // // log.d(reqOrder.toJson());
    RespStockProd listprod =
        await ProductService.getStockProductByBranch(mainFilter.value);
    // log.d(listprod.toJson());
    listProduct.clear();
    listProduct.addAll(listprod.listProd!);
    // log.d(listProduct.length);
  }

  Future<void> createTransfer() async {
    // // log.d(reqOrder.toJson());
    await ProductService.createTransferList(upsertTf.value);
  }

  @override
  void onClose() {
    super.onClose();
  }
}
