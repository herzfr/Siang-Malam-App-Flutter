import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
// import 'package:logger/logger.dart';
import 'package:siangmalam/commons/controllers/cashier/cashier_controller.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/option_value.dart';
import 'package:siangmalam/models/cashier/sales.dart';
// import 'package:siangmalam/services/app_static.dart';
import 'package:siangmalam/services/cashier/sales_service.dart';
import 'package:siangmalam/services/printer_service.dart';
import 'package:siangmalam/widgets/snack_bar.dart';

class SalesController extends GetxController {
  // var log = Logger();
  CashierController cashierController = Get.find();
  int? branchId;
  int? subBranchId;

  late Timer timer;
  var counter = "".obs;

  var scrollController = ScrollController().obs;

  var sales = SalesList().obs;
  var salesList = <Sales>[].obs;
  var filterSales = FilterGetListSales().obs;

  var onSales = Sales().obs;
  var onItem = <SalesItems>[].obs;

  var days = 1.obs;
  var loadingPageSales = false.obs;
  var allLoadedPageSales = false.obs;

  var size = 10.obs;
  var page = 0.obs;
  var search = "".obs;
  var status = "ALL".obs;
  var option = "name".obs;
  var startDate = DateTime.now()
      .subtract(const Duration(days: 1, hours: 0, minutes: 00, seconds: 00))
      .millisecondsSinceEpoch
      .obs;
  var endDate = DateTime.now().millisecondsSinceEpoch.obs;

  // DROPDOWN
  var dDStatus = typeFindStatusSales;
  var dDOption = typeFindOptionSales;
  var dbStartDate = typeFindStartDate;
  var textSearchController = TextEditingController().obs;

  @override
  void onInit() async {
    super.onInit();
    // log.d("SalesController");
    branchId = cashierController.branchId;
    subBranchId = cashierController.subBranchId;

    timer = Timer.periodic(
        const Duration(seconds: 1), (Timer t) => {updateEndDate()});

    await getSalesList();

    scrollController.value.addListener(() {
      // // log.d(scrollController.value.position.maxScrollExtent);
      if (scrollController.value.position.pixels >=
              scrollController.value.position.maxScrollExtent &&
          loadingPageSales.isFalse) {
        // log.d("work");
        getSalesList();
      }
    });
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

  updateFilterSales() {
    filterSales.update((val) {
      val?.branchId = branchId;
      val?.subBranchId = subBranchId;
      val?.page = page.value;
      val?.size = size.value;
      val?.search = search.value;
      val?.status = status.value;
      val?.option = option.value;
      val?.startDate = startDate.value;
      val?.endDate = endDate.value;
    });
  }

  getSalesList() async {
    updateFilterSales();
    // log.d(filterSales.toJson());
    loadingPageSales.value = true;
    if (allLoadedPageSales.isTrue) {
      loadingPageSales.value = false;
      loadingPageSales.refresh();
      return;
    }
    await fetchSalesList();
    // log.d(salesList.toJson());
  }

  refreshDataAll() {
    sales.value = SalesList();
    salesList.clear();
    allLoadedPageSales.value = false;
    onSales.value = Sales();
    // textSearchController.value.clear();
    // textSearchController.refresh();
    size.value = 10;
    page.value = 0;
  }

  convertPrice(int? price) {
    if (price != null) {
      final currencyFormatter = NumberFormat('#,##0', 'ID');
      return 'Rp ' + currencyFormatter.format(price);
    } else {
      return 'Rp -';
    }
  }

  seeDetailSales(int index) {
    onSales.value = Sales();
    onSales.value = salesList.elementAt(index);
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

  converDateMillisToString(int millis) {
    var dt = DateTime.fromMillisecondsSinceEpoch(millis);
    return DateFormat('dd MMMM yyyy, HH:mm').format(dt).toString();
  }

  printOnSales() {
    PrinterService print = PrinterService();
    print.printFromSales(onSales.value);
  }

  Future<void> fetchSalesList() async {
    // log.d(reqOrder.toJson());
    loadingPageSales.value = true;
    try {
      SalesList slsList = await SalesService.getAllSalesList(filterSales.value);
      salesList.value = slsList.listSalesAll!;

      page.value = slsList.pageable!.pageNumber! + 1;
      size.value = slsList.pageable!.pageSize!;

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

  // @override
  // void onClose() {
  //   // TODO: implement onClose
  //   super.onClose();
  // }
}
