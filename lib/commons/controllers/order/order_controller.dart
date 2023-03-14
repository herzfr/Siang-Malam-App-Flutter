import 'dart:async';

import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
// import 'package:logger/logger.dart';
import 'package:siangmalam/commons/functions/orientations.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/enums.dart';
import 'package:siangmalam/constans/option_value.dart';
import 'package:siangmalam/models/order/all-order-response.dart';
import 'package:siangmalam/models/order/category-menu-prod.dart';
import 'package:siangmalam/models/order/create-order-response.dart';
import 'package:siangmalam/models/order/get-order.dart';
import 'package:siangmalam/models/order/menu-filter.dart';
import 'package:siangmalam/models/order/menu.dart';
import 'package:siangmalam/models/order/package.dart';
import 'package:siangmalam/models/order/price-categories.dart';
import 'package:siangmalam/models/order/table-filter.dart';
import 'package:siangmalam/models/order/table.dart';
import 'package:siangmalam/models/order/upsert-table.dart';
import 'package:siangmalam/models/product/category_product.dart';
import 'package:siangmalam/models/sub_branch.dart';
import 'package:siangmalam/services/app_static.dart';
import 'package:siangmalam/services/order/order_service.dart';
import 'package:siangmalam/widgets/snack_bar.dart';

/* Created By Dwi Sutrisno */

class OrderController extends GetxController with GetTickerProviderStateMixin {
  // ================================================
  // MAIN
  // ================================================

  // var log = Logger();
  late Timer timer;
  // final Duration duration = const Duration(milliseconds: 300);
  // late final AnimationController animationController;

  late int? branchId = AppStatic.userData.branchId!;
  int? subBranchId;
  var level = AppStatic.userData.level;

  var badge = true.obs;
  var duration = 0.obs;
  var shift = 6.obs;

  // TAB CONTROL
  final List<Tab> listTab = <Tab>[
    const Tab(text: 'MEJA'),
    const Tab(text: 'MENU'),
    const Tab(icon: Icon(Icons.shopping_cart)),
  ];
  late TabController tabController;
  var dDBranch = <DropdownMenuItem<int>>[].obs;

  var isLoading = false.obs;
  // PrinterController printController = Get.find();

  BluetoothDevice? device = AppStatic.device;
  BlueThermalPrinter printer = AppStatic.printerThermalInstance;

  // ================================================
  // MEJA | TABLE
  // ================================================
  final formKey = GlobalKey<FormState>();
  var optionTable = 2.obs;
  var dDtypeOrder = <DropdownMenuItem<int>>[].obs;
  var scrollController = ScrollController().obs;
  var scrollPosition = 0.0.obs;

  // REQ MODEL
  var createTable = CreateTable().obs;
  var updateTable = UpdateTable().obs;
  var occupationTable = UpdateTableO().obs;
  var allOrder = AllOrderRes().obs;
  var orderList = <CreateOrderResponse>[].obs;

  // DATA
  var filterTable = TableFilter().obs;
  var listTable = <ListTable>[].obs;

  // Text Form Controller
  final textFieldTableController = TextEditingController().obs;
  final textFieldNameController = TextEditingController().obs;
  final textFieldNoteController = TextEditingController().obs;

  final textFieldCapacityController = TextEditingController().obs;

  // SELECTED TABLE
  // var selectedTableActive = 0.obs;
  int? id;
  late final selectedTableActive = ListTable().obs;

  var reqOrder = GetOrder().obs;
  var dateFormat = DateFormat('dd/MM/yyyy HH:mm');

  int? startDate;
  int? endDate;

  var sizePageOrder = 20.obs;
  var pagePageOrder = 0.obs;
  var searchPageOrder = ''.obs;

  // GET DATA
  int? get _pageOrder => menuFilter.value.page;

  //  PAGE
  var loading = false.obs;
  var allLoaded = false.obs;

  // ================================================
  // MENU
  // ================================================
  var sc = ScrollController().obs;
  var dDCategoryPrice = <DropdownMenuItem<String>>[].obs;
  var textFieldController = TextEditingController().obs;
  var selectedCategory = 0.obs;

  var categoryMenu = CategoryMenuProduct().obs;
  var categoryMenuList = <CategoryProduct>[].obs;

  var categoryPrice = PriceCategories().obs;
  var categoryPriceList = <ListPriceCategories>[].obs;

  var character = TypeMenu.product.obs;
  var priceWho = "".obs;

  var menuProduct = MenuProduct().obs;
  var listMenuProduct = <Menu>[].obs;

  var menuPackage = MenuPackage().obs;
  var listMenuPackage = <Package>[].obs;

  var menuFilter = MenuFilter().obs;

  var size = 7.obs;
  var page = 0.obs;
  var search = ''.obs;
  late String? option;

  // GET DATA
  int? get _page => reqOrder.value.page;

  //  PAGE
  var loadingPageOrder = false.obs;
  var allLoadedPageOrder = false.obs;

  // ================================================
  // PESANAN
  // ================================================
  // var createTempSales = CreateTempSales().obs;
  // var updateTempSales = UpdateTempSales().obs;
  // var cartList = <Cart>[].obs;
  final formKey2 = GlobalKey<FormState>();
  var createOrderRes = CreateOrderResponse().obs;
  var cartList = <Cart>[].obs;
  final textFieldWhyController = TextEditingController().obs;

  @override
  void onInit() {
    Orientations.forcePortrait();
    super.onInit();
    generateDate();
    // animationController = AnimationController(vsync: this, duration: duration);
    // initAnimationController();
    timer = Timer.periodic(
        const Duration(seconds: 1), (Timer t) => {generateDate()});
    tabController = TabController(vsync: this, length: listTab.length)
      ..addListener(() {
        // log.d(tabController.index);
        // scrollController.jumpTo(scrollPosition!);
        if (scrollController.value.hasClients) {
          scrollController.value.animateTo(scrollPosition.value,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOutCubic);
        }
      });

    scrollController.value.addListener(() {
      // // log.d(scrollController.value.position.maxScrollExtent);
      scrollPosition.value = scrollController.value.position.pixels;
      if (scrollController.value.position.pixels >=
              scrollController.value.position.maxScrollExtent &&
          loadingPageOrder.isFalse) {
        // log.d("work");
        getAllOrder();
      }
    });
    // tabController.addListener(() {
    //   // log.d(tabController.index);
    //   if (tabController.index == 2) {}
    // ================================================
    // MEJA | TABLE
    // ================================================
    setBranchDropDown();
    dDtypeOrder.value = typeOrder;
    checkOptionType();

    // ================================================
    // MENU
    // ================================================
    getDataCategory();
    _fetchDataCategoryPrice();

    // ================================================
    // PESANAN
    // ================================================
  }

  generateDate() {
    startDate = DateTime.now()
        .subtract(const Duration(days: 2, hours: 0, minutes: 00, seconds: 00))
        .millisecondsSinceEpoch;
    endDate = DateTime.now().millisecondsSinceEpoch;
    // startDate = dateFormat.parse('31/05/2022 00:00').millisecondsSinceEpoch;
    // endDate = dateFormat.parse('31/05/2022 23:59').millisecondsSinceEpoch;
  }

  checkOptionType() {
    if (optionTable.value == 2) {
      getDataTable();
    } else {
      generateDate();
      getAllOrder();
    }
  }

  // Future<void> initAnimationController() async {
  //   animationController = AnimationController(vsync: this, duration: duration);
  // }

  setBranchDropDown() {
    List<SubBranch>? dataSub = AppStatic.userData.subBranch;
    if (level == 'BRANCH') {
      dDBranch.add(DropdownMenuItem<int>(
          child: Text(AppStatic.userData.branch.toString()), value: null));
    }
    subBranchId = dataSub!.first.id;
    for (var item in dataSub) {
      dDBranch.add(DropdownMenuItem<int>(
          child: Text(item.name.toString()), value: item.id));
    }
  }

  // ================================================
  // MEJA | TABLE
  // ================================================

  refreshTable() {
    // if (optionTable.value == 2) {
    getDataTable();
    // }
  }

  refresSelectedTable() {
    // // log.d('refresh selected work');
    selectedTableActive.value = ListTable();
    // // log.d(selectedTableActive.toJson());
    refreshTable();
  }

  getDataTable() async {
    changePaginationTableFilter(
        0, 100, "", AppStatic.userData.branchId!, subBranchId);
    _fetchDataTabel();
  }

  changePaginationTableFilter(
      int page, int size, String search, int branchId, int? subBranchId) {
    filterTable.update((val) {
      val?.page = page;
      val?.size = size;
      val?.search = search;
      val?.branchId = branchId;
      val?.subBranchId = subBranchId;
    });
  }

  getSalesId(int search) {
    // log.d(search);
  }

  getOrderListBySalesId(String search) async {
    await _fetchDataorder(search);
    // // log.d(createOrderRes.value.items);
    updateCart();
  }

  seeOrderList(int index) {
    cartList.clear();
    cartList.refresh();
    createOrderRes.value = CreateOrderResponse();
    createOrderRes.refresh();
    createOrderRes.value = orderList.elementAt(index);
    cartList.value.addAll(createOrderRes.value.items!);
    tabController.index = 2;
  }

  updateCart() {
    cartList.value = <Cart>[];
    cartList.refresh();
    cartList.addAll(createOrderRes.value.items!);
    // for (var item in createOrderRes.value.items!) {
    //   cartList.add(insertBackCartAfterSave(item));
    // }
    cartList.refresh();
    // log.d(cartList.toJson());
    selectedTableActive.value.isOccupied = true;
    selectedTableActive.value.salesId = createOrderRes.value.id;
    tabController.index = 2;
  }

  refreshDataAllOrder() {
    allOrder.value = AllOrderRes();
    orderList.value = <CreateOrderResponse>[];
    allLoadedPageOrder.value = false;

    sizePageOrder.value = 20;
    pagePageOrder.value = 0;
    searchPageOrder.value = '';
  }

  setTrigger() async {
    await OrderService.sendTrigger((branchId!), (subBranchId!));
  }

  getAllOrder() async {
    updatePageFilterOrderList(pagePageOrder.value, sizePageOrder.value, "",
        "other", branchId, subBranchId, startDate, endDate);
    loadingPageOrder.value = true;
    if (allLoadedPageOrder.isTrue) {
      loadingPageOrder.value = false;
      loadingPageOrder.refresh();
      return;
    }
    await _fetchPackage();
    await _fetchAllorder();
    allOrder.refresh();
    orderList.refresh();
  }

  updatePageFilterOrderList(int page, int size, String search, String option,
      int? branchId, int? subBranchId, int? startDate, int? endDate) {
    reqOrder.update((val) {
      val?.branchId = branchId;
      val?.subBranchId = subBranchId;
      val?.option = option;
      val?.startDate = startDate;
      val?.endDate = endDate;
      val?.search = search;
      val?.size = size;
      val?.page = page;
    });
  }

  checkTable(List<int> table) {
    // log.d(table.toList());
    if (table.isEmpty) {
      return "-";
    }
    ListTable lt = listTable.firstWhere((p0) => p0.id == table.elementAt(0),
        orElse: () => ListTable());
    // log.d(lt.name.toString());
    return lt.name;
  }

  Future<void> _fetchAllorder() async {
    // log.d(reqOrder.toJson());

    loadingPageOrder.value = true;
    try {
      // await Future.delayed(Duration(milliseconds: duration.value))
      //     .then((_) async {
      allOrder.value = await OrderService.getAllOrder(reqOrder.value);
      // });
      orderList.value = allOrder.value.allOrderList!;
      //  orderList.value = allOrder.value.allOrderList!;
      duration.value = 0;
      pagePageOrder.value = allOrder.value.pageable!.pageNumber! + 1;
      sizePageOrder.value = allOrder.value.pageable!.pageSize!;

      List<CreateOrderResponse> newData =
          orderList.value.length >= allOrder.value.pageable!.totalElements!
              ? []
              : allOrder.value.allOrderList!;
      // log.d(newData);
      if (newData.isNotEmpty) {
        for (var item in newData) {
          orderList.value.add(item);
        }
        orderList.refresh();
      }

      loadingPageOrder.value = false;
      loadingPageOrder.refresh();
      allLoadedPageOrder.value = newData.isEmpty;

      orderList.refresh();

      // log.d(allOrder.value.toJson());
    } catch (error) {
      Snackbar.show("Opps!", error.toString(), mtRed600, mtGrey50);
    }
  }

  Future<void> _fetchDataorder(salesId) async {
    // log.d(reqOrder.toJson());
    try {
      createOrderRes.value =
          await OrderService.getOrderRequestJustSalesId(salesId);
      // log.d(createOrderRes.value.toJson());
    } catch (error) {
      Snackbar.show("Opps!", error.toString(), mtRed600, mtGrey50);
    }
  }

  Future<void> _fetchDataTabel() async {
    // log.d(filterTable.toJson());
    try {
      TableModel tbl = await OrderService.getTable(filterTable.value);
      listTable.value = tbl.listTable!;
      listTable.refresh();
    } catch (error) {
      Snackbar.show("Opps!", error.toString(), mtRed600, mtGrey50);
    }
  }

  // ================================================
  // MENU

  getDataCategory() async {
    await _fetchDataCategoryMenu();
    // log.d(categoryMenuList.toJson());
    option = categoryMenuList.elementAt(1).id.toString();
    changePaginationMenuFilter(page.value, size.value, search.value, option!);
    // log.d(menuFilter.toJson());
    sc.value.addListener(() {
      // // log.d(sc.value.position.pixels);
      // // log.d(sc.value.position.maxScrollExtent);
      // // log.d(loading);
      if (sc.value.position.pixels >= sc.value.position.maxScrollExtent &&
          loading.isFalse) {
        getDataMenu();
      }
    });
  }

  changePaginationMenuFilter(int page, int size, String search, String option) {
    menuFilter.update((val) {
      val?.page = page;
      val?.size = size;
      val?.search = search;
      val?.option = option;
    });
  }

  refreshDataMenu() {
    page.value = 0;
    size.value = 7;
    listMenuProduct.clear();
    listMenuProduct.refresh();
    listMenuPackage.clear();
    listMenuPackage.refresh();
    allLoaded.value = false;
    option = selectedCategory.value.toString();
    changePaginationMenuFilter(page.value, size.value, search.value, option!);
    // log.d(menuFilter.toJson());
    getDataMenu();
  }

  clearValueSearch() {
    textFieldController.value.clear();
    textFieldController.value.text = "";
    search.value = "";
    page.value = page.value;
    size.value = size.value;
    refreshDataMenu();
  }

  getDataMenu() {
    // // log.d(character.value.toString().split('.').last);
    if (character == TypeMenu.product) {
      // log.d('ini product');
      getDataMenuProd();
    } else {
      // log.d('ini paket');
      getDataMenuPackage();
    }
  }

  initDrowpDownPriceCategory() {
    priceWho.value = categoryPriceList.elementAt(0).name.toString();
    for (var item in categoryPriceList) {
      dDCategoryPrice.add(DropdownMenuItem<String>(
          child: Text(item.name.toString()), value: item.name));
    }
    dDCategoryPrice.refresh();
  }

  checkPrice(int idx) {
    List<Prices>? listPrice = character == TypeMenu.product
        ? listMenuProduct[idx].prices
        : listMenuPackage[idx].prices;
    Prices nullprice = Prices();
    nullprice.price = 0;
    nullprice.priceCategory = null;
    var priceData = listPrice?.firstWhere(
        (prc) => prc.priceCategory == priceWho.value,
        orElse: () => nullprice);
    final currencyFormatter = NumberFormat('#,##0', 'ID');
    if (priceData!.price != 0 ||
        priceData.price != null && priceData.priceCategory != null) {
      return 'Rp ' + currencyFormatter.format(priceData.price);
    } else {
      return null;
    }
  }

  checkStock(int idx) {
    List<ProductsPackage>? lsprod = listMenuPackage[idx].products;
    for (var item in lsprod!) {
      if (item.quantity == 0) return false;
    }
    return true;
  }

  convertPrice(int? price) {
    if (price != null) {
      final currencyFormatter = NumberFormat('#,##0', 'ID');
      return 'Rp ' + currencyFormatter.format(price);
    } else {
      return 'Rp -';
    }
  }

  String checkGrandTotalPrice() {
    // log.d(cartList.toJson());
    // log.d(cartList.isNotEmpty);
    var sum = 0;
    if (cartList.isNotEmpty) {
      for (var item in cartList.value) {
        // log.d(item.toJson());
        sum += item.totalPrice!;
      }
    }
    return convertPrice(sum);
  }

  // sumAnyQuantityProd() {
  //   // if (cartList.isNotEmpty) {
  //   //   cartList.
  //   // }
  //   var stokId = <int>[];
  //   var product = <ProductsPackage>[];
  //   var stock = []
  //   for (var item in listMenuPackage.value) {
  //     stokId = item.stockIds!;
  //     product = item.products!;
  //   }

  // }

  createOrder() {
    if (formKey.currentState!.validate()) {
      selectedTableActive.value.capacity = optionTable == 2
          ? int.parse(textFieldCapacityController.value.text)
          : null;

      createOrderRes.value = CreateOrderResponse();
      createOrderRes.refresh();
      createOrderRes.value.branchId = branchId;
      createOrderRes.value.subBranchId = subBranchId;
      createOrderRes.value.name = textFieldNameController.value.text.toString();
      createOrderRes.value.note = textFieldNoteController.value.text.toString();

      // log.d(selectedTableActive.value.toJson());
      // log.d(createOrderRes.value.toJson());
      tabController.index = 1;
    }
  }

  clearTextController() {
    textFieldCapacityController.value.clear();
    textFieldNameController.value.clear();
    textFieldNoteController.value.clear();
  }

  clearCreateOrder() {
    selectedTableActive.value = ListTable();
    cartList.value = <Cart>[];
    createOrderRes.value = CreateOrderResponse();
  }

  insertToCartForProduct(int index) {
    // // log.d(listMenuProduct[index].toJson());
    var ct = Cart();
    ct.id = 0;
    ct.tempSalesId = 0;
    ct.menuId = listMenuProduct[index].id;
    ct.name = listMenuProduct[index].name;
    ct.amount = 1;
    ct.unit = listMenuProduct[index].unit;
    ct.isPackage = false;
    ct.stockId = listMenuProduct[index].stockId;
    ct.pic = listMenuProduct[index].pic ?? "No Pic";

    ListPriceCategories priceCategory = categoryPriceList
        .firstWhere((element) => element.name == priceWho.value);
    ct.priceCatId = priceCategory.id;
    ct.priceCat = priceCategory.name;

    // log.d(priceCategory.toJson());
    for (var item in listMenuProduct[index].prices!) {
      // ignore: unrelated_type_equality_checks
      // // log.d(item.priceCategory);
      // // log.d(item.priceCategory);
      if (item.priceCategory == priceWho.value) {
        ct.unitPrice = item.price;
        ct.totalPrice = item.price! * 1;
      }
    }
    // log.d(ct.toJson());

    if (!cartList.value
        .any((e) => e.menuId == listMenuProduct.value[index].id)) {
      cartList.value.add(ct);
      cartList.refresh();
      tabController.index = 2;

      for (var item in cartList) {
        // log.d(item.toJson());
      }
    } else {
      Snackbar.show("Opps!", "Menu sudah ada dikeranjang", mtRed600, mtGrey50);
    }
  }

  insertToCartForPackage(int index) {
    // // log.d(listMenuPackage[index].toJson());

    var ct = Cart();
    ct.id = 0;
    ct.tempSalesId = 0;
    ct.menuId = listMenuPackage[index].id;
    ct.name = listMenuPackage[index].name;
    ct.amount = 1;
    ct.unit = "package";
    ct.isPackage = true;
    ct.stockIds = listMenuPackage[index].stockIds;
    ct.pic = listMenuPackage[index].pic ?? "No Pic";

    ListPriceCategories priceCategory = categoryPriceList
        .firstWhere((element) => element.name == priceWho.value);
    ct.priceCatId = priceCategory.id;
    ct.priceCat = priceCategory.name;
    for (var item in listMenuPackage[index].prices!) {
      // ignore: unrelated_type_equality_checks
      // // log.d(item.priceCategory);
      // // log.d(item.priceCategory);
      if (item.priceCategory == priceWho.value) {
        ct.unitPrice = item.price;
        ct.totalPrice = item.price! * 1;
      }
    }
    // log.d(ct.toJson());

    if (!cartList.value
        .any((e) => e.menuId == listMenuPackage.value[index].id)) {
      cartList.value.add(ct);
      cartList.refresh();
      tabController.index = 2;
      // // log.d(listItem.toJson());
    } else {
      Snackbar.show("Opps!", "Menu sudah ada dikeranjang", mtRed600, mtGrey50);
    }
  }

  listPackageproduct(int idx) {
    List<ProductsPackage>? ls = listMenuPackage[idx].products;
    var nameproduct = [];
    for (var item in ls!) {
      // log.d(item.name);
      nameproduct.add(item.name);
    }
    return nameproduct.join(" ").trim();
  }

  getDataMenuProd() async {
    changePaginationMenuFilter(page.value, size.value, search.value, option!);
    loading.value = true;
    if (allLoaded.isTrue) {
      loading.value = false;
      loading.refresh();
      return;
    }
    await _fetchMenu();
  }

  getDataMenuPackage() async {
    changePaginationMenuFilter(page.value, size.value, search.value, option!);
    loading.value = true;
    if (allLoaded.isTrue) {
      loading.value = false;
      loading.refresh();
      return;
    }
    await _fetchPackage();
  }

  Future<void> _fetchDataCategoryMenu() async {
    try {
      CategoryMenuProduct ct = await OrderService.getCategoryMenu(100, 0);
      categoryMenuList.value = ct.categoryprodlist!;
      // ct.toJson();
      // categoryMenuList.refresh();
    } catch (error) {
      Snackbar.show("Opps!", error.toString(), mtRed600, mtGrey50);
    }
  }

  Future<void> _fetchDataCategoryPrice() async {
    try {
      PriceCategories cp = await OrderService.getCategoryPrice(100, 0);
      categoryPriceList.value = cp.listpricecategories!;
      initDrowpDownPriceCategory();
      // ct.toJson();
      // categoryMenuList.refresh();
    } catch (error) {
      Snackbar.show("Opps!", error.toString(), mtRed600, mtGrey50);
    }
  }

  Future<void> _fetchMenu() async {
    try {
      MenuProduct mp =
          await OrderService.getMenu(menuFilter.value, subBranchId);
      menuProduct.value = mp;
      // listMenuProduct.value = mp.menulist!;

      page.value = mp.pageable!.pageNumber! + 1;
      size.value = mp.pageable!.pageSize!;

      List<Menu> newData = listMenuProduct.value.length >=
              menuProduct.value.pageable!.totalElements!
          ? []
          : menuProduct.value.menulist!;
      // log.d(newData);
      if (newData.isNotEmpty) {
        for (var item in newData) {
          listMenuProduct.value.add(item);
        }
        listMenuProduct.refresh();
      }

      loading.value = false;
      loading.refresh();
      allLoaded.value = newData.isEmpty;

      mp.toJson();
      listMenuProduct.refresh();
    } catch (error) {
      Snackbar.show("Opps!", error.toString(), mtRed600, mtGrey50);
    }
  }

  Future<void> _fetchPackage() async {
    try {
      MenuPackage mp =
          await OrderService.getPackage(menuFilter.value, subBranchId);
      // listMenuPackage.value = mp.packagelist!;
      menuPackage.value = mp;

      page.value = mp.pageable!.pageNumber! + 1;
      size.value = mp.pageable!.pageSize!;

      List<Package> newData = listMenuPackage.value.length >=
              menuPackage.value.pageable!.totalElements!
          ? []
          : menuPackage.value.packagelist!;
      // log.d(newData);
      if (newData.isNotEmpty) {
        for (var item in newData) {
          listMenuPackage.value.add(item);
        }
        listMenuPackage.refresh();
      }

      loading.value = false;
      loading.refresh();
      allLoaded.value = newData.isEmpty;

      mp.toJson();
      listMenuPackage.refresh();
    } catch (error) {
      Snackbar.show("Opps!", error.toString(), mtRed600, mtGrey50);
    }
  }

  // ================================================
  // ================================================
  // PESANAN
  // ================================================

  plus(int index) {
    // log.d(index);
    var amount = cartList.elementAt(index).amount!;
    cartList.elementAt(index).amount = amount + 1;
    cartList.elementAt(index).totalPrice =
        cartList.elementAt(index).unitPrice! *
            cartList.elementAt(index).amount!;
    // log.d(cartList.elementAt(index).amount);
    cartList.refresh();
  }

  minus(int index) {
    // log.d(index);
    var amount = cartList.elementAt(index).amount!;
    // log.d(amount);
    if (amount == 1) {
      cartList.elementAt(index).amount = 1;
      cartList.elementAt(index).totalPrice =
          cartList.elementAt(index).unitPrice! *
              cartList.elementAt(index).amount!;
      cartList.refresh();
    } else {
      cartList.elementAt(index).amount = amount - 1;
      cartList.elementAt(index).totalPrice =
          cartList.elementAt(index).unitPrice! *
              cartList.elementAt(index).amount!;
      // log.d(cartList.elementAt(index).amount);
      cartList.refresh();
    }
  }

  generateBlankOrder() {
    createOrderRes.value.id = 0;
    createOrderRes.value.branchId = branchId;
    createOrderRes.value.subBranchId = subBranchId;
    createOrderRes.value.name = textFieldNameController.value.text;
    createOrderRes.value.note = textFieldNoteController.value.text;
  }

  saveOrder() async {
    createOrderRes.value.items = cartList;
    createOrderRes.value.shiftId = shift.value;
    // log.d(selectedTableActive.value.id);
    createOrderRes.value.tableIds = selectedTableActive.value.id != null
        ? [selectedTableActive.value.id!]
        : [];

    // log.d(selectedTableActive.toJson());
    // log.d(createOrderRes.toJson());
    createOrderRes.value =
        await OrderService.createOrderRequest(createOrderRes.value);

    cartList.value = <Cart>[];
    cartList.refresh();
    cartList.addAll(createOrderRes.value.items!);
    cartList.refresh();

    selectedTableActive.value.isOccupied = true;
    selectedTableActive.value.salesId = createOrderRes.value.id;
    if (optionTable.value == 2) {
      makeUpdateTable();
      setTrigger();
    } else {
      refreshDataAllOrder();
      clearCreateOrder();
      generateDate();
      duration.value = 5000;
      duration.refresh();
      getAllOrder();
      tabController.index = 0;
      setTrigger();
    }
  }

  updateOrder() async {
    isLoading.value = true;
    createOrderRes.value.items = <Cart>[];
    createOrderRes.value.shiftId = shift.value;
    createOrderRes.value.items = cartList;
    // log.d(selectedTableActive.value.id);
    // createOrderRes.value.tableIds = [selectedTableActive.value.id!];

    // log.d(selectedTableActive.toJson());
    // log.d(createOrderRes.toJson());
    createOrderRes.value =
        await OrderService.updateOrderRequest(createOrderRes.value);

    cartList.value = <Cart>[];
    cartList.refresh();
    cartList.addAll(createOrderRes.value.items!);
    // for (var item in createOrderRes.value.items!) {
    //   cartList.add(insertBackCartAfterSave(item));
    // }
    cartList.refresh();
    // log.d(cartList.toJson());

    selectedTableActive.value.isOccupied = true;
    selectedTableActive.value.salesId = createOrderRes.value.id;
    isLoading.value = false;
    refreshDataAllOrder();
    checkOptionType();
    setTrigger();
    // makeUpdateTable();
  }

  converDateMillisToString(int millis) {
    var dt = DateTime.fromMillisecondsSinceEpoch(millis);
    return DateFormat('dd MMMM yyyy, HH:mm').format(dt).toString();
  }

  cancelOrder() async {
    if (formKey2.currentState!.validate()) {
      await OrderService.cancelOrderTemps(
              createOrderRes.value.id!, textFieldWhyController.value.text)
          .then((value) =>
              value ? checkCancelFrom(createOrderRes.value.id!) : null);
    }
  }

  checkCancelFrom(int salesId) async {
    if (optionTable.value == 2) {
      makeUpdateCancelTable(createOrderRes.value.id!);
    } else {
      await getAllOrder();
      tabController.index = 0;
    }
  }

  makeUpdateCancelTable(int salesId) async {
    // log.d(selectedTableActive.value);
    var table = UpdateTableO();
    table.id = selectedTableActive.value.id;
    table.isOccupied = false;
    table.salesId = salesId;
    // log.d(table.toJson());
    OrderService.updateTableOcc(table)
        .then((value) => value ? clearValueOrder() : null);
  }

  clearValueOrder() {
    selectedTableActive.value = ListTable();
    cartList.clear();
    cartList.refresh();
    createOrderRes.value = CreateOrderResponse();
    createOrderRes.refresh();
    tabController.index = 0;
    checkOptionType();
  }

  makeUpdateTable() async {
    // log.d(selectedTableActive.value);
    var table = UpdateTableO();
    table.id = selectedTableActive.value.id;
    table.isOccupied = selectedTableActive.value.isOccupied;
    table.salesId = selectedTableActive.value.salesId;
    table.capacity = selectedTableActive.value.capacity;
    OrderService.updateTableOcc(table)
        .then((value) => value ? refreshTable() : null);
    // selectedTableActive.value = ListTable();
    // cartList.value = <Cart>[];
    // createTempSales.value = CreateTempSales();
    // createOrderRes.value = CreateOrderResponse();
  }

  // printData(int index) {
  //   log.d(orderList.elementAt(index).toJson());
  //   printer
  // }

  checkDineInOrNot(List<int> table) {
    // log.d(table.toList());
    if (table.isEmpty) {
      return "Take Away";
    }
    return "Dine In";
  }

  printData(int index) async {
    CreateOrderResponse order = orderList.elementAt(index);
    List<Cart> ctList = order.items!;
    String totalPrice = printGrandTotalPrice(ctList);
    String table = checkTable(order.tableIds!);
    String tipe = checkDineInOrNot(order.tableIds!);

    // selectedTableActive.value.
    // log.d(await printer.isConnected);
    if ((await printer.isConnected)!) {
      printer.printNewLine();
      // Size
      // 0: Normal
      // 1: Normal - Bold
      // 2: Medium - Bold
      // 3: Large - Bold

      // ALIGN
      // 0: left
      // 1: center
      // 2: right

      // HEAD PRINT
      printer.printCustom("RM Siang Malam", 2, 1);
      printer.printCustom("Induk Jakarta", 0, 1);
      printer.printNewLine();
      printer.printLeftRight(
          "${table}", "No. ${order.id.toString().substring(0, 6)}xxxxx", 1);
      printer.printLeftRight("${converDateMillisToDate(order.createdAt!)}",
          "${converDateMillisToTime(order.createdAt!)}", 1);
      printer.printLeftRight("${order.name}", "${tipe}", 1);
      printer.printNewLine();
      // printer.printCustom("============================", 0, 1);
      // printer.printCustom(
      //     "${order.note == '' ? order.note : 'Tidak ada catatan'}", 0, 1);
      // printer.printCustom("============================", 0, 1);
      // printer.printNewLine();
      // BODY ITEM PRINT
      for (var item in ctList) {
        printer.printCustom("${item.name}", 0, 0);
        printer.printLeftRight(
            "x${item.amount}", "${convertPrice(item.unitPrice)}", 0);
        printer.printCustom(
            "${convertPrice(item.unitPrice! * item.amount!)}", 1, 2);
      }
      // BODY TOTAL
      printer.printNewLine();
      printer.printCustom("============Total============", 0, 1);
      printer.printLeftRight("${ctList.length} Item", "${totalPrice}", 1);
      // FOOTER INFO
      printer.printCustom("============================", 0, 1);
      printer.printCustom("Harga belum termasuk", 0, 1);
      printer.printCustom("Pajak, dll.", 0, 1);
      printer.printCustom("Bawa struk ke kasir", 0, 1);
      printer.printCustom("untuk pembayaran", 0, 1);
      printer.printCustom("============================", 0, 1);
      printer.printNewLine();
      // FOOTER QR CODE
      printer.printQRcode("${order.id}", 250, 250, 1);
      // FOOTER PAPPER CUT
      printer.printNewLine();
      printer.paperCut();
    } else {
      Snackbar.show("Opps", "Device Tidak Terkoneksi!", mtRed600, mtGrey50);
    }
  }

  converDateMillisToDate(int millis) {
    var dt = DateTime.fromMillisecondsSinceEpoch(millis);
    return DateFormat('dd MMMM yyyy').format(dt).toString();
  }

  converDateMillisToTime(int millis) {
    var dt = DateTime.fromMillisecondsSinceEpoch(millis);
    return DateFormat('HH:mm:ss').format(dt).toString();
  }

  String printGrandTotalPrice(List<Cart> ct) {
    var sum = 0;
    if (ct.isNotEmpty) {
      for (var item in ct) {
        // log.d(item.toJson());
        sum += item.totalPrice!;
      }
    }
    return convertPrice(sum);
  }

  @override
  void onClose() {
    Orientations.defaultOrientation();
    tabController.dispose();
    super.onClose();
  }
}
