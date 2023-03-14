import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
// import 'package:logger/logger.dart';
import 'package:siangmalam/commons/routes/routes_name.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/models/product/stock_kitchen.dart';
import 'package:siangmalam/services/app_static.dart';
import 'package:siangmalam/services/product/spa_service.dart';
import 'package:siangmalam/widgets/snack_bar.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SpaController extends GetxController {
  // var log = Logger();
  late int? branchId = AppStatic.userData.branchId;
  int? subBranchId;
  var level = AppStatic.userData.level;
  var role = AppStatic.userData.role;

  final PanelController pcs = PanelController();
  var scrollController = ScrollController().obs;

  // DATE
  DateFormat dateFormat = DateFormat("dd-MM-yyyy");
  var displayStartDate = ''.obs;
  var displayEndDate = ''.obs;
  var range = ''.obs;
  var rangeCount = ''.obs;

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

  var listAdjustment = ResProductAdjustment().obs;
  var adList = <ProductAdjustment>[].obs;
  var product = ProductAdjustment().obs;
  var filter = GetProdAdjst().obs;
  var items = <ProdAdjs>[].obs;

  var loadingPageAdjustList = false.obs;
  var allLoadedPageAdjustList = false.obs;

  @override
  void onInit() {
    super.onInit();

    displayStartDate.value = dateFormat.format(DateTime.now());
    displayEndDate.value = dateFormat.format(DateTime.now());

    getAllAdjustList();
    scrollController.value.addListener(() {
      // // log.d(scrollController.value.position.maxScrollExtent);
      if (scrollController.value.position.pixels >=
              scrollController.value.position.maxScrollExtent &&
          loadingPageAdjustList.isFalse) {
        // log.d("work");
        getAllAdjustList();
      }
    });
  }

  getAllAdjustList() async {
    updateFilterAdjustList();
    loadingPageAdjustList.value = true;
    if (allLoadedPageAdjustList.isTrue) {
      loadingPageAdjustList.value = false;
      loadingPageAdjustList.refresh();
      return;
    }
    await fetchAdjustList();
  }

  updateFilterAdjustList() {
    filter.update((val) {
      val?.page = page.value;
      val?.size = size.value;
      val?.search = search.value;
      val?.startDate = startDate.value;
      val?.endDate = endDate.value;
    });
    // log.d(filter.toJson());
  }

  setDate(DateTime start, DateTime end) {
    displayEndDate.value = dateFormat.format(end);
    displayStartDate.value = dateFormat.format(start);
    startDate.value = start.microsecondsSinceEpoch;
    endDate.value = end.microsecondsSinceEpoch;
    refreshListPageAdjust();
    getAllAdjustList();
  }

  refreshListPageAdjust() {
    adList.value = <ProductAdjustment>[];
    size.value = 10;
    page.value = 0;
    // search.value = '';
    endDate.value = DateTime.now().millisecondsSinceEpoch;
    startDate.value = DateTime(
            DateTime.now().year, DateTime.now().month - 1, DateTime.now().day)
        .millisecondsSinceEpoch;
    loadingPageAdjustList.value = false;
    allLoadedPageAdjustList.value = false;
  }

  oneShot() {
    refreshListPageAdjust();
    getAllAdjustList();
  }

  popupChoose(int limitValue) {
    switch (limitValue) {
      case 0:
        size.value = 10;
        oneShot();
        break;
      case 1:
        Get.toNamed(RouteName.spaFormScreen)?.then((value) => {
              if (value != null) {value ? oneShot() : null}
            });
        break;
      default:
    }
  }

  converDateMillisToString(int millis) {
    var dt = DateTime.fromMillisecondsSinceEpoch(millis);
    return DateFormat('dd MMMM yyyy').format(dt).toString();
  }

  // ===============================================================
  // FETCH API DATA
  // ===============================================================
  Future<void> fetchAdjustList() async {
    // log.d(reqOrder.toJson());
    loadingPageAdjustList.value = true;
    try {
      listAdjustment.value = await SpaService.getSPA(filter.value);
      adList.value = listAdjustment.value.content!;

      page.value = listAdjustment.value.pageable!.pageNumber! + 1;
      size.value = listAdjustment.value.pageable!.pageSize!;

      List<ProductAdjustment> newData =
          adList.length >= listAdjustment.value.pageable!.totalElements!
              ? []
              : listAdjustment.value.content!;
      if (newData.isNotEmpty) {
        for (var item in newData) {
          adList.add(item);
        }
        adList.refresh();
      }
      loadingPageAdjustList.value = false;
      loadingPageAdjustList.refresh();
      allLoadedPageAdjustList.value = newData.isEmpty;
      adList.refresh();
    } catch (error) {
      Snackbar.show("Opps!", error.toString(), mtRed600, mtGrey50);
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
