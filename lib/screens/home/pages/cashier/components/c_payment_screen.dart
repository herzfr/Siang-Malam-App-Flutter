// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:siangmalam/commons/controllers/cashier/orderlist_controller.dart';
import 'package:siangmalam/commons/routes/routes_name.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/values.dart';
import 'package:siangmalam/models/customer/customer.dart';
import 'package:sizer/sizer.dart';

class PaymentOrderScrenn extends GetView<OrderListController> {
  PaymentOrderScrenn({Key? key}) : super(key: key);

  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(1.sp),
      child: Container(
        color: Colors.transparent,
        child: Obx(() => pageControlPayment(context)),
      ),
    );
  }

  Widget pageControlPayment(BuildContext context) {
    switch (controller.pagePayment.value) {
      case 1:
        return setPaymenCash(context);
      case 2:
        return setPaymenOther(context);
      default:
        return setPaymentInvoice(context);
    }
  }

  Center setPaymenCash(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    "Tunai",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 6.sp,
                        fontWeight: FontWeight.w600,
                        color: primaryDarkGreen),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Kembalian",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 6.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF941919)),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.all(3.sp),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: primaryDarkGreen,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Text(
                          controller
                              .convertPrice(controller.checkOut.value.cash),
                          style: TextStyle(
                              fontSize: 6.sp,
                              fontWeight: FontWeight.bold,
                              color: primaryDarkGreen),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.all(3.sp),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFF941919),
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Text(
                          controller
                              .convertPrice(controller.checkOut.value.change),
                          style: TextStyle(
                              fontSize: 6.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF941919)),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Otomatis",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 6.sp,
                    fontWeight: FontWeight.w600,
                    color: primaryDarkGreen),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(1.sp),
                        child: ElevatedButton(
                          child:
                              Text('100.000', style: TextStyle(fontSize: 6.sp)),
                          onPressed: controller.cartItem.isNotEmpty
                              ? () {
                                  controller.inputAutomatically(100000);
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(100),
                            primary: primaryBlue,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(1.sp),
                        child: ElevatedButton(
                          child:
                              Text('75.000', style: TextStyle(fontSize: 6.sp)),
                          onPressed: controller.cartItem.isNotEmpty
                              ? () {
                                  controller.inputAutomatically(75000);
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(100),
                            primary: primaryBlue,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(1.sp),
                        child: ElevatedButton(
                          child:
                              Text('50.000', style: TextStyle(fontSize: 6.sp)),
                          onPressed: controller.cartItem.isNotEmpty
                              ? () {
                                  controller.inputAutomatically(50000);
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(100),
                            primary: primaryBlue,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(1.sp),
                        child: ElevatedButton(
                          child:
                              Text('20.000', style: TextStyle(fontSize: 6.sp)),
                          onPressed: controller.cartItem.isNotEmpty
                              ? () {
                                  controller.inputAutomatically(20000);
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(100),
                            primary: primaryBlue,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
          Expanded(
            flex: 1,
            child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(1.sp),
                        child: ElevatedButton(
                          child:
                              Text('10.000', style: TextStyle(fontSize: 6.sp)),
                          onPressed: controller.cartItem.isNotEmpty
                              ? () {
                                  controller.inputAutomatically(10000);
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(100),
                            primary: primaryBlue,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(1.sp),
                        child: ElevatedButton(
                          child:
                              Text('5.000', style: TextStyle(fontSize: 6.sp)),
                          onPressed: controller.cartItem.isNotEmpty
                              ? () {
                                  controller.inputAutomatically(5000);
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(100),
                            primary: primaryBlue,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(1.sp),
                        child: ElevatedButton(
                          child:
                              Text('2.000', style: TextStyle(fontSize: 6.sp)),
                          onPressed: controller.cartItem.isNotEmpty
                              ? () {
                                  controller.inputAutomatically(2000);
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(100),
                            primary: primaryBlue,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(1.sp),
                        child: ElevatedButton(
                          child:
                              Text('1.000', style: TextStyle(fontSize: 6.sp)),
                          onPressed: controller.cartItem.isNotEmpty
                              ? () {
                                  controller.inputAutomatically(1000);
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(100),
                            primary: primaryBlue,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 4,
                  child: Text(
                    "Kas Anda",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 6.sp,
                        fontWeight: FontWeight.w600,
                        color: primaryDarkGreen),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Text(
                    "Manual",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 6.sp,
                        fontWeight: FontWeight.w600,
                        color: primaryDarkGreen),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                      flex: 4,
                      child: Container(
                        color: Colors.transparent,
                        child: Padding(
                          padding: EdgeInsets.all(0.sp),
                          child: Column(
                            children: [
                              SizedBox(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Kas Penjualan",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 5.sp,
                                        fontWeight: FontWeight.w600,
                                        color: primaryGoldText),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsets.all(3.sp),
                                  child: FadeTransition(
                                    opacity: controller.animationController,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: primaryDarkGreen,
                                          width: 3,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Center(
                                        child: Text(
                                          controller.convertPrice(controller
                                              .shiftData$.value.endCash),
                                          style: TextStyle(
                                              fontSize: 6.sp,
                                              fontWeight: FontWeight.bold,
                                              color: primaryDarkGreen),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Estimasi Kas Selanjutnya",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 5.sp,
                                        fontWeight: FontWeight.w600,
                                        color: primaryGoldText),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsets.all(3.sp),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: primaryGoldText,
                                        width: 3,
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Center(
                                      child: Text(
                                        controller.convertPrice(
                                            controller.checkEstimateCash()),
                                        style: TextStyle(
                                            fontSize: 6.sp,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                controller.checkEstimateCash() <
                                                        0
                                                    ? const Color(0xFF941919)
                                                    : primaryGoldText),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Obx(
                                  () => Padding(
                                    padding: EdgeInsets.all(1.sp),
                                    child: ElevatedButton.icon(
                                      label: Text('Checkout',
                                          style: TextStyle(fontSize: 6.sp)),
                                      icon: Icon(
                                        Icons.shopping_cart_checkout,
                                        size: 6.sp,
                                      ),
                                      onPressed: controller.isCheckOut()
                                          ? () {
                                              controller.checkOutCash();
                                            }
                                          : null,
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: const Size.fromHeight(100),
                                        primary: primaryDarkGreen,
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                  Expanded(
                      flex: 6,
                      child: Container(
                        color: Colors.transparent,
                        child: numericButton(),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  numericButton() {
    return Padding(
      padding: EdgeInsets.all(0.sp),
      child: Column(children: [
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(1.sp),
                  child: ElevatedButton(
                    child: Text('7', style: TextStyle(fontSize: 6.sp)),
                    onPressed: controller.cartItem.isNotEmpty
                        ? () {
                            controller.inputManually(7);
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(100),
                      primary: primaryBlue,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(1.sp),
                  child: ElevatedButton(
                    child: Text('8', style: TextStyle(fontSize: 6.sp)),
                    onPressed: controller.cartItem.isNotEmpty
                        ? () {
                            controller.inputManually(8);
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(100),
                      primary: primaryBlue,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(1.sp),
                  child: ElevatedButton(
                    child: Text('9', style: TextStyle(fontSize: 6.sp)),
                    onPressed: controller.cartItem.isNotEmpty
                        ? () {
                            controller.inputManually(9);
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(100),
                      primary: primaryBlue,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(1.sp),
                  child: ElevatedButton(
                    child: Text('4', style: TextStyle(fontSize: 6.sp)),
                    onPressed: controller.cartItem.isNotEmpty
                        ? () {
                            controller.inputManually(4);
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(100),
                      primary: primaryBlue,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(1.sp),
                  child: ElevatedButton(
                    child: Text('5', style: TextStyle(fontSize: 6.sp)),
                    onPressed: controller.cartItem.isNotEmpty
                        ? () {
                            controller.inputManually(5);
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(100),
                      primary: primaryBlue,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(1.sp),
                  child: ElevatedButton(
                    child: Text('6', style: TextStyle(fontSize: 6.sp)),
                    onPressed: controller.cartItem.isNotEmpty
                        ? () {
                            controller.inputManually(6);
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(100),
                      primary: primaryBlue,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(1.sp),
                  child: ElevatedButton(
                    child: Text('1', style: TextStyle(fontSize: 6.sp)),
                    onPressed: controller.cartItem.isNotEmpty
                        ? () {
                            controller.inputManually(1);
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(100),
                      primary: primaryBlue,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(1.sp),
                  child: ElevatedButton(
                    child: Text('2', style: TextStyle(fontSize: 6.sp)),
                    onPressed: controller.cartItem.isNotEmpty
                        ? () {
                            controller.inputManually(2);
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(100),
                      primary: primaryBlue,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(1.sp),
                  child: ElevatedButton(
                    child: Text('3', style: TextStyle(fontSize: 6.sp)),
                    onPressed: controller.cartItem.isNotEmpty
                        ? () {
                            controller.inputManually(3);
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(100),
                      primary: primaryBlue,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(1.sp),
                  child: ElevatedButton(
                    child: Text('Clear', style: TextStyle(fontSize: 6.sp)),
                    onPressed: controller.cartItem.isNotEmpty
                        ? () {
                            controller.clearSpace();
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(100),
                      primary: const Color(0xFF941919),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(1.sp),
                  child: ElevatedButton(
                    child: Text('0', style: TextStyle(fontSize: 6.sp)),
                    onPressed: controller.cartItem.isNotEmpty
                        ? () {
                            controller.inputManually(0);
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(100),
                      primary: primaryBlue,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(1.sp),
                  child: ElevatedButton(
                    child: Text('<',
                        style: TextStyle(
                            fontSize: 6.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                    onPressed: controller.cartItem.isNotEmpty
                        ? () {
                            controller.backSpace();
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(100),
                      primary: primaryGrey,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Center setPaymenOther(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Expanded(flex: 1, child: categoryPayment(context)),
          Expanded(flex: 8, child: paymentCustomView(context)),
        ],
      ),
    );
  }

  paymentCustomView(BuildContext context) {
    switch (controller.selectedPaymentCust.value.type) {
      case "DEBIT":
        var node = FocusScope.of(context);
        return Padding(
          padding: EdgeInsets.all(3.sp),
          child: Form(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: TextFormField(
                  style:
                      TextStyle(fontSize: 8.sp, fontWeight: FontWeight.normal),
                  enabled: true,
                  controller: controller.tfCardNo.value,
                  keyboardType: TextInputType.number,
                  onSaved: (String? val) {},
                  decoration: InputDecoration(
                    fillColor: primaryLightGrey,
                    filled: true,
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    focusedBorder: InputBorder.none,
                    prefixIconConstraints: BoxConstraints(minWidth: 5.w),
                    suffixIconConstraints: BoxConstraints(minWidth: 5.w),
                    // border: outlineInputBorder,
                    hintText: "No Kartu",
                    errorText: null,
                    labelStyle: const TextStyle(color: primaryGrey),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 1.w),
                      child: Icon(
                        Icons.credit_card,
                        color: primaryGoldText,
                        size: 9.sp,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    controller.checkOut.value.cardNo = value;
                  },
                  // onEditingComplete: () => node.nextFocus(),
                ),
              ),
              SizedBox(
                height: 0.5.h,
              ),
              Expanded(
                flex: 1,
                child: TextFormField(
                  style:
                      TextStyle(fontSize: 8.sp, fontWeight: FontWeight.normal),
                  enabled: true,
                  controller: controller.tfCardName.value,
                  keyboardType: TextInputType.text,
                  onSaved: (String? val) {},
                  decoration: InputDecoration(
                    fillColor: primaryLightGrey,
                    filled: true,
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    focusedBorder: InputBorder.none,
                    prefixIconConstraints: BoxConstraints(minWidth: 5.w),
                    suffixIconConstraints: BoxConstraints(minWidth: 5.w),
                    // border: outlineInputBorder,
                    hintText: "Nama Pemegang Kartu",
                    errorText: null,
                    labelStyle: const TextStyle(color: primaryGrey),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 1.w),
                      child: Icon(
                        Icons.person,
                        color: primaryGoldText,
                        size: 9.sp,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    controller.checkOut.value.cardName = value;
                  },
                  // onEditingComplete: () => node.nextFocus(),
                ),
              ),
              SizedBox(
                height: 0.5.h,
              ),
              Expanded(
                flex: 1,
                child: TextFormField(
                  style:
                      TextStyle(fontSize: 8.sp, fontWeight: FontWeight.normal),
                  enabled: true,
                  controller: controller.tfTransactionNumber.value,
                  keyboardType: TextInputType.number,
                  onSaved: (String? val) {},
                  decoration: InputDecoration(
                    fillColor: primaryLightGrey,
                    filled: true,
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    focusedBorder: InputBorder.none,
                    prefixIconConstraints: BoxConstraints(minWidth: 5.w),
                    suffixIconConstraints: BoxConstraints(minWidth: 5.w),
                    // border: outlineInputBorder,
                    hintText: "No Transaksi",
                    errorText: null,
                    labelStyle: const TextStyle(color: primaryGrey),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 1.w),
                      child: Icon(
                        Icons.receipt,
                        color: primaryGoldText,
                        size: 9.sp,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    controller.checkOut.value.transactionNo = value;
                  },
                  // onEditingComplete: () => node.nextFocus(),
                ),
              ),
              SizedBox(
                height: 0.5.h,
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                    child: Row(children: [
                      Expanded(
                        flex: 5,
                        child: TextFormField(
                          style: TextStyle(
                              fontSize: 8.sp, fontWeight: FontWeight.normal),
                          enabled: true,
                          controller: controller.tfMerchantId.value,
                          keyboardType: TextInputType.number,
                          onSaved: (String? val) {},
                          decoration: InputDecoration(
                            fillColor: primaryLightGrey,
                            filled: true,
                            enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1),
                            ),
                            focusedBorder: InputBorder.none,
                            prefixIconConstraints:
                                BoxConstraints(minWidth: 5.w),
                            suffixIconConstraints:
                                BoxConstraints(minWidth: 5.w),
                            // border: outlineInputBorder,
                            hintText: "ID Merchant",
                            errorText: null,
                            labelStyle: const TextStyle(color: primaryGrey),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 2.w, vertical: 1.h),
                            suffixIcon: Padding(
                              padding: EdgeInsets.only(right: 1.w),
                              child: Icon(
                                Icons.receipt_long,
                                color: primaryGoldText,
                                size: 9.sp,
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            controller.checkOut.value.merchantId = value;
                          },
                          // onEditingComplete: () => node.nextFocus(),
                        ),
                      ),
                      SizedBox(
                        width: 0.5.w,
                      ),
                      Expanded(
                        flex: 5,
                        child: TextFormField(
                          style: TextStyle(
                              fontSize: 8.sp, fontWeight: FontWeight.normal),
                          enabled: true,
                          controller: controller.tfBatchNo.value,
                          keyboardType: TextInputType.text,
                          onSaved: (String? val) {},
                          decoration: InputDecoration(
                            fillColor: primaryLightGrey,
                            filled: true,
                            enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1),
                            ),
                            focusedBorder: InputBorder.none,
                            prefixIconConstraints:
                                BoxConstraints(minWidth: 5.w),
                            suffixIconConstraints:
                                BoxConstraints(minWidth: 5.w),
                            // border: outlineInputBorder,
                            hintText: "No. Batch",
                            errorText: null,
                            labelStyle: const TextStyle(color: primaryGrey),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 2.w, vertical: 1.h),
                            suffixIcon: Padding(
                              padding: EdgeInsets.only(right: 1.w),
                              child: Icon(
                                Icons.drag_indicator_outlined,
                                color: primaryGoldText,
                                size: 9.sp,
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            controller.checkOut.value.batchNo = value;
                          },
                          // onEditingComplete: () => node.nextFocus(),
                        ),
                      ),
                    ]),
                  )),
              // Expanded(flex: 6, child: Container()),
              const Spacer(),
              Expanded(
                flex: 1,
                child: Text(
                  'Masukan No Kartu dll',
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontSize: 6.sp, fontWeight: FontWeight.normal),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  'Admin Fee ${controller.selectedPaymentCust.value.adminFee}%',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 8.sp, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.all(1.sp),
                  child: ElevatedButton.icon(
                    label: Text('Checkout', style: TextStyle(fontSize: 6.sp)),
                    icon: Icon(Icons.shopping_cart_checkout, size: 12.sp),
                    onPressed: controller.cartItem.isNotEmpty
                        ? () {
                            controller.checkOutCardDebit();
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(100),
                      primary: primaryDarkGreen,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
        );
      case "EWALLET":
        return Padding(
            padding: EdgeInsets.all(1.sp),
            child: Column(
              children: [
                Expanded(
                  flex: 7,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
                    child: SizedBox(
                      // height: 50.w,
                      width: 100.w,
                      child: Stack(
                        fit: StackFit.expand,
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              // shape: BoxShape.circle,
                              border:
                                  Border.all(color: primaryYellow, width: 2),
                              boxShadow: const [
                                BoxShadow(
                                    blurRadius: 2,
                                    color: Colors.grey,
                                    spreadRadius: 1,
                                    offset: Offset(0, 4))
                              ],
                            ),
                            child: Obx(
                              () {
                                if (controller.checkOut.value.image != "" &&
                                    controller.checkOut.value.image != null) {
                                  return Image.memory(
                                      controller.getRecentlyUploaded());
                                } else {
                                  return const FittedBox(
                                    fit: BoxFit.fill,
                                    child: Image(
                                      image: AssetImage(
                                          "assets/images/no_pic_square.png"),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                          Positioned(
                            right: 16,
                            bottom: 16,
                            child: SizedBox(
                              height: 6.h,
                              width: 10.w,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                    side:
                                        const BorderSide(color: primaryYellow),
                                  ),
                                  primary: Colors.white,
                                  backgroundColor: const Color(0xFFF5F6F9),
                                ),
                                onPressed:
                                    controller.checkOut.value.tempSalesId !=
                                            null
                                        ? () {
                                            imageSelectorCameraProof();
                                          }
                                        : null,
                                child: Material(
                                    elevation: 5,
                                    child: SvgPicture.asset(
                                      "assets/icons/Camera Icon.svg",
                                      height: 3.h,
                                      width: 3.w,
                                    )),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'Admin Fee ${controller.selectedPaymentCust.value.adminFee}%',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 8.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(1.sp),
                    child: ElevatedButton.icon(
                      label: Text('Checkout', style: TextStyle(fontSize: 6.sp)),
                      icon: Icon(Icons.shopping_cart_checkout, size: 12.sp),
                      onPressed: controller.cartItem.isNotEmpty
                          ? () {
                              controller.checkOutEWallet();
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(100),
                        primary: primaryDarkGreen,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ));
      case "TRANSFER":
        return Center(
          child: Text(
            "Tipe pembayaran tidak tersedia, mohon pilih terlebih dahulu",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 7.sp),
          ),
        );
      case "OTHER":
        return Center(
          child: Text(
            "Tipe pembayaran tidak tersedia, mohon pilih terlebih dahulu",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 7.sp),
          ),
        );
      default:
        return Center(
          child: Text(
            "Tipe pembayaran tidak tersedia, mohon pilih terlebih dahulu",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 7.sp),
          ),
        );
    }
  }

  // CATEGORY
  // =====================================
  Container categoryPayment(BuildContext context) {
    return Container(
      color: Colors.transparent,
      margin: const EdgeInsets.symmetric(vertical: 10 / 2),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.paymentCustList.length,
          itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  // print('work');
                  controller.selectedPaymentCust.value =
                      controller.paymentCustList.elementAt(index);
                  // controller.refreshDataMenu();
                },
                child: Obx(
                  () => Container(
                    width: 20.w,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(left: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: controller.paymentCustList.elementAt(index) ==
                                controller.selectedPaymentCust.value
                            ? primaryYellow
                            : primaryLightGrey,
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(
                      controller.paymentCustList[index].name.toString(),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 7.sp, color: Colors.black),
                    ),
                  ),
                ),
              )),
    );
  }

  // IMAGE UPLOAD
  // =====================================
  imageSelectorCameraProof() async {
    // Get.back();
    final XFile? image = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: imageQuality,
      maxHeight: maxImageHeight,
      maxWidth: maxImageWidth,
    );
    imageUploadProof(image);
  }

  imageUploadProof(XFile? image) {
    if (image != null) {
      var imagePath = image.path;
      var fileName = (imagePath.split('/').last);
      Get.defaultDialog(
          title: "Ubah Bukti E-Wallet",
          middleText: "Anda akan mengunggah foto bukti pembayaran, lanjutkan?",
          backgroundColor: whiteBg,
          titleStyle: const TextStyle(color: mtGrey700),
          middleTextStyle: const TextStyle(color: mtGrey700),
          textConfirm: confirmYes,
          textCancel: confirmNo,
          cancelTextColor: mtGrey700,
          confirmTextColor: mtGrey700,
          buttonColor: primaryYellow,
          onConfirm: () {
            Get.back();
            controller.saveImageProof(imagePath, fileName);
          });
    }
  }

  Center setPaymentInvoice(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            child: Text(
              'Pending Bill',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 6.sp, fontWeight: FontWeight.normal),
            ),
          ),
          Expanded(
              flex: 1,
              child: Padding(
                  padding: EdgeInsets.all(1.sp),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.all(1.sp),
                          child: ElevatedButton(
                            child: Text('Pending Pelanggan',
                                style: TextStyle(fontSize: 6.sp)),
                            onPressed: () {
                              controller.selectedPanding.value = 1;
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(100),
                              primary: controller.selectedPanding.value == 1
                                  ? primaryGoldText
                                  : primaryGrey,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.all(1.sp),
                          child: ElevatedButton(
                            child: Text('Pending Karyawan',
                                style: TextStyle(fontSize: 6.sp)),
                            onPressed: () {
                              controller.selectedPanding.value = 2;
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(100),
                              primary: controller.selectedPanding.value == 2
                                  ? primaryGoldText
                                  : primaryGrey,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ))),
          // const Spacer(),
          Expanded(flex: 8, child: pendingCustomView(context)),
        ],
      ),
    );
  }

  pendingCustomView(BuildContext context) {
    switch (controller.selectedPanding.value) {
      case 1:
        return Padding(
            padding: EdgeInsets.all(3.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Text(
                    'Masukan data pelanggan terlebih dahulu',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 6.sp, fontWeight: FontWeight.normal),
                  ),
                ),
                SizedBox(height: 0.5.h),
                Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.all(1.sp),
                      child: Obx(() {
                        return DropdownButtonFormField<ListCustomer>(
                          // key: controller.dropStatus,
                          onChanged: controller.cartItem.isNotEmpty
                              ? ((value) => {
                                    controller.selectedCust.value =
                                        value ?? ListCustomer()
                                  })
                              : null,
                          items: controller.dropdownCustList,
                          isExpanded: true,
                          value: controller.selectedCust.value.id == null
                              ? null
                              : controller.selectedCust.value,
                          style: TextStyle(fontSize: 8.sp, color: mtGrey800),
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: primaryDarkGreen),
                              ),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1, color: primaryLightGrey),
                                borderRadius: BorderRadius.circular(1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1, color: primaryDarkGreen),
                                borderRadius: BorderRadius.circular(1),
                              ),
                              // hintText: "Percarian Berdasarkan",
                              labelText: "Pelanggan",
                              labelStyle: TextStyle(fontSize: 9.sp),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 7.0.w, vertical: 1.5.h)),
                        );
                      }),
                    )),
                Expanded(
                  flex: 5,
                  child: Padding(
                      padding: EdgeInsets.all(1.sp), child: Container()),
                ),
                const Spacer(),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.all(1.sp),
                    child: Obx(
                      () => ElevatedButton.icon(
                        label: Text('Pending Bill Pelanggan',
                            style: TextStyle(fontSize: 6.sp)),
                        icon: Icon(Icons.pending_actions, size: 12.sp),
                        onPressed: controller.selectedCust.value.id != null
                            ? () {
                                controller.pendingBillCust();
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(100),
                          primary: primaryDarkGreen,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ));
      default:
        return Padding(
          padding: EdgeInsets.all(3.sp),
          child: Column(children: [
            SizedBox(
              child: Text(
                'Scan atau masukan data id karyawan terlebih dahulu',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 6.sp, fontWeight: FontWeight.normal),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(3.sp),
                child: Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: Padding(
                          padding: EdgeInsets.all(2.sp),
                          child: searchFieldIdKaryawan(context)),
                    ),
                    SizedBox(
                      width: 1.w,
                    ),
                    Expanded(
                      flex: 4,
                      child: FadeTransition(
                        opacity: controller.animationController,
                        child: ElevatedButton.icon(
                          label: Text('Scan Qr Karyawan',
                              style: TextStyle(fontSize: 5.sp)),
                          icon: Icon(Icons.qr_code_2, size: 12.sp),
                          onPressed: () async {
                            Get.toNamed(RouteName.cashierQrCodeScreen)!
                                .then((value) async => {
                                      if (value != null)
                                        {
                                          controller.userIdController.value
                                              .text = value,
                                          await controller.fetchUserById(
                                              controller
                                                  .userIdController.value.text)
                                        }
                                    });
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(100),
                            primary: primaryBlue,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Padding(
                padding: EdgeInsets.all(3.sp),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: primaryDarkGreen,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: controller.userDto.value.username != null
                      ? Padding(
                          padding: EdgeInsets.all(1.sp),
                          child: listDataEmpl(),
                        )
                      : Center(
                          child: Text(
                            "Tidak ada data karyawan",
                            style: TextStyle(
                                fontSize: 6.sp,
                                fontWeight: FontWeight.bold,
                                color: primaryDarkGreen),
                          ),
                        ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.all(1.sp),
                child: Obx(
                  () => ElevatedButton.icon(
                    label: Text('Pending Bill Karyawan',
                        style: TextStyle(fontSize: 6.sp)),
                    icon: Icon(Icons.pending_actions, size: 12.sp),
                    onPressed: controller.userDto.value.id != null
                        ? () {
                            controller.pendingBillEmpl();
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(100),
                      primary: primaryDarkGreen,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ]),
        );
    }
  }

  Center listDataEmpl() {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.person, size: 9.sp),
              title: Text(controller.userDto.value.id ?? ""),
              subtitle: Text(
                  "${controller.userDto.value.username} ${controller.userDto.value.firstName ?? ''}"),
            ),
            Text("Terakhir Login ${controller.userDto.value.lastLogin}"),
          ],
        ),
      ),
    );
  }

  Center searchFieldIdKaryawan(BuildContext context) {
    return Center(
      child: Container(
          // width: 100.w,
          // height: 40.h,
          padding: EdgeInsets.all(1.sp),
          color: primaryDarkGreen,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                  child: Obx(
                () => TextField(
                  controller: controller.userIdController.value,
                  style: TextStyle(fontSize: 7.sp, color: Colors.white),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                            width: 1, color: primaryDarkGreen)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                            width: 1, color: primaryDarkGreen)),
                    hintText: "ID...",
                    filled: true,
                    fillColor: primaryLightGrey.withOpacity(.5),
                  ),
                ),
              )),
              FittedBox(
                child: InkWell(
                  onTap: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    await controller
                        .fetchUserById(controller.userIdController.value.text);
                  },
                  child: Icon(Icons.search_outlined,
                      size: 9.sp, color: Colors.white),
                ),
              ),
            ],
          )),
    );
  }
}
