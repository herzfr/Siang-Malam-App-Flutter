import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
// import 'package:logger/logger.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/models/PaginationFilter.dart';
import 'package:siangmalam/models/purchase-order-product/po_prod_create_dto.dart';
import 'package:siangmalam/models/purchase-order-product/po_prod_data.dart';
import 'package:siangmalam/models/suplier/suplier.dart';
import 'package:siangmalam/models/warehouse/warehouse.dart';
import 'package:siangmalam/services/po/po_prod_service.dart';
import 'package:siangmalam/services/suplier/suplier_service.dart';
import 'package:siangmalam/services/warehouse/warehouse_service.dart';
import 'package:siangmalam/widgets/snack_bar.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PoProductCreateController extends GetxController {
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
      PagingController<int, ProductListData>(firstPageKey: 0).obs;
  final _paginationFilter = PaginationFilter().obs;

  // PANEL
  final double _initFabHeight = 120.0;
  double fabHeight = 0;
  double panelHeightOpen = 0;
  double panelHeightClosed = 30.0;

  // DATA
  var poProductCreate = PoProductCreateDto().obs;
  var listProd = <PoProductCreate>[].obs;
  var warehouse = Warehouse().obs;
  var suplier = Suplier().obs;

  var proddata = ProductData().obs;

  // DROPDOWN
  var itemWarehouse = <DropdownMenuItem<int>>[].obs;
  var itemSuplier = <DropdownMenuItem<int>>[].obs;

  var isUpdate = false.obs;

  final controllersCost = <TextEditingController>[].obs;
  final controllersQty = <TextEditingController>[].obs;
  final textFieldNoteController = TextEditingController().obs;
  final textFieldController = TextEditingController().obs;

  List<ProductListData> get listprod => proddata.value.listproduct!;
  int? get _page => _paginationFilter.value.page;
  int? get valueLengthItem => listProd.value.length;

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
    ProductData item =
        await PoProductService.getProduct(_paginationFilter.value);
    proddata.value = item;
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
    var create = PoProductCreate();
    create.productId = id;
    create.name = nm;
    create.quantity = 0;
    create.cost = 0;
    create.unit = ut;

    if (!listProd.value.any((e) => e.productId == id)) {
      listProd.value.add(create);
      listProd.refresh();
      openClosePanelControl();
      // log.d(listProd.toJson());
    } else {
      Snackbar.show("Opps!", "Bahan tidak boleh sama", mtRed600, mtGrey50);
    }
  }

  deleteItem(int i) {
    listProd.removeAt(i);
    listProd.refresh();
  }

  plus(int index) {
    controllersQty.value[index].text =
        (main(controllersQty.value[index].text) + 1).toString();
    listProd.value[index].quantity = main(controllersQty.value[index].text);
  }

  minus(int index) {
    if (main(controllersQty.value[index].text) > 0) {
      controllersQty.value[index].text =
          (main(controllersQty.value[index].text) - 1).toString();
      listProd.value[index].quantity = main(controllersQty.value[index].text);
    }
  }

  quantityIntChange(int i) {
    // log.d("work");
    listProd.value[i].quantity = main(controllersQty.value[i].text);
    // log.d(listProd.value[i].quantity);
  }

  qtyChange(int index, String value) {
    controllersQty.value[index].text = value;
    listProd.value[index].quantity = main(controllersQty.value[index].text);
  }

  priceChange(int i) {
    // log.d("work");
    listProd.value[i].cost =
        (main(convertStringToNumber(controllersCost.value[i].text)));
    // log.d(listProd.value[i].cost);
  }

  priceOnSubmit(int index, String value) {
    controllersCost.value[index].text =
        (main(convertStringToNumber(value))).toString();
    listProd.value[index].cost = main(controllersCost.value[index].text);
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
    for (var item in listProd) {
      // log.d(item.toJson());
    }
    if (!listProd.value.any((e) => e.quantity == 0 || e.cost == 0)) {
      return true;
    } else {
      return false;
    }
  }

  createPoItem() {
    // log.d(formKey.currentState!.validate());
    if (formKey.currentState!.validate()) {
      if (validatecreate()) {
        poProductCreate.value.products = listProd.value;
        // log.d(poProductCreate.value.toJson());
        postCreatePoItem();
      } else {
        Snackbar.show(
            "Opps!", "Isian bahan masih ada yang kosong", mtRed600, mtGrey50);
      }
    }
  }

  postCreatePoItem() async {
    var result = await PoProductService.createPoProduct(poProductCreate.value);
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
      ProductData prod =
          await PoProductService.getProduct(_paginationFilter.value);
      proddata.value = prod;
      // log.d(proddata.value.toJson());
      // log.d("=======================");
      _changePaginationFilter(
          prod.pageable!.pageNumber!, prod.pageable!.pageSize!, search.value);
      final isLastPage = proddata.value.listproduct!.length < size.value;
      if (isLastPage) {
        pagingControllerDataItem.value
            .appendLastPage(proddata.value.listproduct!);
        // log.d(pagingControllerDataItem.value.itemList);
      } else {
        final nextPageKey = pageKey + proddata.value.listproduct!.length;
        pagingControllerDataItem.value
            .appendPage(proddata.value.listproduct!, nextPageKey);
        page.value = _page! + 1;
        // log.d(pagingControllerDataItem.value.itemList);
      }
    } catch (error) {
      pagingControllerDataItem.value.error = error;
    }
  }
}
