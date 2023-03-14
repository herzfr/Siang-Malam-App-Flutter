import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
// import 'package:logger/logger.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/models/PaginationFilter.dart';
import 'package:siangmalam/models/purchase-order/po-item-create-request.dart';
import 'package:siangmalam/models/purchase-order/po-item-list.dart';
import 'package:siangmalam/models/suplier/suplier.dart';
import 'package:siangmalam/models/warehouse/warehouse.dart';
import 'package:siangmalam/services/po/po_service.dart';
import 'package:siangmalam/services/product/product_service.dart';
import 'package:siangmalam/services/suplier/suplier_service.dart';
import 'package:siangmalam/services/warehouse/warehouse_service.dart';
import 'package:siangmalam/widgets/snack_bar.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PoItemCreateController extends GetxController {
  // var log = Logger();
  var pc = PanelController().obs;
  final PanelController pcs = PanelController();
  var visible = false.obs;
  final formKey = GlobalKey<FormState>();
  // FIRST ITEM PAGE
  var size = 10.obs;
  var page = 0.obs;
  var search = ''.obs;

  // PAGING
  var pagingControllerDataItem =
      PagingController<int, PoItemListData>(firstPageKey: 0).obs;
  final _paginationFilter = PaginationFilter().obs;

  // PANEL
  final double _initFabHeight = 120.0;
  double fabHeight = 0;
  double panelHeightOpen = 0;
  double panelHeightClosed = 30.0;

  // DATA
  var poItemCreate = PoItemCreateDto().obs;
  var listItem = <PoItemsCreate>[].obs;
  var warehouse = Warehouse().obs;
  var suplier = Suplier().obs;

  var itemdata = PoItemData().obs;

  // DROPDOWN
  var itemWarehouse = <DropdownMenuItem<int>>[].obs;
  var itemSuplier = <DropdownMenuItem<int>>[].obs;

  var isUpdate = false.obs;

  final controllersCost = <TextEditingController>[].obs;
  final controllersQty = <TextEditingController>[].obs;
  final textFieldNoteController = TextEditingController().obs;
  final textFieldController = TextEditingController().obs;

  List<PoItemListData>? get listitems => itemdata.value.listdataitems!;
  int? get _page => _paginationFilter.value.page;
  int? get valueLengthItem => listItem.value.length;

  @override
  void onInit() {
    fetchWarehouseData();
    fetchSuplierData();
    generatePage();
    pagingControllerDataItem.value.addPageRequestListener((pageKey) {
      // log.d('Worked');
      _fetchPage(pageKey);
    });
    super.onInit();
  }

  openClosePanelControl() {
    if (pcs.isPanelClosed) {
      pcs.open();
    } else {
      pcs.close();
    }
  }

  fetchWarehouseData() async {
    warehouse.value = await WarehouseService.getWarehouse();
    for (var item in warehouse.value.listwarehouse!) {
      itemWarehouse.add(DropdownMenuItem(
        child: Text(item.name ?? ''),
        value: item.id,
      ));
    }
  }

  fetchSuplierData() async {
    suplier.value = await SuplierService.getSuplierWithoutParams();
    itemSuplier.add(DropdownMenuItem(
      child: const Text('Bukan dari suplier'),
      value: ListSuplier().id,
    ));
    for (var item in suplier.value.listSuplier!) {
      itemSuplier.add(DropdownMenuItem(
        child: Text(item.name ?? ''),
        value: item.id,
      ));
    }
  }

  generatePage() {
    _changePaginationFilter(page.value, size.value, search.value);
  }

  // ============================================
  // CONTROLER FUNC
  // ============================================
  _changePaginationFilter(int page, int size, String search) {
    _paginationFilter.update((val) {
      val?.page = page;
      val?.size = size;
      val?.search = search;
    });
  }

  searchData() async {
    page.value = 0;
    search.value = textFieldController.value.text;
    generatePage();
    PoItemData item = await ProductService.getItems(_paginationFilter.value);
    itemdata.value = item;
    pagingControllerDataItem.value.refresh();
  }

  clearValueSearch() {
    textFieldController.value.clear();
    textFieldController.value.text = "";
    _paginationFilter.value.search = search.value;
    _paginationFilter.value.page = page.value;
    _paginationFilter.value.size = size.value;
    searchData();
  }

  insertItemToList(index) {
    var id = pagingControllerDataItem.value.itemList?[index].id;
    var ut = pagingControllerDataItem.value.itemList?[index].unit;
    var nm = pagingControllerDataItem.value.itemList?[index].name;
    var create = PoItemsCreate();
    create.itemId = id;
    create.name = nm;
    create.quantity = 0;
    create.cost = 0;
    create.unit = ut;

    if (!listItem.value.any((e) => e.itemId == id)) {
      listItem.value.add(create);
      listItem.refresh();
      openClosePanelControl();
      // log.d(listItem.toJson());
    } else {
      Snackbar.show("Opps!", "Bahan tidak boleh sama", mtRed600, mtGrey50);
    }
  }

  deleteItem(int i) {
    listItem.removeAt(i);
    listItem.refresh();
  }

  plus(int index) {
    controllersQty.value[index].text =
        (main(controllersQty.value[index].text) + 1).toString();
    listItem.value[index].quantity = main(controllersQty.value[index].text);
  }

  minus(int index) {
    if (main(controllersQty.value[index].text) > 0) {
      controllersQty.value[index].text =
          (main(controllersQty.value[index].text) - 1).toString();
      listItem.value[index].quantity = main(controllersQty.value[index].text);
    }
  }

  quantityIntChange(int i) {
    // log.d("work");
    listItem.value[i].quantity = main(controllersQty.value[i].text);
    // log.d(listItem.value[i].quantity);
  }

  qtyChange(int index, String value) {
    controllersQty.value[index].text = value;
    listItem.value[index].quantity = main(controllersQty.value[index].text);
  }

  priceOnSubmit(int index, String value) {
    controllersCost.value[index].text =
        (main(convertStringToNumber(value))).toString();
    listItem.value[index].cost = main(controllersCost.value[index].text);
  }

  priceChange(int i) {
    // log.d("work");
    listItem.value[i].cost =
        (main(convertStringToNumber(controllersCost.value[i].text)));
    // log.d(listItem.value[i].cost);
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

  validatecreate() {
    for (var item in listItem) {
      // log.d(item.toJson());
    }
    if (!listItem.value.any((e) => e.quantity == 0 || e.cost == 0)) {
      return true;
    } else {
      return false;
    }
  }

  createPoItem() {
    // log.d(formKey.currentState!.validate());
    if (formKey.currentState!.validate()) {
      if (validatecreate()) {
        poItemCreate.value.items = listItem.value;
        postCreatePoItem();
      } else {
        Snackbar.show(
            "Opps!", "Isian bahan masih ada yang kosong", mtRed600, mtGrey50);
      }
    }
  }

  postCreatePoItem() async {
    // log.d(poItemCreate.toJson());
    var result = await PoService.createPoItem(poItemCreate.value);
    if (result) {
      Snackbar.show("Success", "Upload Success", mtGrey500, mtGrey50);
      isUpdate.value = true;
      Get.back();
    }
  }

  // ============================================
  // GET DATA
  // ============================================
  Future<void> _fetchPage(int pageKey) async {
    // log.d(pageKey);
    search.value = textFieldController.value.text;
    generatePage();
    try {
      // log.d("=======================");
      PoItemData item = await ProductService.getItems(_paginationFilter.value);
      itemdata.value = item;
      // log.d(itemdata.value.toJson());
      // log.d("=======================");
      _changePaginationFilter(
          item.pageable!.pageNumber!, item.pageable!.pageSize!, search.value);
      final isLastPage = itemdata.value.listdataitems!.length < size.value;
      if (isLastPage) {
        pagingControllerDataItem.value
            .appendLastPage(itemdata.value.listdataitems!);
        // log.d(pagingControllerDataItem.value.itemList);
      } else {
        final nextPageKey = pageKey + itemdata.value.listdataitems!.length;
        pagingControllerDataItem.value
            .appendPage(itemdata.value.listdataitems!, nextPageKey);
        page.value = _page! + 1;
        // log.d(pagingControllerDataItem.value.itemList);
      }
    } catch (error) {
      pagingControllerDataItem.value.error = error;
    }
  }
}
