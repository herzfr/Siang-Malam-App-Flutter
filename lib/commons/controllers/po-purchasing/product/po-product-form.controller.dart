import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
// import 'package:logger/logger.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/models/PaginationFilter.dart';
import 'package:siangmalam/models/purchase-orders/po-product.dart';
import 'package:siangmalam/models/purchase-orders/product-po.dart';
import 'package:siangmalam/models/suplier/suplier.dart';
import 'package:siangmalam/models/warehouse/warehouse.dart';
import 'package:siangmalam/services/app_static.dart';
import 'package:siangmalam/services/po/po_prod_service.dart';
import 'package:siangmalam/services/po/purchase-product.service.dart';
import 'package:siangmalam/services/suplier/suplier_service.dart';
import 'package:siangmalam/services/warehouse/warehouse_service.dart';
import 'package:siangmalam/widgets/snack_bar.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PoProductFormControllerV2 extends GetxController {
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
  var listPoproduct = ListPoProduct().obs;
  var listwarehouse = <ListWarehouse>[].obs;
  var listSuplier = <ListSuplier>[].obs;
  var productI = SeedProductForPo().obs;
  var listProduct = <SeedProductList>[].obs;
  var upsertPoProduct = UpsertPoProduct().obs;
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
    listPoproduct.value = Get.arguments ?? ListPoProduct();
    // log.d(listPoproduct.toJson());
    scrollController.value.addListener(() {
      if (scrollController.value.position.pixels >=
              scrollController.value.position.maxScrollExtent &&
          loadingPage.isFalse) {
        getAllProduct();
      }
    });
    if (listPoproduct.value.id != null) {
      isCreated.value = false;
    }
    textFieldNote.value.text = listPoproduct.value.note ?? '';
    await init();
  }

  // =======================================
  // INIT
  // =======================================

  init() async {
    if (isCreated.isFalse) {
      await initListProduct();
      await fetchDataWarehouse();
      await fetchDataSuplier();
      await initPaginationFilter();
      await getAllProduct();
      await generateWarehouseDropdown();
      await generateSuplierDropdown();
    } else {
      await fetchDataWarehouse();
      await fetchDataSuplier();
      await generateWarehouseDropdown();
      await generateSuplierDropdown();
      await initPaginationFilter();
      await getAllProduct();
    }
  }

  /* Get User Data Function */
  initListProduct() {
    for (var element in listPoproduct.value.products!) {
      quantityController.add(TextEditingController(
          text: element.quantity != null
              ? element.quantity.toString()
              : 0.toString()));
      costController.add(TextEditingController(
          text: element.cost != null ? element.cost.toString() : 0.toString()));
    }
    // arrayController.addAll()
    // log.d(listPoproduct.toJson());
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
          .indexWhere((p0) => p0.id == listPoproduct.value.warehouseId);
      listPoproduct.value.warehouseId = listwarehouse.elementAt(data).id;
    } else {
      listPoproduct.value.warehouseId = listwarehouse.elementAt(0).id;
    }
  }

  initMainSuplier() {
    if (isCreated.isFalse) {
      int data = listSuplier
          .indexWhere((p0) => p0.id == listPoproduct.value.suplierId);
      listPoproduct.value.suplierId = listSuplier.elementAt(data).id;
    } else {
      listPoproduct.value.suplier = null;
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

  getAllProduct() async {
    loadingPage.value = true;
    if (allLoadedPage.isTrue) {
      loadingPage.value = false;
      loadingPage.refresh();
      return;
    }
    await fetchDataProduct();
  }

  oneShot() {
    initPaginationFilter();
    fetchDataProduct();
  }

  recoverData() {
    loadingPage.value = false;
    allLoadedPage.value = false;
    productI.value = SeedProductForPo();
    listProduct.clear();
  }

  insertItemToList(int idx) {
    // log.d(listProduct[idx].toJson());
    var product = ProductsPo();
    product.id = null;
    product.name = listProduct[idx].name;
    product.productId = listProduct[idx].id;
    product.quantity = 1;
    product.cost = 0;
    product.unit = listProduct[idx].unit;

    List<ProductsPo>? data;
    if (listPoproduct.value.products == null) {
      data = <ProductsPo>[];
    } else {
      data = listPoproduct.value.products!;
    }
    if (!data.any((e) => e.productId == listProduct[idx].id)) {
      data.add(product);
      listPoproduct.value.products = data;
      quantityController.add(TextEditingController(
          text: product.quantity != null
              ? product.quantity.toString()
              : 0.toString()));
      costController.add(TextEditingController(
          text: product.cost != null ? product.cost.toString() : 0.toString()));
      listPoproduct.refresh();
      quantityController.refresh();
      costController.refresh();
    } else {
      Snackbar.show("Opps!", "Produk tidak boleh sama", mtRed600, mtGrey50);
    }

    // log.d(listPoproduct.toJson());
    openClosePanelControl();
  }

  plus(int index) {
    if (listPoproduct.value.products!.elementAt(index).quantity! > 0) {
      listPoproduct.value.products!.elementAt(index).quantity =
          (listPoproduct.value.products!.elementAt(index).quantity! + 1);
      listPoproduct.refresh();
      quantityController[index].text =
          listPoproduct.value.products!.elementAt(index).quantity.toString();
    }
  }

  minus(int index) {
    if (listPoproduct.value.products!.elementAt(index).quantity! > 1) {
      listPoproduct.value.products!.elementAt(index).quantity =
          (listPoproduct.value.products!.elementAt(index).quantity! - 1);
      listPoproduct.refresh();
      quantityController[index].text =
          listPoproduct.value.products!.elementAt(index).quantity.toString();
    }
  }

  changeQuantity(int index, String value) {
    // log.d(index, value);
    listPoproduct.value.products!.elementAt(index).quantity = int.parse(value);
    listPoproduct.refresh();
    // log.d(listPoproduct.toJson());
  }

  changeCost(int index, String value) {
    // log.d(index, value);
    listPoproduct.value.products!.elementAt(index).cost = int.parse(value);
    listPoproduct.refresh();
    // log.d(listPoproduct.toJson());
  }

  openClosePanelControl() {
    if (pcs.isPanelClosed) {
      pcs.open();
    } else {
      pcs.close();
    }
  }

  getDataLengthProduct() {
    int length = listPoproduct.value.products!.length;
    return length;
  }

  delete(int index) {
    listPoproduct.value.products!.removeAt(index);
    quantityController.removeAt(index);
    costController.removeAt(index);
    listPoproduct.refresh();
    quantityController.refresh();
    costController.refresh();
  }

  createSubmit() {
    // log.d(listPoproduct.toJson());
    // var upsertPoProduct = UpsertPoProduct();
    upsertPoProduct.update((val) {
      val?.orderNo = listPoproduct.value.orderNo;
      val?.note = textFieldNote.value.text;
      val?.suplierId = listPoproduct.value.suplierId;
      val?.warehouseId = listPoproduct.value.warehouseId;
      val?.products = listPoproduct.value.products;
    });
    // log.d(upsertPoProduct.toJson());
    createDataPoProduct();
  }

  updateSubmit() {
    // log.d(listPoproduct.toJson());
    // var upsertPoProduct = UpsertPoProduct();
    upsertPoProduct.update((val) {
      val?.orderNo = listPoproduct.value.orderNo;
      val?.note = listPoproduct.value.note;
      val?.suplierId = listPoproduct.value.suplierId;
      val?.warehouseId = listPoproduct.value.warehouseId;
      val?.products = listPoproduct.value.products;
    });
    // log.d(upsertPoProduct.toJson());
    updateDataPoProduct();
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

  Future<void> fetchDataProduct() async {
    try {
      productI.value = await PoProductService.getProdV2(mainFilter.value);
      mainFilter.value.page = productI.value.pageable!.pageNumber! + 1;
      mainFilter.value.size = productI.value.pageable!.pageSize!;

      List<SeedProductList> newData =
          listProduct.length >= productI.value.pageable!.totalElements!
              ? []
              : productI.value.listProduct!;

      if (newData.isNotEmpty) {
        for (var e in newData) {
          listProduct.add(e);
        }
        listProduct.refresh();
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

  Future<void> updateDataPoProduct() async {
    isSubmit.value = true;
    bool result =
        await PurchaseProductService.updatePoProduct(upsertPoProduct.value);
    isSubmit.value = false;
  }

  Future<void> createDataPoProduct() async {
    isSubmit.value = true;
    bool result =
        await PurchaseProductService.createPoProduct(upsertPoProduct.value);
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
    listPoproduct.value = ListPoProduct();
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
