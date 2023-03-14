import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
// import 'package:logger/logger.dart';
import 'package:siangmalam/commons/controllers/cashier/cashier_controller.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/option_value.dart';
import 'package:siangmalam/models/cashier/checkout.dart';
import 'package:siangmalam/models/cashier/mergenill.dart';
import 'package:siangmalam/models/cashier/payment.dart';
import 'package:siangmalam/models/cashier/response_checkout.dart';
import 'package:siangmalam/models/cashier/shift.dart';
import 'package:siangmalam/models/customer/customer.dart';
import 'package:siangmalam/models/discount/discount.dart';
import 'package:siangmalam/models/discount/discounts.dart';
import 'package:siangmalam/models/discount/request/request_discount.dart';
import 'package:siangmalam/models/order/all-order-response.dart';
import 'package:siangmalam/models/order/create-order-response.dart';
import 'package:siangmalam/models/order/get-order.dart';
import 'package:siangmalam/models/order/table-filter.dart';
import 'package:siangmalam/models/order/table.dart';
// import 'package:siangmalam/models/order/upsert-table.dart';
import 'package:siangmalam/models/tax/general_value.dart';
import 'package:siangmalam/models/user.dart';
import 'package:siangmalam/services/app_static.dart';
import 'package:siangmalam/services/cashier/cashier_service.dart';
import 'package:siangmalam/services/cashier/general_service.dart';
import 'package:siangmalam/services/cashier/payment_service.dart';
import 'package:siangmalam/services/customer/customer_service.dart';
import 'package:siangmalam/services/discount/discount_service.dart';
import 'package:siangmalam/services/order/order_service.dart';
import 'package:siangmalam/services/printer_service.dart';
import 'package:siangmalam/services/user/user_service.dart';
import 'package:siangmalam/widgets/snack_bar.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

class OrderListController extends GetxController with GetTickerProviderStateMixin {
  CashierController cashierController = Get.find();
  // ================================================
  // MAIN
  // ================================================
  // var log = Logger();
  late int? branchId;
  int? subBranchId;
  var level = AppStatic.userData.level;
  // ALL CONTROLLER

  var scrollControllerOrderList = ScrollController().obs;
  final searchController = TextEditingController().obs;
  final formKeyMerge = GlobalKey<FormState>();
  var tfNameController = TextEditingController().obs;
  var tfNoteController = TextEditingController().obs;

  // SHIFT
  // =================================
  var shiftData$ = ShiftObj().obs;
  var checkShift$ = CheckShift().obs;

  // ================================================
  // REQ ORDER FILTER
  // ================================================
  int? startDate;
  int? endDate;
  var sizePageOrder = 20.obs;
  var pagePageOrder = 0.obs;
  var searchPageOrder = ''.obs;
  var optionTypeSearch = 'salesId'.obs;

  // VARIABLE START

  // MODEL
  var reqOrder = GetOrder().obs;
  var allOrder = AllOrderRes().obs;
  var orderList = <CreateOrderResponse>[].obs;
  // DATA LIST ACTIVE
  var order = CreateOrderResponse().obs;
  var cartItem = <Cart>[].obs;
  var checkOut = Checkout().obs;
  // MERGE
  var mergeBill = MergeBill().obs;
  // PAYMEN CUST
  var paymentCustList = <PaymentCustom>[].obs;
  var filterPaymencCust = GetPaymentCust().obs;
  var selectedPaymentCust = PaymentCustom().obs;

  // Temporary Data
  var discountCharge = "".obs;
  var serviceCharge = "".obs;
  var taxCharge = "".obs;

  var discountType$ = "ALL".obs;
  var discount$ = 0.0.obs;
  var service$ = 0.obs;
  var tax$ = 0.obs;

  // TABLE
  var filterTable = TableFilter().obs;
  var listTable = <ListTable>[].obs;

  // GET DATA
  int? get _pageOrder => reqOrder.value.page;

  //  PAGE
  var loadingPageOrder = false.obs;
  var allLoadedPageOrder = false.obs;
  var isMerge = false.obs;

  // TEXTFIELD

  // DROPDOWN
  List<DropdownMenuItem<String>> dOptSearch = typeFindOrder;
  var dropdownCustList = <DropdownMenuItem<ListCustomer>>[].obs;

  get indexPage => null;

  // ================================================
  // Discount Tax Service
  // ================================================
  var discountList = Discounts().obs;
  var discountFilter = GetDiscountsAll().obs;
  var generalValue = GeneralValue().obs;
  var generalFilter = GeneralFilter().obs;

  // ================================================
  // Payment
  // ================================================
  var pagePayment = 1.obs;
  late AnimationController animationController;

  var tfCardNo = TextEditingController().obs;
  var tfCardName = TextEditingController().obs;
  var tfBatchNo = TextEditingController().obs;
  var tfTransactionNumber = TextEditingController().obs;
  var tfMerchantId = TextEditingController().obs;

  var selectedPanding = 1.obs;
  var custList = <ListCustomer>[].obs;
  var selectedCust = ListCustomer().obs;

  var userDto = UserDto().obs;
  var userIdController = TextEditingController().obs;

  @override
  void onInit() async {
    // log.d("on init order list");
    super.onInit();
    branchId = cashierController.branchId;
    subBranchId = cashierController.subBranchId;
    // startDate = DateTime.now()
    //     .subtract(const Duration(days: 2, hours: 0, minutes: 00, seconds: 00))
    //     .millisecondsSinceEpoch;
    // endDate = DateTime.now().millisecondsSinceEpoch;
    // log.d(DateTime.now().millisecondsSinceEpoch);
    animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animationController.repeat(reverse: true);
    mergeBill.value.bills = [];
    // log.d(shiftData$.toJson());
    await checkShiftData();
    await getAllOrderList();
    await getDataTable();
    await getDataDiscount();
    await getGeneralValue();
    await getPaymentCustomer();
    await getCustomer();

    scrollControllerOrderList.value.addListener(() {
      // // log.d(scrollController.value.position.maxScrollExtent);
      if (scrollControllerOrderList.value.position.pixels >= scrollControllerOrderList.value.position.maxScrollExtent && loadingPageOrder.isFalse) {
        // log.d("work");
        getAllOrderList();
      }
    });
  }

  // Update DateTime
  updateDate() {
    startDate = DateTime.now().subtract(const Duration(days: 2, hours: 0, minutes: 00, seconds: 00)).millisecondsSinceEpoch;
    endDate = DateTime.now().millisecondsSinceEpoch;
  }

  // Get All Order List
  getAllOrderList() async {
    updateDate();
    updatePageFilterOrderList(
        pagePageOrder.value, sizePageOrder.value, searchPageOrder.value, optionTypeSearch.value, branchId, subBranchId, startDate, endDate);
    loadingPageOrder.value = true;
    if (allLoadedPageOrder.isTrue) {
      loadingPageOrder.value = false;
      loadingPageOrder.refresh();
      return;
    }
    await fetchAllorder();
  }

  // Get All Discount
  getDataDiscount() async {
    discountFilter.update((val) {
      val?.search = "";
      val?.sortBy = "asc";
      val?.size = 100;
      val?.page = 0;
    });
    await fetchDiscount();
  }

  // Get All General Value
  getGeneralValue() async {
    generalFilter.update((val) {
      val?.search = "";
      val?.size = 100;
      val?.page = 0;
      val?.type = "ALL";
    });
    await fetchGeneralVal();
  }

  // Get All Paymenc Customer
  getPaymentCustomer() async {
    updatePageFilterPaymentCus(50, 0, "", "ALL", "accountNo");
    await fetchDataPaymentCust();
  }

  // get customer
  getCustomer() async {
    Customer cust = await CustomerService.getCustomerAll();
    custList.value = cust.listcustomer ?? <ListCustomer>[];
    initDropdownCustlist();
  }

  initDropdownCustlist() {
    dropdownCustList.clear();
    dropdownCustList.add(const DropdownMenuItem<ListCustomer>(child: Text("Tanpa Pelanggan"), value: null));
    for (var item in custList) {
      dropdownCustList.add(DropdownMenuItem<ListCustomer>(child: Text(item.name.toString()), value: item));
    }
  }

  // Refresh Order List Data
  refreshOrderList() {
    allOrder.refresh();
    orderList.refresh();
  }

// Refresh ALL OF ORDER lIST
  refreshDataAllOrder() {
    allOrder.value = AllOrderRes();
    orderList.clear();
    order.value = CreateOrderResponse();
    cartItem.clear();
    allLoadedPageOrder.value = false;
    checkOut.value = Checkout();
    searchController.value.clear();
    searchController.refresh();
    sizePageOrder.value = 20;
    pagePageOrder.value = 0;
    searchPageOrder.value = '';

    deleteDiscount();
    deleteService();
    deleteTax();

    tfCardNo.value.clear();
    tfCardName.value.clear();
    tfBatchNo.value.clear();
    tfTransactionNumber.value.clear();
    tfMerchantId.value.clear();

    selectedCust.value = ListCustomer();
    userDto.value = UserDto();
  }

  // Get Data Table
  getDataTable() async {
    changePaginationTableFilter(0, 100, searchPageOrder.value, AppStatic.userData.branchId!, subBranchId);
    fetchDataTabel();
  }

  // Cek Shift
  checkShiftData() async {
    await updateCheck(branchId, subBranchId);
    await fetchCheckShift();
    // log.d(shiftData$.toJson());
  }

  updateCheck(int? branchId, int? subBranchId) {
    checkShift$.update((val) {
      val?.branchId = branchId;
      val?.subBranchId = subBranchId;
    });
  }

  // Update Page Filter Order List
  updatePageFilterOrderList(int page, int size, String search, String option, int? branchId, int? subBranchId, int? startDate, int? endDate) {
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

  // update payment cust
  updatePageFilterPaymentCus(int size, int page, String search, String type, String option) {
    filterPaymencCust.update((val) {
      val?.size = size;
      val?.page = page;
      val?.search = search;
      val?.type = type;
      val?.option = option;
    });
  }

  // Update Table Filter
  changePaginationTableFilter(int page, int size, String search, int branchId, int? subBranchId) {
    filterTable.update((val) {
      val?.page = page;
      val?.size = size;
      val?.search = search;
      val?.branchId = branchId;
      val?.subBranchId = subBranchId;
    });
  }

  // All Function
  converDateMillisToString(int millis) {
    var dt = DateTime.fromMillisecondsSinceEpoch(millis);
    return DateFormat('dd MMMM yyyy, HH:mm').format(dt).toString();
  }

  // ON CHOOSE ORDER
  seeOrderList(int index) {
    order.value = CreateOrderResponse();
    cartItem.clear();
    cartItem.refresh();
    order.refresh();
    order.value = orderList.elementAt(index);
    cartItem.value.addAll(order.value.items!);
    updateCheckOut(order.value);
    calculateCheckOut();

    tfCardNo.value.clear();
    tfCardName.value.clear();
    tfBatchNo.value.clear();
    tfTransactionNumber.value.clear();
    tfMerchantId.value.clear();

    selectedCust.value = ListCustomer();
    userDto.value = UserDto();
  }

  searchOrderList() async {
    allOrder.value = AllOrderRes();
    orderList.clear();
    order.value = CreateOrderResponse();
    cartItem.clear();
    allLoadedPageOrder.value = false;
    checkOut.value = Checkout();

    sizePageOrder.value = 20;
    pagePageOrder.value = 0;
    searchPageOrder.value = searchController.value.text.toString();
    await getAllOrderList();
  }

  // SET CHECK OUT TEMPORARY
  // setCheckOut(CreateOrderResponse order) {
  //   checkOut.value.tempSalesId = order.id;
  //   updateCheckOut()
  // }

  updateCheckOut(CreateOrderResponse order) {
    checkOut.update((val) {
      val?.tempSalesId = order.id;
      val?.name = order.name;
      val?.tableIds = order.tableIds;
      val?.note = order.note;
      val?.cashierUserName = AppStatic.userData.username;
      val?.cashierName = "${AppStatic.userData.firstName} ${AppStatic.userData.lastName}";
      val?.waiterName = order.waiter;
      val?.waiterUserName = order.waiter;
      val?.customerId = null;
      val?.customerName = "";
      val?.subTotal = checkTotalEveryListCheckOut(order.items);
      val?.discount = 0;
      val?.tax = 0;
      val?.service = 0;
      val?.total = 0;
      val?.paymentMethod = null;
      val?.paymentTypeId = null;
      val?.cash = 0;
      val?.change = 0;
      val?.status = null;
      var table = order.tableIds ?? [];
      val?.isDineIn = table.isNotEmpty ? true : false;
      val?.shiftId = shiftData$.value.id;
      val?.cardName = null;
      val?.cardNo = null;
      val?.transactionNo = null;
      val?.batchNo = null;
      val?.merchantId = null;
      val?.image = null;
    });
  }

  bool? validateName(String value) {
    if (value.isNotEmpty) {
      return true;
    }
    return false;
  }

  // CHECK SUB TOTAL
  checkTotalEveryListCheckOut(List<Cart>? cart) {
    var sum = 0;
    if (cart!.isNotEmpty) {
      for (var item in cart) {
        // log.d(item.toJson());
        sum += item.totalPrice!;
      }
    }
    return sum;
  }

  checkTable(List<int> table) {
    // log.d(table.toList());
    if (table.isEmpty) {
      return "-";
    }
    ListTable lt = listTable.firstWhere((p0) => p0.id == table.elementAt(0), orElse: () => ListTable());
    // log.d(lt.name.toString());
    return lt.name;
  }

  checkTotalEveryList(List<Cart>? cart) {
    var sum = 0;
    if (cart!.isNotEmpty) {
      for (var item in cart) {
        // log.d(item.toJson());
        sum += item.totalPrice!;
      }
    }
    return convertPrice(sum);
    // controller.orderList.elementAt(index).items
  }

  convertPrice(int? price) {
    if (price != null) {
      final currencyFormatter = NumberFormat('#,##0', 'ID');
      return 'Rp ' + currencyFormatter.format(price);
    } else {
      return 'Rp -';
    }
  }

  insertMergeBill(int id) {
    // log.d(id);
    if (!mergeBill.value.bills!.any((e) => e == id)) {
      mergeBill.value.bills!.add(id);
      mergeBill.refresh();
    } else {
      mergeBill.value.bills!.remove(id);
      mergeBill.refresh();
      // Get.snackbar("Oops", "Orderan tidak boleh duplikat");
    }
  }

  getColorChangeMerge(id) {
    if (mergeBill.value.bills!.any((e) => e == id)) {
      return primaryDarkGreen;
    } else {
      return Colors.transparent;
    }
  }

  getColorTextChangeMerge(id) {
    if (mergeBill.value.bills!.any((e) => e == id)) {
      return Colors.white;
    } else {
      return const Color(0xFF494949);
    }
  }

  CreateOrderResponse getCartMergeData(int id) {
    return orderList.firstWhere((e) => e.id == id);
  }

  refreshMergeBill() {
    mergeBill.value = MergeBill();
    mergeBill.value.bills = [];
    mergeBill.refresh();

    order.value = CreateOrderResponse();
    cartItem.clear();
    cartItem.refresh();
    order.refresh();

    checkOut.value = Checkout();
    checkOut.refresh();
  }

  calculateCheckOut() {
    if (discountType$ == "PERCENT") {
      checkOut.value.discount = (checkOut.value.subTotal!.toDouble() * (discount$.value / 100)).toInt();
      checkOut.value.service = ((checkOut.value.subTotal! - checkOut.value.discount!) * (service$.value / 100)).toInt();
      checkOut.value.tax = (((checkOut.value.subTotal! - checkOut.value.discount!) + checkOut.value.service!) * (tax$.value / 100)).toInt();
      checkOut.value.total = ((checkOut.value.subTotal! - checkOut.value.discount!) + checkOut.value.service! + checkOut.value.tax!);
      reCheckPaymentCash();
    } else if (discountType$ == "RUPIAH") {
      checkOut.value.discount = discount$.value.toInt();
      checkOut.value.service = ((checkOut.value.subTotal! - checkOut.value.discount!) * (service$.value / 100)).toInt();
      checkOut.value.tax = (((checkOut.value.subTotal! - checkOut.value.discount!) + checkOut.value.service!) * (tax$.value / 100)).toInt();
      checkOut.value.total = ((checkOut.value.subTotal! - checkOut.value.discount!) + checkOut.value.service! + checkOut.value.tax!);
      reCheckPaymentCash();
    } else {
      int discount = checkOut.value.discount ?? 0;
      int subtotal = checkOut.value.subTotal ?? 0;
      checkOut.value.discount = (discount * (discount$.value.toInt() / 100)).toInt();
      checkOut.value.service = ((subtotal - discount) * (service$.value / 100)).toInt();

      int service = checkOut.value.service ?? 0;
      int discount2 = checkOut.value.discount ?? 0;
      checkOut.value.tax = (((subtotal - discount2) + service) * (tax$.value / 100)).toInt();

      int tax = checkOut.value.tax ?? 0;
      checkOut.value.total = ((subtotal - discount2) + service + tax);

      // log.d(checkOut.toJson());

      reCheckPaymentCash();
    }
  }

  chooseDiscount(int index) async {
    // log.d(discountList.value.listdiscount!.elementAt(index).toJson());
    ListDiscount disc = discountList.value.listdiscount!.elementAt(index);
    switch (disc.type) {
      case "PERCENT":
        discountType$.value = disc.type!;
        discount$.value = disc.value!;
        calculateCheckOut();
        discountCharge.value = "${disc.value}%";
        discountCharge.refresh();
        break;
      case "RUPIAH":
        discountType$.value = disc.type!;
        discount$.value = disc.value!;
        calculateCheckOut();
        discountCharge.value = "";
        discountCharge.refresh();
        break;
      default:
    }
  }

  chooseFee(GeneralValueList value) async {
    // log.d(value.toJson());
    GeneralValueList serv = value;
    var totalwithDisc = checkOut.value.subTotal! - checkOut.value.discount!;
    if (serv.type == "FEE") {
      service$.value = int.parse(serv.value!);
      calculateCheckOut();
      serviceCharge.value = "${serv.value}%";
      serviceCharge.refresh();
    }
  }

  chooseTax(int index) async {
    // log.d(generalValue.value.valueList!.elementAt(index).toJson());
    GeneralValueList tax = generalValue.value.valueList!.elementAt(index);
    if (tax.type == "TAX") {
      tax$.value = int.parse(tax.value!);
      calculateCheckOut();
      taxCharge.value = "${tax.value}%";
      taxCharge.refresh();
    }
  }

  deleteDiscount() async {
    discountType$.value = "ALL";
    discount$.value = 0.0;
    discountType$.refresh();
    discount$.refresh();
    checkOut.value.discount = 0;
    checkOut.refresh();
    discountCharge.value = "";
    discountCharge.refresh();
    calculateCheckOut();
  }

  deleteTax() async {
    tax$.value = 0;
    tax$.refresh();
    checkOut.value.tax = 0;
    checkOut.refresh();
    taxCharge.value = "";
    taxCharge.refresh();
    calculateCheckOut();
  }

  deleteService() async {
    service$.value = 0;
    service$.refresh();
    checkOut.value.service = 0;
    checkOut.refresh();
    serviceCharge.value = "";
    serviceCharge.refresh();
    calculateCheckOut();
  }

  submitMerge() async {
    if (validateName(tfNameController.value.text)!) {
      mergeBill.value.name = tfNameController.value.text;
      mergeBill.value.note = tfNoteController.value.text;
      // log.d(mergeBill.toJson());
      if (mergeBill.value.bills!.length > 1) {
        bool val = await CashierService.mergeBillService(mergeBill.value);
        if (val) {
          Snackbar.show("Success", "Pemisahan pesanan berhasil", primaryGreen, textColor);
          isMerge.value = false;
          refreshMergeBill();
          refreshDataAllOrder();
          getAllOrderList();
          refresh();
        } else {
          Snackbar.show("Gagal", "Oops ada yang salah", mtRed600, mtGrey50);
        }
      } else {
        Snackbar.show("Gagal", "Orderan harus lebih dari 1", mtRed600, mtGrey50);
      }
    } else {
      Snackbar.show("Gabung Bill", "Oops, Nama tidak boleh kosong", mtRed600, mtGrey50);
    }
  }

  reCheckPaymentCash() {
    int cash = checkOut.value.cash ?? 0;
    int total = checkOut.value.total ?? 0;
    checkOut.value.change = (cash - total);
    checkOut.refresh();
  }

  changePagePayment(int i) {
    pagePayment.value = i;
    pagePayment.refresh();
  }

  inputAutomatically(int value) {
    // log.d(value);
    checkOut.value.cash = (checkOut.value.cash! + value);
    checkOut.value.change = (checkOut.value.cash! - checkOut.value.total!);
    checkOut.refresh();
  }

  inputManually(int value) {
    // log.d(value);
    if (checkOut.value.cash! == 0) {
      checkOut.value.cash = value;
      checkOut.value.change = (checkOut.value.cash! - checkOut.value.total!);
      checkOut.refresh();
    } else {
      String strAdd = "" + checkOut.value.cash!.toString() + value.toString();
      checkOut.value.cash = int.parse(strAdd);
      checkOut.value.change = (checkOut.value.cash! - checkOut.value.total!);
      checkOut.refresh();
    }
  }

  backSpace() {
    checkOut.value.cash = removeLastCharacter(checkOut.value.cash!);
    // log.d(checkOut.value.cash);
    if (checkOut.value.cash == 0) {
      checkOut.value.change = 0;
    } else {
      checkOut.value.change = (checkOut.value.cash! - checkOut.value.total!);
    }
    checkOut.refresh();
  }

  static int removeLastCharacter(int val) {
    String str = val.toString();
    if (str.length == 1) {
      return 0;
    }
    return int.parse(str.substring(0, str.length - 1));
  }

  clearSpace() {
    // log.d("ClearSpace");
    checkOut.value.cash = 0;
    checkOut.value.change = 0;
    checkOut.refresh();
  }

  checkEstimateCash() {
    int endCash = shiftData$.value.endCash ?? 0;
    int change = checkOut.value.change ?? 0;
    int cash = checkOut.value.cash ?? 0;
    return (endCash + cash) - change;
  }

  isCheckOut() {
    int cash = checkOut.value.cash ?? 0;
    int total = checkOut.value.total ?? 0;
    if (cash >= total) {
      return true;
    } else {
      return false;
    }
  }

  checkOutCash() async {
    checkOut.value.paymentMethod = "CASH";
    checkOut.value.status = "PAID";
    // log.d(checkOut.toJson());
    ResponseCheckout result = await PaymentService.payment(checkOut.value);
    if (result.id != null) {
      printCashCheckOut(result);
    } else {
      await fetchCheckShift();
      refreshDataAllOrder();
      getAllOrderList();
    }
  }

  printCustomCheckOut(ResponseCheckout result) async {
    PrinterService printServ = PrinterService();
    await printServ.printCheckoutCust(result, selectedPaymentCust.value);
    await fetchCheckShift();
    refreshDataAllOrder();
    getAllOrderList();
  }

  printCashCheckOut(ResponseCheckout result) async {
    PrinterService printServ = PrinterService();
    await printServ.printCheckout(result);
    await fetchCheckShift();
    refreshDataAllOrder();
    getAllOrderList();
  }

  saveImageProof(String imagePath, String imageName) async {
    File imagefile = File(imagePath); //convert Path to File
    Uint8List imagebytes = await imagefile.readAsBytes(); //convert to bytes
    String base64string = base64.encode(imagebytes); //convert bytes to base64 string
    checkOut.value.image = base64string;
    checkOut.refresh();
  }

  getRecentlyUploaded() {
    if (checkOut.value.image != "") {
      var img = checkOut.value.image ?? "";
      Uint8List decodedbytes = base64.decode(img);
      return decodedbytes;
    }
  }

  checkOutCardDebit() async {
    checkOut.value.paymentMethod = "CUSTOM";
    checkOut.value.status = "PAID";
    checkOut.value.change = 0;
    checkOut.value.adminFee = selectedPaymentCust.value.adminFee;
    checkOut.value.paymentTypeId = selectedPaymentCust.value.id;
    if (validateEDC()) {
      ResponseCheckout result = await PaymentService.payment(checkOut.value);
      if (result.id != null) {
        tfCardNo.value.clear();
        tfCardName.value.clear();
        tfBatchNo.value.clear();
        tfTransactionNumber.value.clear();
        tfMerchantId.value.clear();

        printCustomCheckOut(result);
      } else {
        tfCardNo.value.clear();
        tfCardName.value.clear();
        tfBatchNo.value.clear();
        tfTransactionNumber.value.clear();
        tfMerchantId.value.clear();

        await fetchCheckShift();
        refreshDataAllOrder();
        getAllOrderList();
      }
    }
  }

  validateEDC() {
    if (tfCardNo.value.text.isEmpty ||
        tfCardName.value.text.isEmpty ||
        tfTransactionNumber.value.text.isEmpty ||
        tfMerchantId.value.text.isEmpty ||
        tfBatchNo.value.text.isEmpty) {
      Snackbar.show("Opps!", "Form debit masih ada yang kosong", mtRed600, mtGrey50);
      return false;
    } else {
      return true;
    }
  }

  checkOutEWallet() async {
    checkOut.value.paymentMethod = "CUSTOM";
    checkOut.value.status = "PAID";
    checkOut.value.change = 0;
    checkOut.value.adminFee = selectedPaymentCust.value.adminFee;
    checkOut.value.paymentTypeId = selectedPaymentCust.value.id;
    if (checkOut.value.image != "" && checkOut.value.image != null) {
      // log.d(checkOut.toJson());
      ResponseCheckout result = await PaymentService.payment(checkOut.value);
      if (result.id != null) {
        printCustomCheckOut(result);
      } else {
        await fetchCheckShift();
        refreshDataAllOrder();
        getAllOrderList();
      }
    } else {
      Snackbar.show("Opps!", "Bukti gambar masih kosong", mtRed600, mtGrey50);
    }
  }

  pendingBillCust() async {
    checkOut.value.paymentMethod = "CUST_DEBT";
    checkOut.value.status = "DEBT";
    checkOut.value.change = 0;
    if (selectedCust.value.id != null) {
      checkOut.value.customerId = selectedCust.value.id;
      checkOut.value.customerName = selectedCust.value.name;
      // log.d(checkOut.toJson());
      ResponseCheckout result = await PaymentService.payment(checkOut.value);
      await fetchCheckShift();
      refreshDataAllOrder();
      getAllOrderList();
    } else {
      Snackbar.show("Opps!", "Pelanggan masih kosong", mtRed600, mtGrey50);
    }
  }

  pendingBillEmpl() async {
    checkOut.value.paymentMethod = "EMPL_DEBT";
    checkOut.value.status = "DEBT";
    checkOut.value.change = 0;
    if (userDto.value.id != null) {
      checkOut.value.employeeUserName = userDto.value.username;
      // log.d(checkOut.toJson());
      ResponseCheckout result = await PaymentService.payment(checkOut.value);
      await fetchCheckShift();
      refreshDataAllOrder();
      getAllOrderList();
    }
  }

  // ================================================
  // ALL API DATA FETCH
  // ================================================

  Future<void> fetchCheckShift() async {
    shiftData$.value = ShiftObj();
    shiftData$.value = await CashierService.checkShift(checkShift$.value);
    shiftData$.refresh();
  }

  Future<void> fetchUserById(String id) async {
    userDto.value = UserDto();
    userDto.value = await UserService.getUserById(id);
    userDto.refresh();
    userIdController.value.clear();
  }

  Future<void> fetchAllorder() async {
    // log.d(reqOrder.toJson());
    loadingPageOrder.value = true;
    try {
      allOrder.value = await OrderService.getAllOrder(reqOrder.value);
      orderList.value = allOrder.value.allOrderList!;

      pagePageOrder.value = allOrder.value.pageable!.pageNumber! + 1;
      sizePageOrder.value = allOrder.value.pageable!.pageSize!;

      List<CreateOrderResponse> newData = orderList.value.length >= allOrder.value.pageable!.totalElements! ? [] : allOrder.value.allOrderList!;
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
    } catch (error) {
      Snackbar.show("Opps!", error.toString(), mtRed600, mtGrey50);
    }
  }

  Future<void> fetchDataTabel() async {
    // log.d(filterTable.toJson());
    try {
      TableModel tbl = await OrderService.getTable(filterTable.value);
      listTable.value = tbl.listTable!;
      listTable.refresh();
    } catch (error) {
      Snackbar.show("Opps!", error.toString(), mtRed600, mtGrey50);
    }
  }

  Future<void> fetchDataPaymentCust() async {
    // log.d(filterTable.toJson());
    PaymentCustomList payment = await PaymentService.getPaymenCust(filterPaymencCust.value);
    paymentCustList.value = payment.paymentCustList ?? <PaymentCustom>[];
    paymentCustList.refresh();
  }

  Future<void> fetchDiscount() async {
    // log.d(filterTable.toJson());
    discountList.value = await DiscountService.getAllDiscount(discountFilter.value);
    discountList.refresh();
  }

  Future<void> fetchGeneralVal() async {
    // log.d(filterTable.toJson());
    generalValue.value = await GeneralService.getAllGeneralValue(generalFilter.value);
    generalValue.refresh();
  }

  // @override
  // void onReady() {
  //   // TODO: implement onReady
  //   super.onReady();
  // }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();

    // ALL CONTROLLER
    scrollControllerOrderList.value.dispose();
    searchController.value.dispose();
    tfNameController.value.dispose();
    tfNoteController.value.dispose();
  }
}
