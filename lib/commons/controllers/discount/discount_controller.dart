import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
// import 'package:logger/logger.dart';
import 'package:siangmalam/constans/enums.dart';
import 'package:siangmalam/models/branch/general_branch.dart';
import 'package:siangmalam/models/discount/discount.dart';
import 'package:siangmalam/models/discount/discounts.dart';
import 'package:siangmalam/models/discount/request/request_discount.dart';
import 'package:siangmalam/models/subbranch/general_sub_branch.dart';
import 'package:siangmalam/services/app_static.dart';
import 'package:siangmalam/services/branch/branch_service.dart';
import 'package:siangmalam/services/discount/discount_service.dart';

class DiscountController extends GetxController {
  // var log = Logger();
  // LEVEL
  var whoIs = AppStatic.userData.role.obs;
  // SEARCH
  var size = 20.obs;
  var page = 0.obs;
  var search = ''.obs;
  var sortBy = 'desc'.obs;
  late int? branchId;
  late int? subBranchId;

  // var isSubranchEnabled = false.obs;

  // CONTROLLER
  final textFieldController = TextEditingController().obs;

  // PAGING
  var pagingController =
      PagingController<int, ListDiscount>(firstPageKey: 0).obs;
  final pageFilterALl = GetDiscountsAll().obs;
  final pageFilterForManager = GetDiscountByManager().obs;
  final pageFilterForAdmin = GetDiscountByAdmin().obs;
  final pageFilterJustBranch = GetDiscountJustBranch().obs;

  // PAGE
  int? get _page0 => pageFilterALl.value.page;
  int? get _page1 => pageFilterForManager.value.page;
  int? get _page2 => pageFilterForAdmin.value.page;

  // DATA
  var disc = Discounts().obs;
  var branch = GeneralBranch().obs;
  var subbranch = GeneralSubBranch().obs;
  var discSelected = ListDiscount().obs;

  // DROPDOWN CONTROL
  var branchDropDown = <DropdownMenuItem<int>>[].obs;
  var subbranchDropDown = <DropdownMenuItem<int>>[].obs;
  // DROPDOWN CONTROL FOR MANAGER
  var subbranchDropDownManager = <DropdownMenuItem<int>>[].obs;

  // PANEL
  final double _initFabHeight = 120.0;
  double fabHeight = 0;
  double panelHeightOpen = 0;
  double panelHeightClosed = 102.0;

  // Radio Button
  final selectedItemSortBy = ValueNotifier<Sortir>(Sortir.terbaru).obs;

  @override
  void onInit() {
    if (whoIs.value == 'ADMIN') {
      branchId = null;
      subBranchId = null;
    } else {
      branchId = AppStatic.userData.branchId;
      subBranchId = null;
    }

    init();
    pagingController.value.addPageRequestListener((pageKey) async {
      if (whoIs.value == 'ADMIN') {
        _changePaginationFilterAll(
            page.value, size.value, search.value, sortBy.value);
        _fetchPageAll(pageKey);
      } else if (whoIs.value == 'MANAGER') {
        whoIsPaging();
        _fetchPageManager(pageKey);
      }
    });
    super.onInit();
  }

  init() {
    whoIs.value == 'MANAGER' ? initSubrbanchChooseFromManager() : null;
    whoIs.value == 'ADMIN' ? fetchDataBranch() : null;
  }

  _initDropdownBranch() {
    branchDropDown.add(const DropdownMenuItem<int>(
        child: Text("Semua Induk Cabang"), value: null));
    for (var item in branch.value.listbranch!) {
      // log.d(item.name.toString());
      branchDropDown.add(DropdownMenuItem<int>(
          child: Text(item.name.toString()), value: item.id));
    }
    branchDropDown.refresh();
  }

  _initDropdownSubBranch() {
    subbranchDropDown.clear();
    var dropdown = <DropdownMenuItem<int>>[].obs;
    subBranchId = null;
    dropdown.add(const DropdownMenuItem<int>(
        child: Text("Pilih Anak Cabang"), value: null));
    for (var item in subbranch.value.listsubbranch!) {
      dropdown.add(DropdownMenuItem<int>(
          child: Text(item.name.toString()), value: item.id));
    }
    // subbranchDropDown.clear();
    subbranchDropDown = dropdown;
    // subbranchDropDown.refresh();
    update();
  }

  initSubrbanchChooseFromManager() {
    branchId = null;
    var dataSub = AppStatic.userData.subBranch;
    subbranchDropDownManager.add(DropdownMenuItem<int>(
        child: Text(AppStatic.userData.branch.toString()), value: 0));
    for (var item in dataSub!) {
      // log.d(item.name);
      subbranchDropDownManager.add(DropdownMenuItem<int>(
          child: Text(item.name.toString()), value: item.id));
    }
  }

  clearFilterAll() {
    branchId = null;
    subBranchId = null;
    subbranchDropDown.clear();
    searchDataGeneral();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  // ====================================================
  //  PRIVATE METHOD
  // ====================================================

  whoIsPaging() {
    if (whoIs.value == 'ADMIN') {
      // log.d("ADMIN");
      _changePaginationFilterForAdmin(page.value, size.value, search.value,
          sortBy.value, branchId, subBranchId!);
    } else if (whoIs.value == 'MANAGER') {
      // ignore: unrelated_type_equality_checks
      if (subBranchId != 0) {
        // log.d("isSubranchEnabled.isTrue");
        _changePaginationFilterManager(
            page.value, size.value, search.value, sortBy.value, subBranchId);
      } else {
        // log.d("isSubranchEnabled.isFalse");
        _changePaginationFilterManager(
            page.value, size.value, search.value, sortBy.value, null);
      }
    } else if (whoIs.value == 'KASIR') {
      // log.d('KASIR');
    } else if (whoIs.value == 'USER') {
      // log.d('USER');
    }
  }

  // ====================================================
  //  END PRIVATE METHOD
  // ====================================================

  // ====================================================
  //  VIEW METHOD
  // ====================================================

  changeTotalPerPage(int limitValue) {
    switch (limitValue) {
      case 0:
        size.value = 20;
        // searchData();
        break;
      case 1:
        // Get.toNamed(RouteName.poProductCreateScreen);
        break;
      default:
    }
  }

  getDataSubBranch(int value) {
    fetchDataSubBranchByBranchId(value);
  }

  refreshAscDesc() {
    whoIs.value == 'MANAGER' ? searchDataManager() : null;
    whoIs.value == 'ADMIN' ? searchDataAdmin() : null;
  }

  searchDataGeneral() {
    whoIs.value == 'MANAGER' ? searchDataManager() : null;
    whoIs.value == 'ADMIN' ? searchDataAdmin() : null;
  }

  searchDataAdmin() async {
    if (branchId == null) {
      // log.d('Branch nya 0');
      page.value = 0;
      search.value = textFieldController.value.text;
      _changePaginationFilterAll(
          page.value, size.value, search.value, sortBy.value);
      // log.d(pageFilterALl.value.toJson());
      pagingController.value.itemList!.clear();
      Discounts discounts =
          await DiscountService.getAllDiscount(pageFilterALl.value);
      disc.value = discounts;
      page.value = discounts.pageable!.pageNumber!;
      size.value = discounts.pageable!.pageSize!;
      final isLastPage = disc.value.listdiscount!.length < size.value;
      if (isLastPage) {
        pagingController.value.appendLastPage(disc.value.listdiscount!);
        // pagingController.value.refresh();
      } else {
        final nextPageKey = page.value + disc.value.listdiscount!.length;
        pagingController.value
            .appendPage(disc.value.listdiscount!, nextPageKey);
        page.value = _page2! + 1;
        // pagingController.value.refresh();
      }
    } else {
      // log.d('Branch nya tidak 0');
      page.value = 0;
      search.value = textFieldController.value.text;
      whoIsPaging();
      // log.d(pageFilterForAdmin.value.toJson());
      pagingController.value.itemList!.clear();
      Discounts discounts =
          await DiscountService.getAllDiscountByAdmin(pageFilterForAdmin.value);
      disc.value = discounts;
      page.value = discounts.pageable!.pageNumber!;
      size.value = discounts.pageable!.pageSize!;
      final isLastPage = disc.value.listdiscount!.length < size.value;
      if (isLastPage) {
        pagingController.value.appendLastPage(disc.value.listdiscount!);
        // pagingController.value.refresh();
      } else {
        final nextPageKey = page.value + disc.value.listdiscount!.length;
        pagingController.value
            .appendPage(disc.value.listdiscount!, nextPageKey);
        page.value = _page2! + 1;
        // pagingController.value.refresh();
      }
    }
  }

  searchDataManager() async {
    // log.d('data branch');
    // if (subBranchId.value == 0) {
    // }
    page.value = 0;
    search.value = textFieldController.value.text;
    whoIsPaging();
    // log.d(pageFilterForManager.value.toJson());
    pagingController.value.itemList!.clear();
    Discounts discounts = await DiscountService.getAllDiscountByManager(
        pageFilterForManager.value);
    disc.value = discounts;
    page.value = discounts.pageable!.pageNumber!;
    size.value = discounts.pageable!.pageSize!;
    final isLastPage = disc.value.listdiscount!.length < size.value;
    if (isLastPage) {
      pagingController.value.appendLastPage(disc.value.listdiscount!);
      // pagingController.value.refresh();
    } else {
      final nextPageKey = page.value + disc.value.listdiscount!.length;
      pagingController.value.appendPage(disc.value.listdiscount!, nextPageKey);
      page.value = _page2! + 1;
      // pagingController.value.refresh();
    }
  }

  clearValueSearch() {
    textFieldController.value.clear();
    textFieldController.value.text = "";
    whoIsPaging();
    searchDataGeneral();
  }

  // ====================================================
  // FILTERING
  // ====================================================
  void _changePaginationFilterAll(
      int page, int size, String search, String sortBy) {
    pageFilterALl.update((val) {
      val?.page = page;
      val?.size = size;
      val?.search = search;
      val?.sortBy = sortBy;
    });
  }

  void _changePaginationFilterJustBranch(
      int page, int size, String search, String sortBy, int branchId) {
    pageFilterJustBranch.update((val) {
      val?.page = page;
      val?.size = size;
      val?.search = search;
      val?.sortBy = sortBy;
      val?.branchId = branchId;
    });
  }

  void _changePaginationFilterManager(
      int page, int size, String search, String sortBy, int? subbranch) {
    pageFilterForManager.update((val) {
      val?.page = page;
      val?.size = size;
      val?.search = search;
      val?.sortBy = sortBy;
      val?.subBranchId = subbranch;
    });
  }

  void _changePaginationFilterForAdmin(int page, int size, String search,
      String sortBy, int? branchid, int subbranch) {
    pageFilterForAdmin.update((val) {
      val?.page = page;
      val?.size = size;
      val?.search = search;
      val?.sortBy = sortBy;
      val?.branchId = branchid;
      val?.subBranchId = subbranch;
    });
  }

  // ====================================================
  // END FILTERING
  // ====================================================

  // ====================================================
  //  API DATA
  // ====================================================

  _fetchPageAll(int pageKey) async {
    Discounts discounts =
        await DiscountService.getAllDiscount(pageFilterALl.value);
    disc.value = discounts;
    page.value = discounts.pageable!.pageNumber!;
    size.value = discounts.pageable!.pageSize!;
    final isLastPage = disc.value.listdiscount!.length < size.value;
    if (isLastPage) {
      pagingController.value.appendLastPage(disc.value.listdiscount!);
      // log.d(pagingController.value.itemList!);
    } else {
      final nextPageKey = pageKey + disc.value.listdiscount!.length;
      pagingController.value.appendPage(disc.value.listdiscount!, nextPageKey);
      page.value = _page2! + 1;
      // log.d(pagingController.value.itemList!);
    }
  }

  _fetchPageAdmin(int pageKey) async {
    Discounts discounts =
        await DiscountService.getAllDiscountByAdmin(pageFilterForAdmin.value);
    disc.value = discounts;
    page.value = discounts.pageable!.pageNumber!;
    size.value = discounts.pageable!.pageSize!;
    final isLastPage = disc.value.listdiscount!.length < size.value;
    if (isLastPage) {
      pagingController.value.appendLastPage(disc.value.listdiscount!);
      // log.d(pagingController.value.itemList!);
    } else {
      final nextPageKey = pageKey + disc.value.listdiscount!.length;
      pagingController.value.appendPage(disc.value.listdiscount!, nextPageKey);
      page.value = _page2! + 1;
      // log.d(pagingController.value.itemList!);
    }
  }

  _fetchPageManager(int pageKey) async {
    Discounts discounts = await DiscountService.getAllDiscountByManager(
        pageFilterForManager.value);
    disc.value = discounts;
    page.value = discounts.pageable!.pageNumber!;
    size.value = discounts.pageable!.pageSize!;
    final isLastPage = disc.value.listdiscount!.length < size.value;
    if (isLastPage) {
      pagingController.value.appendLastPage(disc.value.listdiscount!);
      // log.d(pagingController.value.itemList!);
    } else {
      final nextPageKey = pageKey + disc.value.listdiscount!.length;
      pagingController.value.appendPage(disc.value.listdiscount!, nextPageKey);
      page.value = _page2! + 1;
      // log.d(pagingController.value.itemList!);
    }
  }

  fetchDataBranch() async {
    var data = await BranchService.getAllDataBranch();
    branch.value = data;
    _initDropdownBranch();
  }

  fetchDataSubBranchByBranchId(int id) async {
    var data = await BranchService.getSubBranchDataByBranchId(id);
    subbranch.value = data;
    _initDropdownSubBranch();
  }

  setNewDicount() {
    discSelected.value = ListDiscount();
    // log.d(discSelected.toJson());
  }

  submitDelete(int id) {
    DiscountService.deleteDiscount(id.toString());
  }
}
