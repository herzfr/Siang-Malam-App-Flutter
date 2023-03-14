// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:logger/logger.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/models/product/stock_kitchen.dart';
import 'package:siangmalam/models/product/stock_product.dart';
import 'package:siangmalam/models/warehouse/warehouse.dart';
import 'package:siangmalam/services/app_static.dart';
import 'package:siangmalam/services/product/product_service.dart';
import 'package:siangmalam/services/product/spa_service.dart';
import 'package:siangmalam/services/warehouse/warehouse_service.dart';
import 'package:siangmalam/widgets/snack_bar.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SpaFormController extends GetxController {
  // var log = Logger();
  late int? branchId = AppStatic.userData.branchId;
  int? subBranchId;
  var level = AppStatic.userData.level;
  var role = AppStatic.userData.role;

  final formKey = GlobalKey<FormState>();

  final PanelController pcs = PanelController();
  var scrollController = ScrollController().obs;

  // PANEL
  final double initFabHeight = 5.h;
  double fabHeight = 0;
  double panelHeightOpen = 0;
  double panelHeightClosed = 5.h;

  var textFieldSearch = TextEditingController().obs;
  var textFieldNote = TextEditingController().obs;

  // DROPDOWN
  var warehouseDD = <DropdownMenuItem<ListWarehouse>>[].obs;

  var mainFilter = GetStockProd().obs;

  var search = ''.obs;
  var loadingPage = false.obs;

  var warehouseIn = ListWarehouse().obs;

  var listwarehouse = <ListWarehouse>[].obs;
  var resListProduct = RespStockProd().obs;
  var listProduct = <ListProducts>[].obs;

  var reqProdAdjstList = CreateProdAdjst().obs;
  var prodAdjstList = <AdjstItems>[].obs;

  @override
  void onInit() async {
    warehouseIn.value = ListWarehouse();
    super.onInit();

    await fetchDataWarehouse();
  }

  generateWarehouseDropdownTo() {
    for (var item in listwarehouse) {
      if (item.subBranchId == null) {
        warehouseDD.add(DropdownMenuItem<ListWarehouse>(
            child: Text(item.name.toString()), value: item));
      }
    }
  }

  initMainWarehouse() {
    int data = listwarehouse.indexWhere((p0) => p0.branchId == branchId);
    // log.d(data);
    warehouseIn.value = listwarehouse.elementAt(data);
    // log.d(warehouseFrom.toJson());
    generateWarehouseDropdownTo();
    getAllProduList();
  }

  getAllProduList() async {
    changePaginationFilter();
    loadingPage.value = true;
    await fetchListProduct();
    loadingPage.value = false;
  }

  changePaginationFilter() {
    mainFilter.update((val) {
      val?.branchId = warehouseIn.value.branchId;
      val?.subBranchId = null;
      val?.search = search.value;
    });
    // log.d(role);
    // log.d(mainFilter.toJson());
  }

  doAdjst() async {
    if (formKey.currentState!.validate()) {
      reqProdAdjstList.update((val) {
        // log.d(warehouseFrom.value.subBranchId);
        val?.warehouseId = warehouseIn.value.id;
        val?.name =
            "${AppStatic.userData.firstName} ${AppStatic.userData.lastName}";
        val?.note = textFieldNote.value.text;
        val?.items = prodAdjstList;
      });
      // log.d(reqProdAdjstList.toJson());
      createStock();
    }
  }

  refreshProduct() {
    // size.value = 10;
    // page.value = 0;
    loadingPage.value = false;
  }

  insertItemToList(index) {
    var product = AdjstItems();
    product.stockId = listProduct[index].id;
    product.quantity = 1;
    product.unit = listProduct[index].product!.unit;
    product.prodName = (listProduct[index].product!.name ?? '-');

    if (!prodAdjstList.any((e) => e.stockId == product.stockId)) {
      prodAdjstList.add(product);
      prodAdjstList.refresh();
      openClosePanelControl();
      // log.d(productUpsert.toJson());
    } else {
      Snackbar.show("Opps!", "Produk tidak boleh sama", mtRed600, mtGrey50);
    }
  }

  plus(int index) {
    // log.d(index);
    if (prodAdjstList.elementAt(index).quantity! > 0) {
      prodAdjstList.elementAt(index).quantity =
          (prodAdjstList.elementAt(index).quantity! + 1);
      prodAdjstList.refresh();
    }
  }

  minus(int index) {
    if (prodAdjstList.elementAt(index).quantity! > 1) {
      prodAdjstList.elementAt(index).quantity =
          (prodAdjstList.elementAt(index).quantity! - 1);
      prodAdjstList.refresh();
    }
  }

  openClosePanelControl() {
    if (pcs.isPanelClosed) {
      pcs.open();
    } else {
      pcs.close();
    }
  }

  // ==================================================
  // CALL API
  // ==================================================

  Future<void> fetchDataWarehouse() async {
    WarehouseTransfer warehouse = await WarehouseService.getWarehouseList("");
    listwarehouse.addAll(warehouse.listWarehouse!);
    for (var element in listwarehouse) {
      if (element.subBranchId == null) {
        warehouseIn.value == element;
      }
    }
    initMainWarehouse();
  }

  Future<void> fetchListProduct() async {
    RespStockProd listprod =
        await ProductService.getStockProductByBranch(mainFilter.value);
    listProduct.clear();
    listProduct.addAll(listprod.listProd!);
  }

  Future<void> createStock() async {
    // // log.d(reqOrder.toJson());
    await SpaService.createSPA(reqProdAdjstList.value);
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
