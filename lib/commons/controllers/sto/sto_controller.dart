import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
// import 'package:logger/logger.dart';
import 'package:siangmalam/commons/routes/routes_name.dart';
import 'package:siangmalam/models/product/stock_item.dart';
import 'package:siangmalam/models/stok-item-out/request/stock_item_out_filter.dart';
import 'package:siangmalam/models/stok-item-out/response/stock_item_out.dart';
import 'package:siangmalam/models/sub_branch.dart';
import 'package:siangmalam/services/app_static.dart';
import 'package:siangmalam/services/stoservice/sto_service.dart';

import '../../../constans/option_value.dart';

class StoController extends GetxController {
  // var log = Logger();

  // DATA SET FILTER
  var size = 20.obs;
  var page = 0.obs;
  var search = ''.obs;
  var startDate = ''.obs;
  var endDate = ''.obs;
  var sortBy = 'desc'.obs;
  late int? branchId = AppStatic.userData.branchId ?? 0;
  int? subBranchId;

  // DROP DOWN
  var itemsortBy = <DropdownMenuItem<String>>[].obs;
  var subbranch = <DropdownMenuItem<int>>[].obs;

  // PAGING
  var pagingController =
      PagingController<int, StockItemOutList>(firstPageKey: 0).obs;
  final paginationFilter = StockItemOutFilter().obs;

  // PANEL
  final double _initFabHeight = 120.0;
  double fabHeight = 0;
  double panelHeightOpen = 0;
  double panelHeightClosed = 102.0;

  // DATE
  DateFormat dateFormat = DateFormat("dd-MM-yyyy");
  var displayStartDate = ''.obs;
  var displayEndDate = ''.obs;
  var range = ''.obs;
  var rangeCount = ''.obs;

  // DATA
  var stoitem = StockItemOut().obs;
  var stoitemlist = StockItemOutList().obs;

  var stockItem = StockItem().obs;
  var listItem = ListStockItem().obs;

  final textFieldController = TextEditingController().obs;

  // GET
  List<StockItemOutList>? get liststoitems => stoitem.value.listSto;
  int? get _page => paginationFilter.value.page;

  @override
  void onInit() {
    fabHeight = _initFabHeight;
    _initSubrbanchChoose();
    _filterDate();
    generateSelected();
    pageinationFilter(size.value, page.value, search.value, startDate.value,
        endDate.value, branchId!, subBranchId, sortBy.value);
    pagingController.value.addPageRequestListener((pageKey) {
      // log.d("test");
      _fetchPage(pageKey);
    });
    super.onInit();
  }

  _initSubrbanchChoose() {
    List<SubBranch>? dataSub = AppStatic.userData.subBranch;
    // log.d('data sub');
    // log.d(dataSub?.length);
    subbranch.add(DropdownMenuItem<int>(
        child: Text(AppStatic.userData.branch.toString()), value: null));
    for (var item in dataSub!) {
      // log.d(item.name);
      subbranch.add(DropdownMenuItem<int>(
          child: Text(item.name.toString()), value: item.id));
    }
  }

  _filterDate() {
    DateTime now = DateTime.now();
    // DateTime pass = DateTime(now.year, now.month - 1, now.day);
    DateTime pastMonth = now.subtract(const Duration(days: 30));
    startDate.value = _convertStringDate(pastMonth);
    endDate.value = _convertStringDate(now);
    displayEndDate.value = dateFormat.format(DateTime.now());
    displayStartDate.value = dateFormat.format(
      DateTime.now().subtract(
        const Duration(days: 30),
      ),
    );
  }

  _convertStringDate(DateTime date) {
    DateTime d = DateTime(date.year, date.month, date.day);
    String month = d.month.toString();
    String day = d.day.toString();
    String year = d.year.toString();

    if (month.length < 2) month = '0' + month;
    if (day.length < 2) day = '0' + day;
    return [year, month, day].join('-');
  }

  generateSelected() {
    itemsortBy.value = sortPo;
  }

  // ============================================
  // CONTROLER DATE
  // ============================================
  setDate(DateTime start, DateTime end) {
    displayEndDate.value = dateFormat.format(end);
    displayStartDate.value = dateFormat.format(start);
    startDate.value = _convertStringDate(start);
    endDate.value = _convertStringDate(end);
    searchData();
  }

  pageinationFilter(int size, int page, String search, String stDate,
      String edDate, int branchId, int? subbranchid, String sortBy) {
    paginationFilter.update((val) {
      val?.size = size;
      val?.page = page;
      val?.search = search;
      val?.startDate = stDate;
      val?.endDate = edDate;
      val?.branchId = branchId;
      val?.subBranchId = subbranchid;
      val?.sortBy = sortBy;
    });
  }

  searchData() async {
    // log.d("search work");
    page.value = 0;
    search.value = textFieldController.value.text;
    pageinationFilter(size.value, page.value, search.value, startDate.value,
        endDate.value, branchId!, subBranchId, sortBy.value);
    StockItemOut stoitems =
        await StoService.getAllStockOut(paginationFilter.value);
    stoitem.value = stoitems;
    pagingController.value.refresh();
  }

  popupChoose(int limitValue) {
    switch (limitValue) {
      case 0:
        size.value = 20;
        searchData();
        break;
      case 1:
        Get.toNamed(RouteName.stoFormScreen)?.then((value) => {
              if (value != null) {value ? searchData() : null}
            });
        break;
      default:
    }
  }

  clearValueSearch() {
    textFieldController.value.clear();
    textFieldController.value.text = "";
    paginationFilter.value.search = search.value;
    paginationFilter.value.page = page.value;
    paginationFilter.value.size = size.value;
    searchData();
  }

  // ============================================
  // GET DATA
  // ============================================
  Future<void> _fetchPage(int pageKey) async {
    // log.d(pageKey);
    search.value = textFieldController.value.text;
    try {
      // log.d(paginationFilter.toJson());
      StockItemOut stoitems =
          await StoService.getAllStockOut(paginationFilter.value);
      stoitem.value = stoitems;
      page.value = stoitems.pageable!.pageNumber!;
      size.value = stoitems.pageable!.pageSize!;
      final isLastPage = stoitem.value.listSto!.length < size.value;
      if (isLastPage) {
        pagingController.value.appendLastPage(stoitem.value.listSto!);
        // log.d(pagingController.value.itemList!);
      } else {
        final nextPageKey = pageKey + stoitem.value.listSto!.length;
        pagingController.value.appendPage(stoitem.value.listSto!, nextPageKey);
        page.value = _page! + 1;
        // log.d(pagingController.value.itemList!);
      }
    } catch (error) {
      pagingController.value.error = error;
    }
  }
}
