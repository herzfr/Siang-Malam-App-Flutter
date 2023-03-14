import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
// import 'package:logger/logger.dart';
import 'package:siangmalam/commons/routes/routes_name.dart';
import 'package:siangmalam/constans/option_value.dart';
import 'package:siangmalam/models/purchase-order/po-item-filter.dart';
import 'package:siangmalam/models/purchase-order/po-item.dart';
import 'package:siangmalam/services/app_static.dart';
import 'package:siangmalam/services/po/po_service.dart';

class PoItemController extends GetxController {
  // DATA SET FILTER
  var size = 20.obs;
  var page = 0.obs;
  var search = ''.obs;
  var startDate = ''.obs;
  var endDate = ''.obs;
  var status = 'ALL'.obs;
  var option = 'orderno'.obs;
  var sortBy = 'asc'.obs;
  var orderBy = 'createdAt'.obs;
  late int? branchId = AppStatic.userData.branchId ?? 0;
  var subBranchId = 0.obs;

  // MENU FILTER
  // final dropStatus = GlobalKey<FormFieldState>();
  var itemStatus = <DropdownMenuItem<String>>[].obs;
  var itemOpt = <DropdownMenuItem<String>>[].obs;
  var itemsortBy = <DropdownMenuItem<String>>[].obs;
  var itemorderBy = <DropdownMenuItem<String>>[].obs;
  var subbranch = <DropdownMenuItem<int>>[].obs;

  // PANEL
  final double _initFabHeight = 120.0;
  double fabHeight = 0;
  double panelHeightOpen = 0;
  double panelHeightClosed = 102.0;

  // PAGING
  var pagingController = PagingController<int, PoItemList>(firstPageKey: 0).obs;
  final _paginationFilter = PoItemFilter().obs;
  final _paginationFilterWithoutSubBranch = PoItemFilterWithoutSubbranch().obs;

  // DATE
  DateFormat dateFormat = DateFormat("dd-MM-yyyy");
  var displayStartDate = ''.obs;
  var displayEndDate = ''.obs;
  var range = ''.obs;
  var rangeCount = ''.obs;

  // DATA
  var poitem = PoItem().obs;
  var poitemlist = PoItemList().obs;
  // var log = Logger();

  // CONTROLLER
  final textFieldController = TextEditingController().obs;

  // GET
  List<PoItemList>? get listpoitems => poitem.value.listpoitem;
  int? get _page => _paginationFilter.value.page;
  int? get _pagesub => _paginationFilterWithoutSubBranch.value.page;

  @override
  void onInit() {
    // log.d("test");
    fabHeight = _initFabHeight;
    _initSubrbanchChoose();
    _filterDate();
    _generateSelected();
    _whoIts();
    pagingController.value.addPageRequestListener((pageKey) {
      // log.d("test");
      _fetchPage(pageKey);
    });
    super.onInit();
  }

  _initSubrbanchChoose() {
    var dataSub = AppStatic.userData.subBranch;
    subbranch.add(DropdownMenuItem<int>(
        child: Text(AppStatic.userData.branch.toString()), value: 0));
    for (var item in dataSub!) {
      // log.d(item.name);
      subbranch.add(DropdownMenuItem<int>(
          child: Text(item.name.toString()), value: item.id));
    }
  }

  _whoIts() {
    // log.d('subranchid ${subBranchId.value}');
    if (subBranchId.value == 0) {
      // log.d('_changePaginationFilterWithourSubBranch ${subBranchId.value}');
      _changePaginationFilterWithourSubBranch(
          page.value,
          size.value,
          search.value,
          startDate.value,
          endDate.value,
          status.value,
          option.value,
          sortBy.value,
          orderBy.value,
          branchId!);
    } else {
      _changePaginationFilter(
          page.value,
          size.value,
          search.value,
          startDate.value,
          endDate.value,
          status.value,
          option.value,
          sortBy.value,
          orderBy.value,
          branchId!,
          subBranchId.value);
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

  _generateSelected() {
    itemStatus.value = statusPo;
    itemOpt.value = optionPo;
    itemorderBy.value = orderPo;
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

  // ============================================
  // CONTROLER FUNC
  // ============================================
  _changePaginationFilter(
      int page,
      int size,
      String search,
      String stDate,
      String enDate,
      String status,
      String opt,
      String stBy,
      String odBy,
      int bId,
      int sbId) {
    _paginationFilter.update((val) {
      val?.page = page;
      val?.size = size;
      val?.search = search;
      val?.startDate = stDate;
      val?.endDate = enDate;
      val?.status = status;
      val?.option = opt;
      val?.sortBy = stBy;
      val?.orderBy = odBy;
      val?.branchId = bId;
      val?.subBranchId = sbId;
    });
  }

  _changePaginationFilterWithourSubBranch(
      int page,
      int size,
      String search,
      String stDate,
      String enDate,
      String status,
      String opt,
      String stBy,
      String odBy,
      int bId) {
    _paginationFilterWithoutSubBranch.update((val) {
      val?.page = page;
      val?.size = size;
      val?.search = search;
      val?.startDate = stDate;
      val?.endDate = enDate;
      val?.status = status;
      val?.option = opt;
      val?.sortBy = stBy;
      val?.orderBy = odBy;
      val?.branchId = bId;
    });
  }

  searchData() async {
    // log.d("search work");
    page.value = 0;
    search.value = textFieldController.value.text;
    _whoIts();
    if (subBranchId.value == 0) {
      PoItem poItemlist = await PoService.getPoItemWithoutSub(
          _paginationFilterWithoutSubBranch.value);
      poitem.value = poItemlist;
      pagingController.value.refresh();
    } else {
      PoItem poItemlist = await PoService.getPoItem(_paginationFilter.value);
      poitem.value = poItemlist;
      pagingController.value.refresh();
    }
  }

  logData(dynamic data) {
    // log.d("logData work");
    if (data) {
      searchData();
    }
  }

  changeTotalPerPage(int limitValue) {
    switch (limitValue) {
      case 0:
        size.value = 20;
        searchData();
        break;
      case 1:
        Get.toNamed(RouteName.poItemCreateScreen);
        break;
      default:
    }
    // if (limitValue == 0) {
    //   size.value = 20;
    //   searchData();
    // } else {
    //   size.value = limitValue.toInt();
    //   search.value = textFieldController.value.text;
    //   searchData();
    // }
  }

  getDetail(index) {
    // log.d("getDetail work");
  }

  clearValueSearch() {
    // log.d("clearValueSearch work");
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
  Future<void> _fetchPage(int pageKey) async {
    // log.d(pageKey);
    search.value = textFieldController.value.text;
    _whoIts();
    if (subBranchId.value == 0) {
      try {
        // log.d(_paginationFilterWithoutSubBranch.toJson());
        PoItem poItemlist = await PoService.getPoItemWithoutSub(
            _paginationFilterWithoutSubBranch.value);
        poitem.value = poItemlist;
        page.value = poItemlist.pageable!.pageNumber!;
        size.value = poItemlist.pageable!.pageSize!;
        final isLastPage = poitem.value.listpoitem!.length < size.value;
        if (isLastPage) {
          pagingController.value.appendLastPage(poitem.value.listpoitem!);
          // log.d(pagingController.value.itemList!);
        } else {
          final nextPageKey = pageKey + poitem.value.listpoitem!.length;
          pagingController.value
              .appendPage(poitem.value.listpoitem!, nextPageKey);
          page.value = _pagesub! + 1;
          // log.d(pagingController.value.itemList!);
        }
      } catch (error) {
        pagingController.value.error = error;
      }
    } else {
      try {
        // log.d(_paginationFilter.toJson());
        PoItem poItemlist = await PoService.getPoItem(_paginationFilter.value);
        poitem.value = poItemlist;
        page.value = poItemlist.pageable!.pageNumber!;
        size.value = poItemlist.pageable!.pageSize!;
        final isLastPage = poitem.value.listpoitem!.length < size.value;
        if (isLastPage) {
          pagingController.value.appendLastPage(poitem.value.listpoitem!);
        } else {
          final nextPageKey = pageKey + poitem.value.listpoitem!.length;
          pagingController.value
              .appendPage(poitem.value.listpoitem!, nextPageKey);
          page.value = _page! + 1;
        }
      } catch (error) {
        pagingController.value.error = error;
      }
    }
  }

  chooseDetail(int index) {
    poitemlist.value = pagingController.value.itemList![index];
  }

  @override
  void onClose() {
    textFieldController.value.dispose();
    super.onClose();
  }
}
