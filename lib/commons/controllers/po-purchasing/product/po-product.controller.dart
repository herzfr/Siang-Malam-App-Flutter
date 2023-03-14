import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
// import 'package:logger/logger.dart';
import 'package:siangmalam/commons/routes/routes_name.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/option_value.dart';
import 'package:siangmalam/models/purchase-orders/filter-po.dart';
import 'package:siangmalam/models/purchase-orders/po-product.dart';
import 'package:siangmalam/models/sub_branch.dart';
import 'package:siangmalam/services/app_static.dart';
import 'package:siangmalam/services/po/purchase-product.service.dart';
import 'package:siangmalam/widgets/snack_bar.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PoProductControllerV2 extends GetxController {
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
  var listpoproduct = <ListPoProduct>[].obs;

  @override
  void onInit() async {
    fabHeight = initFabHeight;
    super.onInit();
    scrollController.value.addListener(() {
      if (scrollController.value.position.pixels >= scrollController.value.position.maxScrollExtent && loadingPage.isFalse) {
        getAllPoProduct();
      }
    });
    displayEndDate.value = dateFormat.format(today);
    displayStartDate.value = dateFormat.format(today.subtract(const Duration(days: 30)));
    await initBranchDropdown();
    await generateSelected();
    await initFilterPo();
    await getAllPoProduct();
  }

  // =======================================
  // INIT
  // =======================================

  /* Inisiasi Dropdown */
  initBranchDropdown() {
    List<SubBranch>? dataSub = AppStatic.userData.subBranch;
    subbranch.add(DropdownMenuItem<int>(child: Text(AppStatic.userData.branch.toString()), value: null));
    for (var item in dataSub!) {
      subbranch.add(DropdownMenuItem<int>(child: Text(item.name.toString()), value: item.id));
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
      val?.startDate = convertStringDate(today.subtract(const Duration(days: 30)));
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
  getAllPoProduct() async {
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
        Get.toNamed(RouteName.poproductFormScreenV2)?.then((value) => {
              if (value != null) {value ? oneShot() : null}
            });
        break;
      default:
    }
  }

  recoverData() {
    loadingPage.value = false;
    allLoadedPage.value = false;
    listpoproduct.clear();

    filterPo.update((val) {
      val?.page = 0;
      val?.size = 10;
    });
  }

  oneShot() {
    recoverData();
    getAllPoProduct();
  }

  cancelOrderPo(int i) {
    cancelDataProduct(listpoproduct.elementAt(i).orderNo!);
  }

  approveOrderPo(int i) {
    if (listpoproduct.elementAt(i).products != null) {
      var approve = ApprovPoProduct();
      var products = <ProductsPo>[];
      for (var el in listpoproduct.elementAt(i).products!) {
        var prod = ProductsPo();
        prod.id = el.id;
        prod.productId = el.productId;
        prod.quantity = el.quantity;
        prod.cost = el.cost;
        prod.status = 'DONE';
        products.add(prod);
      }
      approve.orderNo = listpoproduct.elementAt(i).orderNo ?? '';
      approve.status = 'DONE';
      approve.note = listpoproduct.elementAt(i).note ?? '';
      approve.products = products;
      approveDataProduct(approve);
    }
  }

  // =======================================
  // API
  // =======================================
  fetchPoPurchase() async {
    // log.d(filterPo.toJson());
    try {
      ResPoProduct resPoProduct = await PurchaseProductService.getPoProductAll(filterPo.value);
      // listpoproduct.value = resPoProduct.listpoproduct!;

      filterPo.value.page = resPoProduct.pageable!.pageNumber! + 1;
      filterPo.value.size = resPoProduct.pageable!.pageSize!;

      List<ListPoProduct> newData = listpoproduct.length >= resPoProduct.pageable!.totalElements! ? [] : resPoProduct.listpoproduct!;
      if (newData.isNotEmpty) {
        for (var item in newData) {
          listpoproduct.add(item);
        }
        listpoproduct.refresh();
      }
      loadingPage.value = false;
      loadingPage.refresh();
      allLoadedPage.value = newData.isEmpty;
      loadingPage.refresh();
    } catch (error) {
      Snackbar.show("Opps!", error.toString(), mtRed600, mtGrey50);
    }
  }

  Future<void> cancelDataProduct(String orderId) async {
    bool result = await PurchaseProductService.cancelPoProduct(orderId);
    if (result) {
      recoverData();
      oneShot();
    }
  }

  Future<void> approveDataProduct(ApprovPoProduct approvPoProduct) async {
    bool result = await PurchaseProductService.approvalPoProduct(approvPoProduct);
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

  @override
  void onClose() {
    super.onClose();
  }
}
