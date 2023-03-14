import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
// import 'package:logger/logger.dart';
import 'package:siangmalam/commons/routes/routes_name.dart';
import 'package:siangmalam/models/PaginationFilter.dart';
import 'package:siangmalam/models/suplier/suplier.dart';
import 'package:siangmalam/services/suplier/suplier_service.dart';

class SuplierController extends GetxController {
  var pagingController =
      PagingController<int, ListSuplier>(firstPageKey: 0).obs;

  // DATA TABLE
  var size = 20.obs;
  var page = 0.obs;
  var search = ''.obs;

  var suplier = Suplier().obs;
  var listsuplier = ListSuplier().obs;
  // var log = Logger();

  final _paginationFilter = PaginationFilter().obs;
  final textFieldController = TextEditingController().obs;

  //  final _stockProduct = <ListProducts>[].obs;
  List<ListSuplier>? get stockproducts => suplier.value.listSuplier;
  int? get _page => _paginationFilter.value.page;

  @override
  void onInit() {
    _changePaginationFilter(page.value, size.value, search.value);

    pagingController.value.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });

    super.onInit();
  }

  // ============================================
  // CONTROLER FUNC
  // ============================================
  _changePaginationFilter(int page, int size, String search) {
    _paginationFilter.update((val) {
      val?.page = page;
      val?.size = size;
      val?.search = search;
    });
  }

  // ============================================
  // SCREEN FUNC
  // ============================================

  addData() {
    // log.d('work');
    Get.toNamed(RouteName.suplierFormScreen)
        ?.then((value) => logData(value ?? false));
  }

  searchData() async {
    page.value = 0;
    _changePaginationFilter(
        page.value, size.value, textFieldController.value.text);

    Suplier suplierlist =
        await SuplierService.getSuplier(_paginationFilter.value);
    suplier.value = suplierlist;
    pagingController.value.refresh();
  }

  logData(dynamic data) {
    if (data) {
      searchData();
    }
  }

  changeTotalPerPage(int limitValue) {
    // log.d(limitValue);
    size.value = limitValue.toInt();
    search.value = textFieldController.value.text;
    _changePaginationFilter(page.value, size.value, search.value);
  }

  getDetail(index) {
    if (index == null) {
      listsuplier.value = ListSuplier();
    } else {
      listsuplier.value = pagingController.value.itemList![index];
    }
  }

  clearValueSearch() {
    textFieldController.value.clear();
    textFieldController.value.text = "";
    _paginationFilter.value.search = search.value;
    _paginationFilter.value.page = page.value;
    _paginationFilter.value.size = size.value;
    update();
    // pagingController.value.addPageRequestListener((pageKey) {
    //   _fetchPage(pageKey);
    // });
  }

  // ============================================
  // GET DATA
  // ============================================
  Future<void> _fetchPage(int pageKey) async {
    // log.d(pageKey);
    search.value = textFieldController.value.text;
    _changePaginationFilter(page.value, size.value, search.value);
    try {
      Suplier suplierlist =
          await SuplierService.getSuplier(_paginationFilter.value);
      suplier.value = suplierlist;
      _changePaginationFilter(suplierlist.pageable!.pageNumber!,
          suplierlist.pageable!.pageSize!, search.value);
      final isLastPage = suplier.value.listSuplier!.length < size.value;
      if (isLastPage) {
        pagingController.value.appendLastPage(suplier.value.listSuplier!);
      } else {
        final nextPageKey = pageKey + suplier.value.listSuplier!.length;
        pagingController.value
            .appendPage(suplier.value.listSuplier!, nextPageKey);
        page.value = _page! + 1;
      }
    } catch (error) {
      pagingController.value.error = error;
    }
  }

  @override
  void onClose() {
    super.onClose();
    textFieldController.value.dispose();
  }
}
