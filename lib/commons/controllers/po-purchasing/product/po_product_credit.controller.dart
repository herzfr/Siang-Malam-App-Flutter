import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
// import 'package:logger/logger.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/enums.dart';
import 'package:siangmalam/models/cashier/payment.dart';
import 'package:siangmalam/models/purchase-orders/filter-po.dart';
import 'package:siangmalam/models/purchase-orders/po-product.dart';
import 'package:siangmalam/models/purchase-orders/po-purchasing.dart';
import 'package:siangmalam/services/app_static.dart';
import 'package:siangmalam/services/cashier/payment_service.dart';
import 'package:siangmalam/services/po/purchase-product.service.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PoProductCreditController extends GetxController {
  // var log = Logger();
  late int? branchId = AppStatic.userData.branchId;
  int? subBranchId;

  var detailPurchasing = DetailPurchasing().obs;
  var listPurchasingCredit = <ExpensesPurchasing>[].obs;

  // Controller
  final PanelController pcs = PanelController();
  var textFieldAmount = TextEditingController().obs;
  var textFieldtransactionNo = TextEditingController().obs;
  var textFieldcardNo = TextEditingController().obs;
  var textFieldcardName = TextEditingController().obs;
  var textFieldmerchantId = TextEditingController().obs;
  var textFieldbatchNo = TextEditingController().obs;

  // DATA
  var listPoproduct = ListPoProduct().obs;
  var parentPaymentCustList = PaymentCustomList().obs;
  var paymentCustList = <PaymentCustom>[].obs;
  var filterPaymencCust = GetPaymentCust().obs;
  var paymentPo = PaymentPo().obs;

  // STR
  var isSubmit = false.obs;
  var paymentMethodt = PaymentMethod.cash.obs;

  // PANEL
  final double initFabHeight = 5.h;
  double fabHeight = 0;
  double panelHeightOpen = 0;
  double panelHeightClosed = 5.h;

  // IMAGE
  var imageReceipt = ImagePurchaseRequestDto(fileName: '', filePath: '').obs;
  var listImagesRequest = <ImagePurchaseRequestDto>[].obs;

  @override
  void onInit() async {
    super.onInit();
    listPoproduct.value = Get.arguments ?? ListPoProduct();
    // log.d(listPoproduct.toJson());
    await fetchCredit();
    await updatePageFilterPaymentCus();
    await fetchDataPaymentCust();
    detailPurchasing.refresh();
    listPurchasingCredit.refresh();
  }

  converDateDateToString(String date) {
    var dt = DateTime.parse(date);
    return DateFormat('dd MMMM yyyy').format(dt).toString();
  }

  converDateDateToStringTime(String date) {
    var dt = DateTime.parse(date);
    return DateFormat('HH:mm').format(dt).toString();
  }

  convertPrice(int? price) {
    if (price != null) {
      final currencyFormatter = NumberFormat('#,##0', 'ID');
      return 'Rp ' + currencyFormatter.format(price);
    } else {
      return 'Rp 0';
    }
  }

  // update payment cust
  updatePageFilterPaymentCus() {
    filterPaymencCust.update((val) {
      val?.size = 100;
      val?.page = 0;
      val?.search = "";
      val?.type = "ALL";
      val?.option = "accountNo";
    });
  }

  getPaymentMethod(int index) {
    // log.d(listPurchasingCredit[index].paymentTypeId);
    int? paymentid = listPurchasingCredit[index].paymentTypeId;
    if (paymentid != null) {
      int index = paymentCustList.indexWhere((e) => e.id == paymentid);
      var prodLists = paymentCustList.elementAt(index);
      return prodLists.name;
    } else {
      return 'Tunai';
    }
  }

  saveImageReceipt(String imagePath, String imageName) async {
    imageReceipt.value =
        ImagePurchaseRequestDto(fileName: imageName, filePath: imagePath);
    listImagesRequest.add(imageReceipt.value);
  }

  onChangeValueAmount(String value) {
    // log.d(main(convertStringToNumber(value)));
    int amount = main(convertStringToNumber(value));
    int e = listPoproduct.value.remaining ?? 0;
    if (amount > e) {
      textFieldAmount.value.text = e.toString();
    }
  }

  convertStringToNumber(String value) {
    var str = value.replaceAll(RegExp(r'[^0-9]'), '');
    return str;
  }

  int main(String arguments) {
    try {
      var str = arguments == '' ? (0).toString() : arguments;
      int? a = int.parse(str);
      return a.abs();
    } on FormatException {
      return 0;
    }
  }

  submitValidate() async {
    if (paymentMethodt.value == PaymentMethod.custom) {
      if (paymentPo.value.paymentTypeId != null) {
        if (imageReceipt.value.fileName.isNotEmpty) {
          await initValueSubmit('CUSTOM');
          // log.d(paymentPo.toJson());
          pushNewPayment();
        } else {
          Get.snackbar("Oops", "Belum ada upload bukti",
              backgroundColor: mtRed600, colorText: textColor);
        }
      } else {
        Get.snackbar("Oops", "Mohon pilih salah satu metode pembayaran",
            backgroundColor: mtRed600, colorText: textColor);
      }
    } else {
      if (imageReceipt.value.fileName.isNotEmpty) {
        await initValueSubmit('CASH');
        // log.d(paymentPo.toJson());
        pushNewPayment();
      } else {
        Get.snackbar("Oops", "Belum ada upload bukti",
            backgroundColor: mtRed600, colorText: textColor);
      }
    }
  }

  initValueSubmit(String expenseType) {
    paymentPo.update((val) {
      val?.orderNo = int.parse(listPoproduct.value.orderNo!);
      val?.amount = int.parse(textFieldAmount.value.text != ''
          ? convertRpStringToInt(textFieldAmount.value.text).toString()
          : '0');
      val?.expenseType = expenseType;
      val?.transactionNo = textFieldtransactionNo.value.text.isNotEmpty
          ? textFieldtransactionNo.value.text
          : null;
      val?.cardName = textFieldcardName.value.text.isNotEmpty
          ? textFieldcardName.value.text
          : null;
      val?.cardNo = textFieldcardNo.value.text.isNotEmpty
          ? textFieldcardNo.value.text
          : null;
      val?.batchNo = textFieldbatchNo.value.text != ''
          ? textFieldbatchNo.value.text
          : null;
      val?.merchantId = textFieldmerchantId.value.text.isNotEmpty
          ? textFieldmerchantId.value.text
          : null;
    });
  }

  convertRpStringToInt(String str) {
    int amount = main(convertStringToNumber(str));
    return amount;
  }

  recoverForm() {
    paymentPo.value = PaymentPo();
    paymentMethodt.value = PaymentMethod.cash;
    textFieldAmount.value.clear();
    textFieldtransactionNo.value.clear();
    textFieldcardNo.value.clear();
    textFieldcardName.value.clear();
    textFieldmerchantId.value.clear();
    textFieldbatchNo.value.clear();
    imageReceipt.value = ImagePurchaseRequestDto(fileName: '', filePath: '');
    listPurchasingCredit.clear();

    imageReceipt.refresh();
    paymentPo.refresh();
    detailPurchasing.refresh();
    listPurchasingCredit.refresh();
    update();
  }

  openClosePanelControl() {
    if (pcs.isPanelClosed) {
      pcs.open();
    } else {
      pcs.close();
    }
  }

  // =======================================
  // API
  // =======================================
  Future<void> fetchCredit() async {
    detailPurchasing.value =
        await PurchaseProductService.getDetailPoProductPayment(
            listPoproduct.value.orderNo!);
    listPurchasingCredit.addAll(detailPurchasing.value.expensespurchasing!);
    // log.d(listPurchasingCredit.toJson());
  }

  Future<void> fetchDataPaymentCust() async {
    // log.d(filterTable.toJson());
    parentPaymentCustList.value =
        await PaymentService.getPaymenCust(filterPaymencCust.value);
    paymentCustList.value =
        parentPaymentCustList.value.paymentCustList ?? <PaymentCustom>[];
    paymentCustList.refresh();
  }

  Future<void> pushNewPayment() async {
    isSubmit.value = true;
    bool result = await PurchaseProductService.approvePayment(
        imageReceipt.value, paymentPo.value);
    if (result) {
      recoverForm();
      await fetchCredit();
    }
    isSubmit.value = false;
    openClosePanelControl();
  }

  // @override
  // void onClose() {
  //   // TODO: implement onClose
  //   super.onClose();
  // }
}
