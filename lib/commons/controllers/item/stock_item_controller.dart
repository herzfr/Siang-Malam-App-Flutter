import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
// import 'package:logger/logger.dart';
import 'package:siangmalam/models/PaginationFilter.dart';
import 'package:siangmalam/models/product/stock_item.dart';
import 'package:siangmalam/services/product/product_service.dart';

class StockItemController extends GetxController {
  // PAGING
  final _paginationFilter = PaginationFilter().obs;
  var pagingController =
      PagingController<int, ListStockItem>(firstPageKey: 0).obs;

// MODEL
  var stockItem = StockItem().obs;
  var listItem = ListStockItem().obs;
  // var log = Logger();

  // GET DATA
  int? get _page => _paginationFilter.value.page;

  // INIT FIRST DATA
  var size = 20.obs;
  var page = 0.obs;
  var search = ''.obs;

  // CONTROLLER
  final textFieldController = TextEditingController().obs;

  @override
  void onInit() {
    _changePaginationFilter(page.value, size.value, search.value);
    pagingController.value.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.onInit();
  }

  _changePaginationFilter(int page, int size, String search) {
    _paginationFilter.update((val) {
      val?.page = page;
      val?.size = size;
      val?.search = search;
    });
  }

  changeTotalPerPage(int limitValue) {
    // log.d(limitValue);
    // _lastPage.value = false;
    size.value = limitValue.toInt();
    search.value = textFieldController.value.text;
    _changePaginationFilter(page.value, size.value, search.value);
  }

  searchData() async {
    page.value = 0;
    _changePaginationFilter(
        page.value, size.value, textFieldController.value.text);
    StockItem stocKItem =
        await ProductService.getStockItems(_paginationFilter.value);
    stockItem.value = stocKItem;
    pagingController.value.refresh();
  }

  getDetailStockProduct(index) {
    listItem.value = pagingController.value.itemList![index];
  }

  clearValueSearch() {
    textFieldController.value.clear();
    textFieldController.value.text = "";
    _paginationFilter.value.search = search.value;
    _paginationFilter.value.page = page.value;
    _paginationFilter.value.size = size.value;
    pagingController.value.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  // ============================================
  // GET DATA
  // ============================================
  Future<void> _fetchPage(int pageKey) async {
    // log.d(pageKey);
    search.value = textFieldController.value.text;
    _changePaginationFilter(page.value, size.value, search.value);
    try {
      StockItem stocKItem =
          await ProductService.getStockItems(_paginationFilter.value);
      stockItem.value = stocKItem;
      _changePaginationFilter(stocKItem.pageable!.pageNumber!,
          stocKItem.pageable!.pageSize!, search.value);
      final isLastPage = stockItem.value.listStockItem!.length < size.value;
      if (isLastPage) {
        pagingController.value.appendLastPage(stockItem.value.listStockItem!);
      } else {
        final nextPageKey = pageKey + stockItem.value.listStockItem!.length;
        pagingController.value
            .appendPage(stockItem.value.listStockItem!, nextPageKey);
        page.value = _page! + 1;
      }
    } catch (error) {
      pagingController.value.error = error;
    }
  }

  logData(dynamic data) {
    if (data) {
      searchData();
    }
  }
}
