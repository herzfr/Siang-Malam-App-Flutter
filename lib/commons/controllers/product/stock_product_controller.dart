import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
// import 'package:logger/logger.dart';
import 'package:siangmalam/models/PaginationFilter.dart';
import 'package:siangmalam/models/product/stock_product.dart';
import 'package:siangmalam/services/product/product_service.dart';

class StockProductController extends GetxController {
  // DATA USER
  // UserDto user = AppStatic.userData;

  var pagingController = PagingController<int, ListProducts>(firstPageKey: 0).obs;

  // DATA TABLE
  var size = 20.obs;
  var page = 0.obs;
  var search = ''.obs;

  var stockProduct = StockProducts().obs;
  var listProduct = ListProducts().obs;
  // var log = Logger();

  // late PageController _pageController;
  // PageController get pageController => this._pageController;

  final _paginationFilter = PaginationFilter().obs;
  final _lastPage = false.obs;

  final _stockProduct = <ListProducts>[].obs;
  List<ListProducts>? get stockproducts => stockProduct.value.listProduct;
  // int? get _size => _paginationFilter.value.size;
  int? get _page => _paginationFilter.value.page;
  // String? get _search => _paginationFilter.value.search;
  bool get lastPage => _lastPage.value;

  final isLoading = false.obs;
  final textFieldController = TextEditingController().obs;

  // bool get _isLoading => isLoading.value;

  @override
  Future<void> onInit() async {
    // ever(_paginationFilter, (_) => getDataStockProduct());
    _changePaginationFilter(page.value, size.value, search.value);
    pagingController.value.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    pagingController.value.addStatusListener((status) {
      if (status == PagingStatus.subsequentPageError) {
        // log.d(status);
      }
    });
    super.onInit();
    // _paginationFilter.dispose();
  }

  searchData() async {
    // log.d("search data ${textFieldController.value.text}");
    page.value = 0;
    _changePaginationFilter(page.value, size.value, textFieldController.value.text);

    StockProducts stockProdList = await ProductService.getStockProduct(_paginationFilter.value);
    stockProduct.value = stockProdList;
    pagingController.value.refresh();
  }

  logData(dynamic data) {
    if (data) {
      searchData();
    }
  }

  changeTotalPerPage(int limitValue) {
    // log.d(limitValue);
    _lastPage.value = false;
    size.value = limitValue.toInt();
    search.value = textFieldController.value.text;
    _changePaginationFilter(page.value, size.value, search.value);
  }

  _changePaginationFilter(int page, int size, String search) {
    _paginationFilter.update((val) {
      val?.page = page;
      val?.size = size;
      val?.search = search;
    });
  }

  getDetailStockProduct(index) {
    // listProduct.value = new ListProducts();
    // log.d(index);
    // log.d(pagingController.value.itemList![index].toJson());
    listProduct.value = pagingController.value.itemList![index];
  }

  clearValueSearch() {
    textFieldController.value.clear();
    textFieldController.value.text = "";
    _paginationFilter.value.search = search.value;
    _paginationFilter.value.page = page.value;
    _paginationFilter.value.size = size.value;
    _stockProduct.clear();
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
    _stockProduct.clear();
    try {
      StockProducts stockProdList = await ProductService.getStockProduct(_paginationFilter.value);
      stockProduct.value = stockProdList;
      _changePaginationFilter(stockProdList.pageable!.pageNumber!, stockProdList.pageable!.pageSize!, search.value);
      final isLastPage = stockProduct.value.listProduct!.length < size.value;
      if (isLastPage) {
        pagingController.value.appendLastPage(stockProduct.value.listProduct!);
      } else {
        final nextPageKey = pageKey + _stockProduct.length;
        pagingController.value.appendPage(stockProduct.value.listProduct!, nextPageKey);
        page.value = _page! + 1;
      }
    } catch (error) {
      pagingController.value.error = error;
    }
  }
}
