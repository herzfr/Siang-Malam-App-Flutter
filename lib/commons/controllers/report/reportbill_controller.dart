import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
// import 'package:logger/logger.dart';
import 'package:siangmalam/commons/functions/orientations.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/option_value.dart';
import 'package:siangmalam/models/cashier/sales.dart';
import 'package:siangmalam/models/cashier/shift.dart';
import 'package:siangmalam/models/sub_branch.dart';
import 'package:siangmalam/services/app_static.dart';
import 'package:siangmalam/services/cashier/cashier_service.dart';
import 'package:siangmalam/services/cashier/sales_service.dart';
import 'package:siangmalam/widgets/snack_bar.dart';

class ReportBillController extends GetxController {
  // var log = Logger();
  late Timer timer;
  var counter = "".obs;
  late int? branchId = AppStatic.userData.branchId ?? 0;
  int? subBranchId;

  var scrollControllerShift = ScrollController().obs;
  var scrollControllerSales = ScrollController().obs;

  var shift = ShifList().obs;
  var shiftList = <ShiftObj>[].obs;
  var selectedShift = ShiftObj().obs;
  var getShiftFilter = GetShift().obs;

  var days = 1.obs;
  var loadingPageShift = false.obs;
  var allLoadedPageShift = false.obs;

  var size = 20.obs;
  var page = 0.obs;
  var search = ''.obs;
  var startDate = DateTime.now()
      .subtract(const Duration(days: 1, hours: 0, minutes: 00, seconds: 00))
      .millisecondsSinceEpoch
      .obs;
  var endDate = DateTime.now().millisecondsSinceEpoch.obs;
  var status = 'ALL'.obs;

  // ==================================================
  // SHIFT
  // ==================================================

  var sizeSales = 20.obs;
  var pageSales = 0.obs;
  var searchSales = ''.obs;
  var startDateSales = DateTime.now()
      .subtract(const Duration(days: 1, hours: 0, minutes: 00, seconds: 00))
      .millisecondsSinceEpoch
      .obs;
  var endDateSales = DateTime.now().millisecondsSinceEpoch.obs;
  var statusSales = 'ALL'.obs;
  var optionSales = 'name'.obs;

  var daysSales = 1.obs;
  var loadingPageSales = false.obs;
  var allLoadedPageSales = false.obs;

  var sales = SalesList().obs;
  var salesList = <Sales>[].obs;
  var filterSales = FilterGetListSales().obs;

  var onSales = Sales().obs;
  var onItem = <SalesItems>[].obs;

  // DROP DOWN
  var itemsortBy = <DropdownMenuItem<String>>[].obs;
  var subbranch = <DropdownMenuItem<int>>[].obs;

  var textFieldController = TextEditingController().obs;
  var dbStartDate = typeFindStartDate;
  var dbOptionShift = typeOptionShift;

  @override
  void onInit() {
    Orientations.landscapeOrientation();
    super.onInit();
    initBranchDropdown();
    timer = Timer.periodic(
        const Duration(seconds: 1), (Timer t) => {updateEndDate()});

    scrollControllerShift.value.addListener(() {
      // // log.d(scrollController.value.position.maxScrollExtent);
      if (scrollControllerShift.value.position.pixels >=
              scrollControllerShift.value.position.maxScrollExtent &&
          loadingPageShift.isFalse) {
        // log.d("work");
        getShiftData();
      }
    });

    scrollControllerSales.value.addListener(() {
      // // log.d(scrollController.value.position.maxScrollExtent);
      if (scrollControllerSales.value.position.pixels >=
              scrollControllerSales.value.position.maxScrollExtent &&
          loadingPageSales.isFalse) {
        // log.d("work");
        getSalesData();
      }
    });
    getShiftData();
  }

  updateEndDate() {
    endDate.value = DateTime.now().millisecondsSinceEpoch;
  }

  updateStartDate(int day) {
    days.value = day;
    startDate.value = DateTime.now()
        .subtract(
            Duration(days: days.value, hours: 0, minutes: 00, seconds: 00))
        .millisecondsSinceEpoch;
  }

  initBranchDropdown() {
    List<SubBranch>? dataSub = AppStatic.userData.subBranch;
    // log.d(dataSub);
    subbranch.add(DropdownMenuItem<int>(
        child: Text(AppStatic.userData.branch.toString()), value: null));
    for (var item in dataSub!) {
      // log.d(item.name);
      subbranch.add(DropdownMenuItem<int>(
          child: Text(item.name.toString()), value: item.id));
    }
  }

  getShiftData() async {
    await updateFilterShift();
    // log.d(getShiftFilter.toJson());
    loadingPageShift.value = true;
    if (allLoadedPageShift.isTrue) {
      loadingPageShift.value = false;
      loadingPageShift.refresh();
      return;
    }
    await fetchDataShift();
  }

  getFirstSalesData() {
    if (selectedShift.value.endTime!.isNotEmpty) {
      pageSales.value = 0;
      sizeSales.value = 0;
      allLoadedPageSales.value = false;

      onSales.value = Sales();
      onSales.refresh();
      salesList.clear();
      getSalesData();
    }
  }

  getSalesData() async {
    updateFilterSales();
    // log.d(filterSales.toJson());
    loadingPageSales.value = true;
    // log.d(allLoadedPageSales.value);
    if (allLoadedPageSales.isTrue) {
      loadingPageSales.value = false;
      loadingPageSales.refresh();
      return;
    }
    await fetchSalesList();
    // log.d(salesList.toJson());
  }

  updateFilterShift() {
    getShiftFilter.update((val) {
      val?.branchId = branchId;
      val?.subBranchId = subBranchId;
      val?.page = page.value;
      val?.size = size.value;
      val?.status = status.value;
      val?.startDate = startDate.value;
      val?.endDate = endDate.value;
    });
  }

  updateFilterSales() {
    filterSales.update((val) {
      val?.branchId = selectedShift.value.branchid;
      val?.subBranchId = selectedShift.value.subBranchId;
      val?.page = pageSales.value;
      val?.size = sizeSales.value;
      val?.search = searchSales.value;
      val?.status = statusSales.value;
      val?.option = optionSales.value;
      val?.startDate = converDateStringToMillis(selectedShift.value.startTime!);
      val?.endDate = converDateStringToMillis(selectedShift.value.endTime!);
    });
  }

  converDateStringToMillis(String date) {
    if (date.length > 0) {
      DateTime dt = DateFormat('dd/MM/yyyy HH.mm.ss').parse(date);
      return dt.millisecondsSinceEpoch;
    }
  }

  convertPrice(int? price) {
    if (price != null) {
      final currencyFormatter = NumberFormat('#,##0', 'ID');
      return 'Rp ' + currencyFormatter.format(price);
    } else {
      return 'Rp -';
    }
  }

  converDateMillisToString(int millis) {
    var dt = DateTime.fromMillisecondsSinceEpoch(millis);
    return DateFormat('dd MMMM yyyy, HH:mm').format(dt).toString();
  }

  findItShift() {
    page.value = 0;
    size.value = 10;
    allLoadedPageShift.value = false;

    onSales.value = Sales();
    onSales.refresh();
    salesList.clear();

    // log.d(onSales.toJson());
    getShiftList();
  }

  getShiftList() async {
    updateFilterShift();
    // log.d(getShiftFilter.toJson());
    loadingPageShift.value = true;
    if (allLoadedPageShift.isTrue) {
      loadingPageShift.value = false;
      loadingPageShift.refresh();
      return;
    }
    await fetchDataShift();
    // log.d(shiftList.toJson());
    loadingPageShift.value = false;
  }

  seePaymentMethod(payMethod) {
    switch (payMethod) {
      case "CASH":
        return "Tunai";
      case "CUSTOM":
        return "Debit/Kredit/E-Wallet";
      case "CUST_DEBT":
        return "Invoice";
      case "EMPL_DEBT":
        return "Karyawan";
      default:
        return "";
    }
  }

  Future<void> fetchDataShift() async {
    loadingPageShift.value = true;
    try {
      ShifList shift = await CashierService.getShift(getShiftFilter.value);
      shiftList.value = shift.allShiftList!;

      page.value = shift.pageable!.pageNumber! + 1;
      size.value = shift.pageable!.pageSize!;

      List<ShiftObj> newData =
          shiftList.length >= shift.pageable!.totalElements!
              ? []
              : shift.allShiftList!;
      if (newData.isNotEmpty) {
        for (var item in newData) {
          shiftList.add(item);
        }
        shiftList.refresh();
      }
      loadingPageShift.value = false;
      page.refresh();
      allLoadedPageShift.value = newData.isEmpty;
      shiftList.refresh();
    } catch (error) {
      Snackbar.show("Opps!", error.toString(), mtRed600, mtGrey50);
    }
  }

  Future<void> fetchSalesList() async {
    // log.d(reqOrder.toJson());
    loadingPageSales.value = true;
    try {
      SalesList slsList = await SalesService.getAllSalesList(filterSales.value);
      salesList.value = slsList.listSalesAll!;

      pageSales.value = slsList.pageable!.pageNumber! + 1;
      sizeSales.value = slsList.pageable!.pageSize!;

      List<Sales> newData = salesList.length >= slsList.pageable!.totalElements!
          ? []
          : slsList.listSalesAll!;
      if (newData.isNotEmpty) {
        for (var item in newData) {
          salesList.add(item);
        }
        salesList.refresh();
      }
      loadingPageSales.value = false;
      page.refresh();
      allLoadedPageSales.value = newData.isEmpty;
      salesList.refresh();
    } catch (error) {
      Snackbar.show("Opps!", error.toString(), mtRed600, mtGrey50);
    }
  }

  @override
  void onClose() {
    Orientations.defaultOrientation();
    super.onClose();
  }
}
