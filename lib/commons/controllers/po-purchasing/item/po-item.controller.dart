import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
// import 'package:logger/logger.dart';
import 'package:siangmalam/commons/routes/routes_name.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/option_value.dart';
import 'package:siangmalam/models/purchase-orders/filter-po.dart';
import 'package:siangmalam/models/purchase-orders/po-item.dart';
import 'package:siangmalam/models/sub_branch.dart';
import 'package:siangmalam/services/app_static.dart';
import 'package:siangmalam/services/po/purchase-item.service.dart';
import 'package:siangmalam/widgets/snack_bar.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PoItemControllerV2 extends GetxController {
  // Main
  late int? branchId = AppStatic.userData.branchId!;
  int? subBranchId;
  late String? role = AppStatic.userData.role;
  // var log = Logger();
  DateTime today = DateTime.now();
  DateFormat dateFormat = DateFormat("dd-MM-yyyy");

  // Controller
  final PanelController pcs = PanelController();
  final textFieldController = TextEditingController(text: "").obs;
  var scrollController = ScrollController().obs;

  // PANEL
  final double initFabHeight = 5.h;
  double fabHeight = 0;
  double panelHeightOpen = 0;
  double panelHeightClosed = 5.h;

  // Data Filtering
  var filterPo = FilterGetAllPO().obs;

  // DropDown
  var itemStatus = <DropdownMenuItem<String>>[].obs;
  var itemOpt = <DropdownMenuItem<String>>[].obs;
  var itemsortBy = <DropdownMenuItem<String>>[].obs;
  var itemorderBy = <DropdownMenuItem<String>>[].obs;
  var subbranch = <DropdownMenuItem<int>>[].obs;

  // Boolean
  var loadingPage = false.obs;
  var allLoadedPage = false.obs;

  // DISPLAY
  var displayStartDate = ''.obs;
  var displayEndDate = ''.obs;

  // DATA
  var listpoitem = <ListPoItem>[].obs;

  @override
  void onInit() async {
    fabHeight = initFabHeight;
    super.onInit();
    scrollController.value.addListener(() {
      if (scrollController.value.position.pixels >=
              scrollController.value.position.maxScrollExtent &&
          loadingPage.isFalse) {
        getAllPoItem();
      }
    });
    displayEndDate.value = dateFormat.format(today);
    displayStartDate.value =
        dateFormat.format(today.subtract(const Duration(days: 30)));
    await initBranchDropdown();
    await generateSelected();
    await initFilterPo();
    await getAllPoItem();
  }

  // =======================================
  // INIT
  // =======================================

  /* Inisiasi Dropdown */
  initBranchDropdown() {
    List<SubBranch>? dataSub = AppStatic.userData.subBranch;
    subbranch.add(DropdownMenuItem<int>(
        child: Text(AppStatic.userData.branch.toString()), value: null));
    for (var item in dataSub!) {
      subbranch.add(DropdownMenuItem<int>(
          child: Text(item.name.toString()), value: item.id));
    }
  }

  /* Inisiasi All Choice */
  generateSelected() {
    itemStatus.value = statusPo;
    itemOpt.value = optionPo;
    itemorderBy.value = orderPo;
    itemsortBy.value = sortPo;
  }

  /* Inisiasi Filter */
  initFilterPo() {
    filterPo.update((val) {
      val?.branchId = branchId;
      val?.subBranchId = subBranchId;
      val?.page = 0;
      val?.size = 10;
      val?.search = textFieldController.value.text;
      val?.startDate =
          convertStringDate(today.subtract(const Duration(days: 30)));
      val?.startDate = convertStringDate(today);
      val?.status = 'ALL';
      val?.option = 'orderno';
      val?.sortBy = 'desc';
      val?.orderBy = 'createdAt';
    });
    filterPo.refresh();
    // log.d(filterPo.value.search);
  }

  // =======================================
  // METHOD
  // =======================================
  getAllPoItem() async {
    loadingPage.value = true;
    if (allLoadedPage.isTrue) {
      loadingPage.value = false;
      loadingPage.refresh();
      return;
    }
    await fetchPoPurchase();
  }

  setDate(DateTime start, DateTime end) {
    displayEndDate.value = dateFormat.format(end);
    displayStartDate.value = dateFormat.format(start);
    filterPo.value.startDate = convertStringDate(start);
    filterPo.value.endDate = convertStringDate(end);
    oneShot();
  }

  popupChoose(int limitValue) {
    switch (limitValue) {
      case 0:
        oneShot();
        break;
      case 1:
        Get.toNamed(RouteName.poitemFormScreenV2)?.then((value) => {
              if (value != null) {value ? oneShot() : null}
            });
        break;
      default:
    }
  }

  recoverData() {
    loadingPage.value = false;
    allLoadedPage.value = false;
    listpoitem.clear();

    filterPo.update((val) {
      val?.page = 0;
      val?.size = 10;
    });
  }

  oneShot() {
    recoverData();
    getAllPoItem();
  }

  cancelOrderPo(int i) {
    cancelDataItem(listpoitem.elementAt(i).orderNo!);
  }

  approveOrderPo(int i) {
    if (listpoitem.elementAt(i).items != null) {
      var approve = ApprovPoItem();
      var items = <ItemsPo>[];
      for (var el in listpoitem.elementAt(i).items!) {
        var item = ItemsPo();
        item.id = el.id;
        item.itemId = el.itemId;
        item.quantity = el.quantity;
        item.cost = el.cost;
        item.status = 'DONE';
        items.add(item);
      }
      approve.orderNo = listpoitem.elementAt(i).orderNo ?? '';
      approve.status = 'DONE';
      approve.note = listpoitem.elementAt(i).note ?? '';
      approve.items = items;
      approveDataItem(approve);
    }
  }

  // =======================================
  // API
  // =======================================
  fetchPoPurchase() async {
    // log.d(filterPo.toJson());
    try {
      ResPoItem resPoItem =
          await PurchaseItemService.getPoItemAll(filterPo.value);

      filterPo.value.page = resPoItem.pageable!.pageNumber! + 1;
      filterPo.value.size = resPoItem.pageable!.pageSize!;

      List<ListPoItem> newData =
          listpoitem.length >= resPoItem.pageable!.totalElements!
              ? []
              : resPoItem.listpoitem!;
      if (newData.isNotEmpty) {
        for (var item in newData) {
          listpoitem.add(item);
        }
        listpoitem.refresh();
      }
      loadingPage.value = false;
      loadingPage.refresh();
      allLoadedPage.value = newData.isEmpty;
      loadingPage.refresh();
    } catch (error) {
      Snackbar.show("Opps!", error.toString(), mtRed600, mtGrey50);
    }
  }

  Future<void> cancelDataItem(String orderId) async {
    bool result = await PurchaseItemService.cancelPoItem(orderId);
    if (result) {
      recoverData();
      oneShot();
    }
  }

  Future<void> approveDataItem(ApprovPoItem approvPoItem) async {
    bool result = await PurchaseItemService.approvalPoItem(approvPoItem);
    if (result) {
      recoverData();
      oneShot();
    }
  }

  // =======================================
  // UTIL
  // =======================================
  convertStringDate(DateTime date) {
    DateTime d = DateTime(date.year, date.month, date.day);
    String month = d.month.toString();
    String day = d.day.toString();
    String year = d.year.toString();

    if (month.length < 2) month = '0' + month;
    if (day.length < 2) day = '0' + day;
    return [year, month, day].join('-');
  }

  convertPrice(int? price) {
    if (price != null) {
      final currencyFormatter = NumberFormat('#,##0', 'ID');
      return 'Rp ' + currencyFormatter.format(price);
    } else {
      return 'Rp 0';
    }
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
