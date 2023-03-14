import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
// import 'package:logger/logger.dart';
import 'package:siangmalam/commons/functions/orientations.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/option_value.dart';
import 'package:siangmalam/models/report/report.dart';
import 'package:siangmalam/models/sub_branch.dart';
import 'package:siangmalam/services/all_report/cashbon_service.dart';
import 'package:siangmalam/services/app_static.dart';
import 'package:siangmalam/widgets/snack_bar.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:sizer/sizer.dart';

class ReportCashbonController extends GetxController {
  // var log = Logger();
  late Timer timer;
  var counter = "".obs;
  late int? branchId = AppStatic.userData.branchId ?? 0;
  int? subBranchId;

  final PanelController pcs = PanelController();
  var scrollController = ScrollController().obs;

  // PANEL
  final double _initFabHeight = 5.h;
  double fabHeight = 0;
  double panelHeightOpen = 0;
  double panelHeightClosed = 5.h;

  var cashbon = CashbonList().obs;
  var cashbonList = <Cashbon>[].obs;
  var filterCashbon = GetCashbonFilter().obs;
  var filterDownload = DownloadReportCashbon().obs;

  var days = 1.obs;
  var loadingPage = false.obs;
  var allLoadedPage = false.obs;

  var size = 10.obs;
  var page = 0.obs;
  var search = ''.obs;
  var startDate = DateTime.now()
      .subtract(const Duration(days: 1, hours: 0, minutes: 00, seconds: 00))
      .millisecondsSinceEpoch
      .obs;
  var endDate = DateTime.now().millisecondsSinceEpoch.obs;
  var option = 'name'.obs;

  var subbranch = <DropdownMenuItem<int>>[].obs;
  var dbopt = <DropdownMenuItem<String>>[].obs;
  var dbStartDate = typeFindStartDate;

  var textFieldSearch = TextEditingController().obs;

  @override
  void onInit() async {
    Orientations.defaultOrientation();
    super.onInit();
    fabHeight = _initFabHeight;
    dbopt.value = const [
      DropdownMenuItem<String>(child: Text('Oleh Nama'), value: "name"),
      DropdownMenuItem<String>(child: Text('Oleh Username'), value: "username"),
    ];
    initBranchDropdown();
    timer = Timer.periodic(
        const Duration(seconds: 1), (Timer t) => {updateEndDate()});

    scrollController.value.addListener(() {
      // // log.d(scrollController.value.position.maxScrollExtent);
      if (scrollController.value.position.pixels >=
              scrollController.value.position.maxScrollExtent &&
          loadingPage.isFalse) {
        // log.d("work");
        getCashbon();
      }
    });
    await getCashbon();
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

  refreshDataAll() {
    cashbon.value = CashbonList();
    cashbonList.clear();
    allLoadedPage.value = false;
    size.value = 10;
    page.value = 0;
  }

  getCashbon() async {
    await updateFilterCashbon();
    // log.d(filterCashbon.toJson());
    loadingPage.value = true;
    if (allLoadedPage.isTrue) {
      loadingPage.value = false;
      loadingPage.refresh();
      return;
    }
    await fetchDataCashbon();
  }

  downloadCashbon() async {
    await updateFilterDownload();
    // log.d(filterDownload.toJson());
    await downloadDataCashbon();
  }

  updateFilterCashbon() {
    search.value = textFieldSearch.value.text;
    filterCashbon.update((val) {
      val?.branchId = branchId;
      val?.subBranchId = subBranchId;
      val?.page = page.value;
      val?.size = size.value;
      val?.search = search.value;
      val?.option = option.value;
      val?.startDate = startDate.value;
      val?.endDate = endDate.value;
    });
  }

  updateFilterDownload() {
    filterDownload.update((val) {
      val?.branchId = branchId;
      val?.subBranchId = subBranchId;
      val?.search = search.value;
      val?.startDate = startDate.value;
      val?.endDate = endDate.value;
    });
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

  Future<void> fetchDataCashbon() async {
    loadingPage.value = true;
    try {
      CashbonList cashbon =
          await CashbonService.getCashbonList(filterCashbon.value);
      cashbonList.value = cashbon.cashbonlist!;

      page.value = cashbon.pageable!.pageNumber! + 1;
      size.value = cashbon.pageable!.pageSize!;

      List<Cashbon> newData =
          cashbonList.length >= cashbon.pageable!.totalElements!
              ? []
              : cashbon.cashbonlist!;
      if (newData.isNotEmpty) {
        for (var item in newData) {
          cashbonList.add(item);
        }
        cashbonList.refresh();
      }
      loadingPage.value = false;
      page.refresh();
      allLoadedPage.value = newData.isEmpty;
      cashbonList.refresh();
    } catch (error) {
      Snackbar.show("Opps!", error.toString(), mtRed600, mtGrey50);
    }
  }

  Future<void> downloadDataCashbon() async {
    CashbonService.downloadCashbonReport(filterDownload.value);
  }

  // @override
  // void onClose() {
  //   // TODO: implement onClose
  //   super.onClose();
  // }
}
