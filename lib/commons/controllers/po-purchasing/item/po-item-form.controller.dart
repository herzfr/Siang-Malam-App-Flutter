import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
// import 'package:logger/logger.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/models/PaginationFilter.dart';
import 'package:siangmalam/models/purchase-orders/po-item.dart';
// import 'package:siangmalam/models/purchase-orders/po-product.dart';
import 'package:siangmalam/models/purchase-orders/product-po.dart';
import 'package:siangmalam/models/suplier/suplier.dart';
import 'package:siangmalam/models/warehouse/warehouse.dart';
import 'package:siangmalam/services/app_static.dart';
import 'package:siangmalam/services/po/po_service.dart';
import 'package:siangmalam/services/po/purchase-item.service.dart';
import 'package:siangmalam/services/suplier/suplier_service.dart';
import 'package:siangmalam/services/warehouse/warehouse_service.dart';
import 'package:siangmalam/widgets/snack_bar.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PoItemFormControllerV2 extends GetxController {
  // var log = Logger();
  late int? branchId = AppStatic.userData.branchId;
  int? subBranchId;
  final PanelController pcs = PanelController();
  var scrollController = ScrollController().obs;

  final formKey = GlobalKey<FormState>();

  // PANEL
  final double initFabHeight = 5.h;
  double fabHeight = 0;
  double panelHeightOpen = 0;
  double panelHeightClosed = 5.h;

  var loadingPage = false.obs;
  var allLoadedPage = false.obs;
  var isCreated = true.obs;
  var isSubmit = false.obs;

  // DATA
  var listPopitem = ListPoItem().obs;
  var listwarehouse = <ListWarehouse>[].obs;
  var listSuplier = <ListSuplier>[].obs;
  var itemI = SeedItemForPo().obs;
  var listItem = <SeedItemList>[].obs;
  var upsertPoItem = UpsertPoItem().obs;
  var mainFilter = PaginationFilter().obs;
  // var Productfilter = PaginationFilter().obs;

  // DROPDOWN
  var warehouseDD = <DropdownMenuItem<int>>[].obs;
  var suplierDD = <DropdownMenuItem<int>>[].obs;

  // TEXT CONTROLLER
  var textFieldSearch = TextEditingController(text: "").obs;
  var textFieldNote = TextEditingController(text: "").obs;

  final myController = TextEditingController();
  var quantityController = <TextEditingController>[].obs;
  var costController = <TextEditingController>[].obs;

  @override
  void onInit() async {
    super.onInit();
    listPopitem.value = Get.arguments ?? ListPoItem();
    // log.d(listPopitem.toJson());
    scrollController.value.addListener(() {
      if (scrollController.value.position.pixels >=
              scrollController.value.position.maxScrollExtent &&
          loadingPage.isFalse) {
        getAllItem();
      }
    });
    if (listPopitem.value.id != null) {
      isCreated.value = false;
    }
    textFieldNote.value.text = listPopitem.value.note ?? '';
    await init();
  }

  // =======================================
  // INIT
  // =======================================

  init() async {
    if (isCreated.isFalse) {
      await initListItem();
      await fetchDataWarehouse();
      await fetchDataSuplier();
      await initPaginationFilter();
      await getAllItem();
      await generateWarehouseDropdown();
      await generateSuplierDropdown();
    } else {
      await fetchDataWarehouse();
      await fetchDataSuplier();
      await generateWarehouseDropdown();
      await generateSuplierDropdown();
      await initPaginationFilter();
      await getAllItem();
    }
  }

  /* Get User Data Function */
  initListItem() {
    // log.d(listPopitem.toJson());
    for (var element in listPopitem.value.items!) {
      quantityController.add(TextEditingController(
          text: element.quantity != null
              ? element.quantity.toString()
              : 0.toString()));
      costController.add(TextEditingController(
          text: element.cost != null ? element.cost.toString() : 0.toString()));
    }
    // arrayController.addAll()
    // log.d(listPopitem.toJson());
  }

  initPaginationFilter() {
    mainFilter.update((val) {
      val?.page = 0;
      val?.size = 10;
      val?.search = textFieldSearch.value.text;
    });
  }

  initMainWarehouse() {
    if (isCreated.isFalse) {
      int data = listwarehouse
          .indexWhere((p0) => p0.id == listPopitem.value.warehouseId);
      listPopitem.value.warehouseId = listwarehouse.elementAt(data).id;
    } else {
      listPopitem.value.warehouseId = listwarehouse.elementAt(0).id;
    }
  }

  initMainSuplier() {
    if (isCreated.isFalse) {
      int data =
          listSuplier.indexWhere((p0) => p0.id == listPopitem.value.suplierId);
      listPopitem.value.suplierId = listSuplier.elementAt(data).id;
    } else {
      listPopitem.value.suplier = null;
    }
  }

  // =======================================
  // METHOD
  // =======================================

  generateWarehouseDropdown() {
    if (isCreated.isTrue) {
      warehouseDD
          .add(const DropdownMenuItem<int>(child: Text('Pilih'), value: null));
    }
    for (var item in listwarehouse) {
      warehouseDD.add(DropdownMenuItem<int>(
          child: Text(item.name.toString()), value: item.id));
    }
  }

  generateSuplierDropdown() {
    if (isCreated.isTrue) {
      suplierDD.add(const DropdownMenuItem<int>(
          child: Text('Tidak Pakai Suplier'), value: null));
    }
    for (var item in listSuplier) {
      suplierDD.add(DropdownMenuItem<int>(
          child: Text(item.name.toString()), value: item.id));
    }
  }

  getAllItem() async {
    loadingPage.value = true;
    if (allLoadedPage.isTrue) {
      loadingPage.value = false;
      loadingPage.refresh();
      return;
    }
    await fetchDataItem();
  }

  oneShot() {
    initPaginationFilter();
    fetchDataItem();
  }

  recoverData() {
    loadingPage.value = false;
    allLoadedPage.value = false;
    itemI.value = SeedItemForPo();
    listItem.clear();
  }

  insertItemToList(int idx) {
    // log.d(listProduct[idx].toJson());
    var item = ItemsPo();
    item.id = null;
    item.name = listItem[idx].name;
    item.itemId = listItem[idx].id;
    item.quantity = 1;
    item.cost = 0;
    item.unit = listItem[idx].unit;

    List<ItemsPo>? data;
    if (listPopitem.value.items == null) {
      data = <ItemsPo>[];
    } else {
      data = listPopitem.value.items!;
    }
    if (!data.any((e) => e.itemId == listItem[idx].id)) {
      data.add(item);
      listPopitem.value.items = data;
      quantityController.add(TextEditingController(
          text:
              item.quantity != null ? item.quantity.toString() : 0.toString()));
      costController.add(TextEditingController(
          text: item.cost != null ? item.cost.toString() : 0.toString()));
      listPopitem.refresh();
      quantityController.refresh();
      costController.refresh();
    } else {
      Snackbar.show("Opps!", "Produk tidak boleh sama", mtRed600, mtGrey50);
    }

    // log.d(listPopitem.toJson());
    openClosePanelControl();
  }

  plus(int index) {
    if (listPopitem.value.items!.elementAt(index).quantity! > 0) {
      listPopitem.value.items!.elementAt(index).quantity =
          (listPopitem.value.items!.elementAt(index).quantity! + 1);
      listPopitem.refresh();
      quantityController[index].text =
          listPopitem.value.items!.elementAt(index).quantity.toString();
    }
  }

  minus(int index) {
    if (listPopitem.value.items!.elementAt(index).quantity! > 1) {
      listPopitem.value.items!.elementAt(index).quantity =
          (listPopitem.value.items!.elementAt(index).quantity! - 1);
      listPopitem.refresh();
      quantityController[index].text =
          listPopitem.value.items!.elementAt(index).quantity.toString();
    }
  }

  changeQuantity(int index, String value) {
    // log.d(index, value);
    listPopitem.value.items!.elementAt(index).quantity = int.parse(value);
    listPopitem.refresh();
    // log.d(listPopitem.toJson());
  }

  changeCost(int index, String value) {
    // log.d(index, value);
    listPopitem.value.items!.elementAt(index).cost = int.parse(value);
    listPopitem.refresh();
    // log.d(listPopitem.toJson());
  }

  openClosePanelControl() {
    if (pcs.isPanelClosed) {
      pcs.open();
    } else {
      pcs.close();
    }
  }

  getDataLengthItem() {
    int length = listPopitem.value.items!.length;
    return length;
  }

  delete(int index) {
    listPopitem.value.items!.removeAt(index);
    quantityController.removeAt(index);
    costController.removeAt(index);
    listPopitem.refresh();
    quantityController.refresh();
    costController.refresh();
  }

  createSubmit() {
    // log.d(listPoproduct.toJson());
    // var upsertPoProduct = UpsertPoProduct();
    upsertPoItem.update((val) {
      val?.orderNo = listPopitem.value.orderNo;
      val?.note = textFieldNote.value.text;
      val?.suplierId = listPopitem.value.suplierId;
      val?.warehouseId = listPopitem.value.warehouseId;
      val?.items = listPopitem.value.items;
    });
    // log.d(upsertPoItem.toJson());
    createDataPoItem();
  }

  updateSubmit() {
    // log.d(listPopitem.toJson());
    upsertPoItem.update((val) {
      val?.orderNo = listPopitem.value.orderNo;
      val?.note = listPopitem.value.note;
      val?.suplierId = listPopitem.value.suplierId;
      val?.warehouseId = listPopitem.value.warehouseId;
      val?.items = listPopitem.value.items;
    });
    // log.d(upsertPoItem.toJson());
    updateDataPoItem();
  }

  // =======================================
  // API
  // =======================================

  Future<void> fetchDataWarehouse() async {
    WarehouseTransfer warehouse = await WarehouseService.getWarehouseList("");
    listwarehouse.addAll(warehouse.listWarehouse!);
    // log.d(listwarehouse.toJson());
    initMainWarehouse();
  }

  Future<void> fetchDataSuplier() async {
    Suplier suplier = await SuplierService.getSuplierWithoutParams();
    listSuplier.addAll(suplier.listSuplier!);
    // log.d(suplier.toJson());
    initMainWarehouse();
  }

  Future<void> fetchDataItem() async {
    try {
      itemI.value = await PoService.getItemV2(mainFilter.value);
      mainFilter.value.page = itemI.value.pageable!.pageNumber! + 1;
      mainFilter.value.size = itemI.value.pageable!.pageSize!;

      List<SeedItemList> newData =
          listItem.length >= itemI.value.pageable!.totalElements!
              ? []
              : itemI.value.listProduct!;

      if (newData.isNotEmpty) {
        for (var e in newData) {
          listItem.add(e);
        }
        listItem.refresh();
      }
      loadingPage.value = false;
      loadingPage.refresh();
      allLoadedPage.value = newData.isEmpty;
      loadingPage.refresh();
    } catch (error) {
      // log.d(error);
      Snackbar.show("Opps!", error.toString(), mtRed600, mtGrey50);
    }
  }

  Future<void> updateDataPoItem() async {
    isSubmit.value = true;
    bool result = await PurchaseItemService.updatePoItem(upsertPoItem.value);
    isSubmit.value = false;
  }

  Future<void> createDataPoItem() async {
    isSubmit.value = true;
    bool result = await PurchaseItemService.createPoItem(upsertPoItem.value);
    isSubmit.value = false;
  }

  // =======================================
  // UTIL
  // =======================================

  convertPrice(int? price) {
    if (price != null) {
      final currencyFormatter = NumberFormat('#,##0', 'ID');
      return 'Rp ' + currencyFormatter.format(price);
    } else {
      return 'Rp 0';
    }
  }

  @override
  void onClose() {
    listPopitem.value = ListPoItem();
    update();
    super.onClose();
    // var listPoproduct = ListPoProduct().obs;
    // var listwarehouse = <ListWarehouse>[].obs;
    // var listSuplier = <ListSuplier>[].obs;
    // var productI = SeedProductForPo().obs;
    // var listProduct = <SeedProductList>[].obs;
    // var upsertPoProduct = UpsertPoProduct().obs;
    // var mainFilter = PaginationFilter().obs;
  }
}
