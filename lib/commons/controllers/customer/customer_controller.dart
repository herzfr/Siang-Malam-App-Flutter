import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
// import 'package:logger/logger.dart';
import 'package:siangmalam/commons/routes/routes_name.dart';
import 'package:siangmalam/models/PaginationFilter.dart';
import 'package:siangmalam/models/customer/customer.dart';
import 'package:siangmalam/services/customer/customer_service.dart';

class CustomerController extends GetxController {
  var pagingController = PagingController<int, ListCustomer>(firstPageKey: 0).obs;

  // DATA TABLE
  var size = 20.obs;
  var page = 0.obs;
  var search = ''.obs;

  var customer = Customer().obs;
  var listcustomer = ListCustomer().obs;
  // var log = Logger();

  final _paginationFilter = PaginationFilter().obs;
  final textFieldController = TextEditingController().obs;

  List<ListCustomer>? get stockproducts => customer.value.listcustomer;
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
    Get.toNamed(RouteName.customerFormScreen)?.then((value) => logData(value ?? false));
  }

  searchData() async {
    page.value = 0;
    _changePaginationFilter(page.value, size.value, textFieldController.value.text);

    Customer customerlist = await CustomerService.getCustomer(_paginationFilter.value);
    customer.value = customerlist;
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
      listcustomer.value = ListCustomer();
    } else {
      listcustomer.value = pagingController.value.itemList![index];
    }
  }

  clearValueSearch() {
    textFieldController.value.clearComposing();
    textFieldController.value.text = "";
    // log.d("message");
    _paginationFilter.value.search = search.value;
    _paginationFilter.value.page = page.value;
    _paginationFilter.value.size = size.value;
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
      Customer customerlist = await CustomerService.getCustomer(_paginationFilter.value);
      customer.value = customerlist;
      _changePaginationFilter(customerlist.pageable!.pageNumber!, customerlist.pageable!.pageSize!, search.value);
      final isLastPage = customer.value.listcustomer!.length < size.value;
      if (isLastPage) {
        pagingController.value.appendLastPage(customer.value.listcustomer!);
      } else {
        final nextPageKey = pageKey + customer.value.listcustomer!.length;
        pagingController.value.appendPage(customer.value.listcustomer!, nextPageKey);
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
