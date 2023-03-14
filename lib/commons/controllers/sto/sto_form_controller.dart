import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:logger/logger.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/models/PaginationFilter.dart';
import 'package:siangmalam/models/product/stock_item.dart';
import 'package:siangmalam/models/stok-item-out/request/stock_item_out_dto.dart';
import 'package:siangmalam/models/warehouse/warehouse.dart';
import 'package:siangmalam/services/product/product_service.dart';
import 'package:siangmalam/services/stoservice/sto_service.dart';
import 'package:siangmalam/services/warehouse/warehouse_service.dart';
import 'package:siangmalam/widgets/snack_bar.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class StoFormController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final PanelController pcs = PanelController();
  var sc = ScrollController().obs;

  // var log = Logger();
  var pc = PanelController().obs;

  var visible = false.obs;
  var isUpdate = false.obs;

  // INIT FIRST DATA
  var size = 20.obs;
  var page = 0.obs;
  var search = ''.obs;
  late int? warehouseid;

  // GET DATA
  int? get _page => _paginationFilter.value.page;

  // PANEL
  final double _initFabHeight = 120.0;
  double fabHeight = 0;
  double panelHeightOpen = 0;
  double panelHeightClosed = 30.0;

  // PAGING
  final _paginationFilter = PaginationFilter().obs;

  var itemWarehouse = <DropdownMenuItem<int>>[].obs;

  final controllersQty = <TextEditingController>[].obs;
  final textFieldNoteController = TextEditingController().obs;
  final textFieldWarehouseController = TextEditingController().obs;
  final textFieldController = TextEditingController().obs;

  // MODEL
  var it = <It>[].obs;
  var stDto = StockItemOutDto().obs;
  var stockItem = StockItem().obs;
  var listItem = ListStockItem().obs;
  var warehouse = Warehouse().obs;

  var listSto = <ListStockItem>[].obs;

  // var onItemList = <ListStockItem>[].obs;

  // Dropdown
  var subbranch = <DropdownMenuItem<int>>[].obs;

  // TEST PAGE
  var loading = false.obs;
  var allLoaded = false.obs;

  @override
  void onInit() {
    warehouseid = null;
    _getWarehouse();
    _changePaginationFilter(page.value, size.value, search.value);
    // pagingControllerDataItem.value.addPageRequestListener((pageKey) {
    //   _fetchPage(pageKey);
    // });
    // _makeFetchData();
    sc.value.addListener(() {
      // log.d(sc.value.position.pixels);
      // log.d(sc.value.position.maxScrollExtent);
      // log.d(loading);
      if (sc.value.position.pixels >= sc.value.position.maxScrollExtent &&
          loading.isFalse) {
        _makeFetchData();
      }
    });
    super.onInit();
  }

  _makeFetchData() async {
    // log.d(allLoaded);
    generatePage();
    loading.value = true;
    if (allLoaded.isTrue) {
      loading.value = false;
      loading.refresh();
      return;
    }

    // log.d("Warehouse id ${warehouseid.toString()}");
    StockItem item = await ProductService.getStockItemByWarehouseId(
        _paginationFilter.value, warehouseid.toString());
    stockItem.value = item;
    page.value = item.pageable!.pageNumber! + 1;
    size.value = item.pageable!.pageSize!;
    // log.d('value page ${page.value}');
    // log.d('value size ${size.value}');
    // final isLastPage = stockItem.value.listStockItem!.length < size.value;

    // await Future.delayed(const Duration(microseconds: 500));
    // log.d(listSto.value.length);
    // log.d(stockItem.value.pageable!.totalElements!);

    List<ListStockItem> newData =
        listSto.value.length >= stockItem.value.pageable!.totalElements!
            ? []
            : stockItem.value.listStockItem!;
    // log.d(newData);
    if (newData.isNotEmpty) {
      for (var item in newData) {
        listSto.value.add(item);
      }
      listSto.refresh();
    }

    loading.value = false;
    loading.refresh();
    allLoaded.value = newData.isEmpty;
  }

  changeWarehouse() async {
    page.value = 0;
    size.value = 20;
    it.clear();
    it.refresh();
    listSto.clear();
    listSto.refresh();
    allLoaded.value = false;
    _makeFetchData();
  }

  _initWarehouseChoose() {
    subbranch.add(
        const DropdownMenuItem<int>(child: Text("Pilih Gudang"), value: null));
    for (var item in warehouse.value.listwarehouse!) {
      // log.d(item.name);
      subbranch.add(DropdownMenuItem<int>(
          child: Text(item.name.toString()), value: item.id));
    }
  }

  _changePaginationFilter(int page, int size, String search) {
    _paginationFilter.update((val) {
      val?.page = page;
      val?.size = size;
      val?.search = search;
    });
  }

  generatePage() {
    _changePaginationFilter(page.value, size.value, search.value);
  }

  openClosePanelControl() {
    if (pcs.isPanelClosed) {
      pcs.open();
    } else {
      pcs.close();
    }
  }

  insertItemToList(index) {
    var create = It();
    create.stockId = listSto.value[index].id;
    create.name = listSto.value[index].items?.name;
    create.initalStock = listSto.value[index].quantity;
    create.quantity = 0;
    create.itemStock = (listSto.value[index].quantity ?? -0);
    create.unit = listSto.value[index].items?.unit;

    if (!it.value.any((e) => e.stockId == listSto.value[index].id)) {
      it.value.add(create);
      it.refresh();
      openClosePanelControl();
      // log.d(listItem.toJson());
    } else {
      Snackbar.show("Opps!", "Bahan tidak boleh sama", mtRed600, mtGrey50);
    }
  }

  deleteItem(int i) {
    it.removeAt(i);
    controllersQty.removeAt(i);
    it.refresh();
    controllersQty.refresh();
  }

  plus(int index) {
    controllersQty.value[index].text =
        (main(controllersQty.value[index].text) + 1).toString();
    it.value[index].quantity = main(controllersQty.value[index].text);
    it.value[index].itemStock =
        (it.value[index].initalStock! - it.value[index].quantity!);
    it.refresh();
  }

  minus(int index) {
    if (main(controllersQty.value[index].text) > 0) {
      controllersQty.value[index].text =
          (main(controllersQty.value[index].text) - 1).toString();
    }
    it.value[index].quantity = main(controllersQty.value[index].text);
    it.value[index].itemStock =
        (it.value[index].initalStock! - it.value[index].quantity!);
    it.refresh();
  }

  quantityIntChange(int i) {
    it.value[i].quantity = main(controllersQty.value[i].text);
    if (it.value[i].quantity! > it.value[i].initalStock!) {
      it.value[i].quantity = it.value[i].initalStock;
      controllersQty.value[i].text = (it.value[i].quantity).toString();
      it.value[i].itemStock =
          (it.value[i].initalStock! - it.value[i].quantity!);
      it.refresh();
    } else {
      it.value[i].itemStock =
          (it.value[i].initalStock! - it.value[i].quantity!);
      it.refresh();
    }
  }

  qtyChange(int index, String value) {
    controllersQty.value[index].text = value;
    it.value[index].quantity = main(controllersQty.value[index].text);
    it.value[index].itemStock =
        (it.value[index].initalStock! - it.value[index].quantity!);
    it.refresh();
  }

  convertStringToNumber(String value) {
    var str = value.replaceAll(RegExp(r'[^0-9]'), '');
    return str;
  }

  int main(String arguments) {
    try {
      var str = arguments == '' ? (0).toString() : arguments;
      int? a = int.parse(str);
      return a.abs();
    } on FormatException {
      return 0;
    }
  }

  searchData() async {
    if (warehouseid != null) {
      search.value = textFieldController.value.text;
      page.value = 0;
      size.value = 20;
      it.clear();
      it.refresh();
      listSto.clear();
      listSto.refresh();
      allLoaded.value = false;
      _makeFetchData();
    } else {
      Snackbar.show(
          "Opsss", "Mohon pilih gudang terlebih dahulu", mtRed600, mtGrey50);
    }
  }

  clearValueSearch() {
    textFieldController.value.clear();
    textFieldController.value.text = "";
    _paginationFilter.value.search = search.value;
    _paginationFilter.value.page = page.value;
    _paginationFilter.value.size = size.value;
    searchData();
  }

  // ============================================
  // GET DATA
  // ============================================

  Future<void> _getWarehouse() async {
    Warehouse data = await WarehouseService.getWarehouse();
    warehouse.value = data;
    _initWarehouseChoose();
  }

  void submitOut() {
    if (formKey.currentState!.validate()) {
      List<It> stkItemList = [];

      stDto.value.note = textFieldNoteController.value.text;
      stDto.value.warehouseId = warehouseid;
      stDto.value.it = it.value;

      // log.d(stDto.toJson());
      StoService.updateStockOutItems(stDto.value);
    } else {
      Get.snackbar("Perhatian!", "Isian masih ada yang kosong.",
          backgroundColor: mtRed600, colorText: textColor);
    }
  }

  @override
  void onClose() {
    super.onClose();
    sc.value.dispose();
  }
}
