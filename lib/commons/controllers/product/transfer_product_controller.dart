import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
// import 'package:logger/logger.dart';
import 'package:siangmalam/commons/routes/routes_name.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/option_value.dart';
import 'package:siangmalam/models/sub_branch.dart';
import 'package:siangmalam/models/transfer/transfer.dart';
import 'package:siangmalam/models/transfer/upsert_transfer.dart';
import 'package:siangmalam/services/app_static.dart';
import 'package:siangmalam/services/product/product_service.dart';
import 'package:siangmalam/widgets/snack_bar.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class TransferProductController extends GetxController {
  // var log = Logger();
  late int? branchId = AppStatic.userData.branchId;
  int? subBranchId;
  var level = AppStatic.userData.level;
  var role = AppStatic.userData.role;

  // DATE
  DateFormat dateFormat = DateFormat("dd-MM-yyyy");
  var displayStartDate = ''.obs;
  var displayEndDate = ''.obs;
  var range = ''.obs;
  var rangeCount = ''.obs;

  final PanelController pcs = PanelController();
  var scrollController = ScrollController().obs;

  var transfer = Transfer().obs;
  var transferlist = <TransferList>[].obs;
  // PANEL
  final double _initFabHeight = 5.h;
  double fabHeight = 0;
  double panelHeightOpen = 0;
  double panelHeightClosed = 5.h;

  var textFieldSearch = TextEditingController().obs;

  // Main Filter
  var size = 10.obs;
  var page = 0.obs;
  var search = ''.obs;
  var endDate = DateTime.now().millisecondsSinceEpoch.obs;
  var startDate = DateTime(
          DateTime.now().year, DateTime.now().month - 1, DateTime.now().day)
      .millisecondsSinceEpoch
      .obs;
  // var isBack = false.obs;
  var as = 'send'.obs;

  // TEST STEP
  var currentStep = 0.obs;

  var filterTfList = FilterTransferList().obs;

  var loadingPageTransferList = false.obs;
  var allLoadedPageTransfer = false.obs;

  var subbranch = <DropdownMenuItem<int>>[].obs;
  var ddTypeTf = typeTransfer;

  @override
  void onInit() async {
    transferlist.value = <TransferList>[];
    // log.d("run");
    // log.d(DateTime.now());
    // log.d(DateTime(
    //     DateTime.now().year, DateTime.now().month - 1, DateTime.now().day));
    super.onInit();

    displayStartDate.value = dateFormat.format(DateTime.now());
    displayEndDate.value = dateFormat.format(DateTime.now());
    initBranchDropdown();
    getAllTransferList();
    scrollController.value.addListener(() {
      // // log.d(scrollController.value.position.maxScrollExtent);
      if (scrollController.value.position.pixels >=
              scrollController.value.position.maxScrollExtent &&
          loadingPageTransferList.isFalse) {
        // log.d("work");
        getAllTransferList();
      }
    });
  }

  setDate(DateTime start, DateTime end) {
    displayEndDate.value = dateFormat.format(end);
    displayStartDate.value = dateFormat.format(start);
    startDate.value = start.microsecondsSinceEpoch;
    endDate.value = end.microsecondsSinceEpoch;
    refreshListPageTransfer();
    getAllTransferList();
  }

  refreshListPageTransfer() {
    transferlist.value = <TransferList>[];
    size.value = 10;
    page.value = 0;
    // search.value = '';
    endDate.value = DateTime.now().millisecondsSinceEpoch;
    startDate.value = DateTime(
            DateTime.now().year, DateTime.now().month - 1, DateTime.now().day)
        .millisecondsSinceEpoch;
    loadingPageTransferList.value = false;
    allLoadedPageTransfer.value = false;
  }

  initBranchDropdown() {
    // log.d(AppStatic.userData.branchId);
    // log.d(AppStatic.userData.subBranch);
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

  popupChoose(int limitValue) {
    switch (limitValue) {
      case 0:
        size.value = 20;
        refreshListPageTransfer();
        getAllTransferList();
        break;
      case 1:
        Get.toNamed(RouteName.transferProductFormScreen)?.then((value) => {
              if (value != null) {value ? oneShot() : null}
            });
        break;
      default:
    }
  }

  oneShot() {
    refreshListPageTransfer();
    getAllTransferList();
  }

  // ===============================================================
  // TRANSFER LIST
  // ===============================================================

  getAllTransferList() async {
    updateFilterTransferList();
    loadingPageTransferList.value = true;
    if (allLoadedPageTransfer.isTrue) {
      loadingPageTransferList.value = false;
      loadingPageTransferList.refresh();
      return;
    }
    await fetchTransferList();
  }

  updateFilterTransferList() {
    filterTfList.update((val) {
      val?.branchId = branchId;
      val?.subBranchId = subBranchId;
      val?.page = page.value;
      val?.size = size.value;
      val?.search = search.value;
      val?.startDate = startDate.value;
      val?.endDate = endDate.value;
      // val?.isBack = isBack.value;
    });
    // log.d(filterTfList.toJson());
  }

  // ===============================================================
  // FETCH API DATA
  // ===============================================================
  Future<void> fetchTransferList() async {
    // log.d(reqOrder.toJson());
    loadingPageTransferList.value = true;
    try {
      transfer.value =
          await ProductService.getTransferList(filterTfList.value, as.value);
      transferlist.value = transfer.value.transferlist!;

      page.value = transfer.value.pageable!.pageNumber! + 1;
      size.value = transfer.value.pageable!.pageSize!;

      List<TransferList> newData =
          transferlist.length >= transfer.value.pageable!.totalElements!
              ? []
              : transfer.value.transferlist!;
      if (newData.isNotEmpty) {
        for (var item in newData) {
          transferlist.value.add(item);
        }
        transferlist.refresh();
      }
      loadingPageTransferList.value = false;
      loadingPageTransferList.refresh();
      allLoadedPageTransfer.value = newData.isEmpty;
      transferlist.refresh();
    } catch (error) {
      Snackbar.show("Opps!", error.toString(), mtRed600, mtGrey50);
    }
  }

  checkStep(i) {
    var tfl = transferlist.elementAt(i);
    // log.d(tfl.isSenderApproved);
    // log.d(tfl.isReceiverApproved);
    if (tfl.isSenderApproved! && !tfl.isReceiverApproved!) {
      return 0;
    } else if (!tfl.isSenderApproved! && tfl.isReceiverApproved!) {
      return 1;
    }
  }

  checkMessage(i) {
    var tfl = transferlist.elementAt(i);
    if (tfl.isDelivery! && !(tfl.isReceiverApproved ?? false)) {
      return 'Dikirim';
    } else if (!tfl.isDelivery! && tfl.isReceiverApproved!) {
      return 'Diterima';
    }
  }

  checkIsSenderApproved(int idx) {
    // log.d(transferlist.elementAt(idx).isSenderApproved!);
    return true;
  }

  prepareCancelation(int i) {
    var pre = CancelTransfer();
    pre.id = transferlist.elementAt(i).id;
    pre.isCanceled = true;
    // log.d(pre.toJson());
    return pre;
  }

  Future<void> cancelTransfer(int i) async {
    // log.d(reqOrder.toJson());
    bool res = await ProductService.cancelTransfer(prepareCancelation(i));
    if (res) {
      Snackbar.show("Sukses", "Pembatalan pengiriman produk berhasil",
          primaryGreen, textColor);
      oneShot();
    }
  }

  // @override
  // void onClose() {
  //   // TODO: implement onClose
  //   super.onClose();
  // }
}
