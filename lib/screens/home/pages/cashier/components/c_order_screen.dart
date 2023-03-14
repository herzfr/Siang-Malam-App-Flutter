import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/cashier/orderlist_controller.dart';
import 'package:siangmalam/commons/custom_style.dart';
import 'package:siangmalam/commons/routes/routes_name.dart';
import 'package:siangmalam/commons/size_config.dart';
import 'package:siangmalam/constans/colors.dart';
// import 'package:siangmalam/screens/home/pages/cashier/cashier_screen.dart';
import 'package:siangmalam/screens/home/pages/cashier/components/c_payment_screen.dart';
import 'package:sizer/sizer.dart';

class CashierOrderListScreen extends GetView<OrderListController> {
  const CashierOrderListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        // appBar: buildAppBar(context),
        body: bodyCashier(context));
  }

  Padding bodyCashier(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(top: 2.h),
      child: Container(
        alignment: Alignment.center,
        child: Row(
          children: [
            // FOR LIST ORDER
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.transparent,
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: Colors.transparent,
                        child: Padding(
                          padding: EdgeInsets.all(2.sp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 2,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: primaryDarkGreen,
                                    minimumSize: Size.fromHeight(5.h),
                                  ),
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Icon(
                                    Icons.arrow_back,
                                    size: 9.sp,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 6,
                                child: Padding(
                                    padding: EdgeInsets.all(2.sp),
                                    child: searchField(context)),
                              ),
                              SizedBox(
                                width: 1.w,
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Obx(
                                    () => ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: primaryDarkGreen,
                                        minimumSize: Size.fromHeight(5.h),
                                      ),
                                      onPressed: controller.isMerge.isFalse
                                          ? () async {
                                              debugPrint('Work');
                                              Get.toNamed(RouteName
                                                      .cashierQrCodeScreen)!
                                                  .then((value) => {
                                                        if (value != null)
                                                          {
                                                            controller
                                                                .searchController
                                                                .value
                                                                .text = value,
                                                            controller
                                                                .searchOrderList()
                                                          }
                                                      });
                                            }
                                          : null,
                                      child: Icon(
                                        Icons.qr_code,
                                        size: displayWidth(context) * 0.015,
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Container(
                          color: primaryLightGrey,
                          child: Obx(() => generateListViewOrder(context)),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: Colors.transparent,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 8,
                              child: Padding(
                                padding: EdgeInsets.all(3.sp),
                                child: Obx(() {
                                  return DropdownButtonFormField<String>(
                                    // key: controller.dropStatus,
                                    onChanged: controller.isMerge.isFalse
                                        ? ((value) => {
                                              controller.optionTypeSearch
                                                  .value = value!
                                            })
                                        : null,
                                    items: controller.dOptSearch,
                                    isExpanded: true,
                                    value: controller.optionTypeSearch.value,
                                    style: TextStyle(
                                        fontSize: 8.sp, color: mtGrey800),
                                    decoration: InputDecoration(
                                        fillColor: Colors.white,
                                        filled: true,
                                        enabledBorder: outlineInputBorder,
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 1,
                                              color: primaryLightGrey),
                                          borderRadius:
                                              BorderRadius.circular(1),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 1,
                                              color: primaryDarkGreen),
                                          borderRadius:
                                              BorderRadius.circular(1),
                                        ),
                                        // hintText: "Percarian Berdasarkan",
                                        labelText: "Percarian Berdasarkan",
                                        labelStyle: TextStyle(fontSize: 9.sp),
                                        errorStyle: errorTextStyle,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 7.0.w,
                                            vertical: 1.0.h)),
                                  );
                                }),
                              ),
                            ),
                            Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: EdgeInsets.all(3.sp),
                                  child: Obx(() => generateButtonRefresOrder()),
                                )),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            // FOR LIST ITEM
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.all(2.sp),
                child: Container(
                  color: primaryLightGrey,
                  child: Column(
                    children: [
                      // LIST CART
                      Expanded(
                        flex: 6,
                        child: Container(
                          color: Colors.transparent,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 1.w),
                            child: Obx(() => controller.cartItem.isNotEmpty
                                ? initBodyCard(context)
                                : Center(
                                    child: Text(
                                      "Item Kosong!",
                                      style: TextStyle(fontSize: 9.sp),
                                    ),
                                  )),
                          ),
                        ),
                      ),
                      // LIST TOTAL CHECKOUT
                      Expanded(
                        flex: 3,
                        child: Container(
                          color: Colors.white,
                          child: Padding(
                              padding: EdgeInsets.all(1.sp),
                              child: checkoutListView(context)),
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
                                  child: Obx(
                                    () => ElevatedButton(
                                      child: Text(
                                          controller.isMerge.isFalse
                                              ? "Gabung Bill"
                                              : "Gabung...",
                                          style: TextStyle(fontSize: 8.sp)),
                                      onPressed: () {
                                        if (controller.isMerge.isTrue) {
                                          controller.isMerge.value = false;
                                          controller.refreshMergeBill();
                                        } else {
                                          controller.isMerge.value = true;
                                          controller.refreshMergeBill();
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: Size.fromHeight(5.h),
                                        primary: controller.isMerge.isFalse
                                            ? primaryDarkGreen
                                            : const Color(0xFF941919),
                                        elevation: 2,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                      ),
                                    ),
                                  )),
                              SizedBox(
                                width: 1.w,
                              ),
                              Expanded(
                                flex: 1,
                                child: Obx(
                                  () => controller.cartItem.isNotEmpty
                                      ? ElevatedButton(
                                          child: Text('Pisah Bill',
                                              style: TextStyle(fontSize: 8.sp)),
                                          onPressed: controller
                                                              .order.value.id !=
                                                          null &&
                                                      controller.cartItem.any(
                                                          (e) =>
                                                              e.amount! > 1) ||
                                                  controller.order.value.items!
                                                          .length >
                                                      1
                                              ? () {
                                                  Get.toNamed(RouteName
                                                          .cashierSplitFormScreen)!
                                                      .then((value) => {
                                                            controller
                                                                .refreshDataAllOrder(),
                                                            controller
                                                                .getAllOrderList(),
                                                            controller
                                                                .refresh(),
                                                          });
                                                }
                                              : null,
                                          style: ElevatedButton.styleFrom(
                                            minimumSize: Size.fromHeight(5.h),
                                            primary: primaryGoldText,
                                            elevation: 5,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                          ),
                                        )
                                      : ElevatedButton(
                                          child: Text('Pisah Bill',
                                              style: TextStyle(fontSize: 6.sp)),
                                          onPressed: null,
                                          style: ElevatedButton.styleFrom(
                                            minimumSize:
                                                const Size.fromHeight(100),
                                            primary: primaryGoldText,
                                            elevation: 5,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                          ),
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // FOR TRANSACTION & MERGE
            Expanded(
              flex: 4,
              child: Container(
                color: Colors.transparent,
                child: Obx(() => controller.isMerge.isTrue
                    ? mergeBill(context)
                    : paymentBil(context)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Padding paymentBil(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(2.sp),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.transparent,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.all(1.sp),
                        child: ElevatedButton.icon(
                          label: Text('Diskon',
                              style: TextStyle(
                                  fontSize: 7.sp, color: primaryDarkGreen)),
                          icon: Icon(
                            Icons.discount,
                            color: primaryDarkGreen,
                            size: 9.sp,
                          ),
                          onPressed: controller.cartItem.isNotEmpty
                              ? () {
                                  showDialogGeneral(context, 1);
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(100),
                            primary: Colors.white,
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
                        child: ElevatedButton.icon(
                          label: Text('Service',
                              style: TextStyle(
                                  fontSize: 7.sp, color: primaryDarkGreen)),
                          icon: Icon(
                            Icons.room_service,
                            color: primaryDarkGreen,
                            size: 9.sp,
                          ),
                          onPressed: controller.cartItem.isNotEmpty
                              ? () {
                                  showDialogGeneral(context, 3);
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(100),
                            primary: Colors.white,
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
                        child: ElevatedButton.icon(
                          label: Text('Pajak',
                              style: TextStyle(
                                  fontSize: 7.sp, color: primaryDarkGreen)),
                          icon: Icon(
                            Icons.monetization_on,
                            color: primaryDarkGreen,
                            size: 9.sp,
                          ),
                          onPressed: controller.cartItem.isNotEmpty
                              ? () {
                                  showDialogGeneral(context, 2);
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(100),
                            primary: Colors.white,
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
              flex: 1,
              child: Container(
                color: Colors.transparent,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.all(1.sp),
                        child: ElevatedButton(
                          child:
                              Text('Tunai', style: TextStyle(fontSize: 6.sp)),
                          onPressed: () {
                            controller.changePagePayment(1);
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(100),
                            primary: controller.pagePayment.value == 1
                                ? primaryGoldText
                                : primaryDarkGreen,
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
                          child:
                              Text('Lainnya', style: TextStyle(fontSize: 6.sp)),
                          onPressed: () {
                            controller.changePagePayment(2);
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(100),
                            primary: controller.pagePayment.value == 2
                                ? primaryGoldText
                                : primaryDarkGreen,
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
                          child:
                              Text('Pending', style: TextStyle(fontSize: 6.sp)),
                          onPressed: () {
                            controller.changePagePayment(3);
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(100),
                            primary: controller.pagePayment.value == 3
                                ? primaryGoldText
                                : primaryDarkGreen,
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
              flex: 8,
              child: Container(
                color: Colors.transparent,
                child: PaymentOrderScrenn(),
              ),
            ),
          ],
        ));
  }

  void showDialogGeneral(BuildContext context, int view) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, __, ___) {
        return Center(
          child: Container(
            height: 40.h,
            width: 100.w,
            child: SizedBox.expand(
              child: Padding(
                padding: EdgeInsets.all(5.sp),
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: ElevatedButton.icon(
                                  label: Text('Tutup',
                                      style: TextStyle(
                                          fontSize: 7.sp,
                                          color: primaryDarkGreen)),
                                  icon: Icon(
                                    Icons.close,
                                    color: primaryDarkGreen,
                                    size: 9.sp,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size.fromHeight(100),
                                    primary: Colors.white,
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(flex: 4, child: getText(view)),
                              Expanded(
                                flex: 2,
                                child: ElevatedButton(
                                  child: getTextClear(view),
                                  onPressed: () =>
                                      counterButtonPress(context, view),
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size.fromHeight(100),
                                    primary: Colors.white,
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                      Expanded(
                          flex: 9,
                          child: switcherListViewDialog(context, view)),
                    ],
                  ),
                ),
              ),
            ),
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(40)),
          ),
        );
      },
      transitionBuilder: (ctx, anim1, anim2, child) {
        Tween<Offset> tween;
        if (anim1.status == AnimationStatus.reverse) {
          tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: Offset(1, 0), end: Offset.zero);
        }
        return BackdropFilter(
          filter: ImageFilter.blur(
              sigmaX: 4 * anim1.value, sigmaY: 4 * anim1.value),
          child: SlideTransition(
            position: tween.animate(anim1),
            child: FadeTransition(
              child: child,
              opacity: anim1,
            ),
          ),
        );
      },
    );
  }

  ListView switcherListViewDialog(BuildContext context, int view) {
    switch (view) {
      case 1:
        return setListDiscount(context);
      case 2:
        return setListTax(context);
      case 3:
        return setListFee(context);
      default:
        return ListView();
    }
  }

  void counterButtonPress(BuildContext context, int view) async {
    switch (view) {
      case 1:
        await controller.deleteDiscount();
        Navigator.pop(context);
        break;
      case 2:
        await controller.deleteTax();
        Navigator.pop(context);
        break;
      case 3:
        await controller.deleteService();
        Navigator.pop(context);
        break;
    }
  }

  Text getText(int view) {
    switch (view) {
      case 1:
        return Text(
          "Diskon",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 9.sp, color: primaryDarkGreen),
        );
      case 2:
        return Text(
          "Pajak",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 9.sp, color: primaryDarkGreen),
        );
      default:
        return Text(
          "Service",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 9.sp, color: primaryDarkGreen),
        );
    }
  }

  Text getTextClear(int view) {
    switch (view) {
      case 1:
        return Text('Hapus Diskon',
            style: TextStyle(fontSize: 7.sp, color: primaryDarkGreen));
      case 2:
        return Text('Hapus Pajak',
            style: TextStyle(fontSize: 7.sp, color: primaryDarkGreen));
      default:
        return Text('Hapus Service',
            style: TextStyle(fontSize: 7.sp, color: primaryDarkGreen));
    }
  }

  ListView setListTax(BuildContext context) {
    return ListView.builder(
        itemCount: controller.generalValue.value.valueList == null
            ? 0
            : controller.generalValue.value.valueList!
                .where((element) => element.type == "TAX")
                .length,
        itemBuilder: (context, index) {
          return Obx(
            () => Padding(
              padding: EdgeInsets.all(1.sp),
              child: SizedBox(
                child: Card(
                  elevation: 2,
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () async {
                      await controller.chooseTax(index);
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                    child: SizedBox(
                      child: Padding(
                          padding: EdgeInsets.all(2.sp),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  (index + 1).toString(),
                                  style: TextStyle(fontSize: 8.sp),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  controller.generalValue.value.valueList!
                                          .where((element) =>
                                              element.type == "TAX")
                                          .elementAt(index)
                                          .key ??
                                      "",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 8.sp),
                                ),
                              ),
                              Expanded(
                                flex: 6,
                                child: Text(
                                  controller.generalValue.value.valueList!
                                          .where((element) =>
                                              element.type == "TAX")
                                          .elementAt(index)
                                          .description ??
                                      "",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(fontSize: 8.sp),
                                ),
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  ListView setListFee(BuildContext context) {
    return ListView.builder(
        itemCount: controller.generalValue.value.valueList == null
            ? 0
            : controller.generalValue.value.valueList!
                .where((element) => element.type == "FEE")
                .length,
        itemBuilder: (context, index) {
          return Obx(
            () => Padding(
              padding: EdgeInsets.all(1.sp),
              child: SizedBox(
                child: Card(
                  elevation: 2,
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () async {
                      await controller.chooseFee(controller
                          .generalValue.value.valueList!
                          .where((element) => element.type == "FEE")
                          .elementAt(index));
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                    child: SizedBox(
                      child: Padding(
                          padding: EdgeInsets.all(2.sp),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  (index + 1).toString(),
                                  style: TextStyle(fontSize: 8.sp),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  controller.generalValue.value.valueList!
                                          .where((element) =>
                                              element.type == "FEE")
                                          .elementAt(index)
                                          .key ??
                                      "",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 8.sp),
                                ),
                              ),
                              Expanded(
                                flex: 6,
                                child: Text(
                                  controller.generalValue.value.valueList!
                                          .where((element) =>
                                              element.type == "FEE")
                                          .elementAt(index)
                                          .description ??
                                      "",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(fontSize: 8.sp),
                                ),
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  ListView setListDiscount(BuildContext context) {
    return ListView.builder(
        itemCount: controller.discountList.value.listdiscount == null
            ? 0
            : controller.discountList.value.listdiscount!.length,
        itemBuilder: (context, index) {
          return Obx(
            () => Padding(
              padding: EdgeInsets.all(1.sp),
              child: SizedBox(
                child: Card(
                  elevation: 2,
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () async {
                      await controller.chooseDiscount(index);
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                    child: SizedBox(
                      child: Padding(
                          padding: EdgeInsets.all(2.sp),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  (index + 1).toString(),
                                  style: TextStyle(fontSize: 8.sp),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  controller.discountList.value.listdiscount!
                                          .elementAt(index)
                                          .name ??
                                      "",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 8.sp),
                                ),
                              ),
                              Expanded(
                                flex: 6,
                                child: Text(
                                  controller.discountList.value.listdiscount!
                                          .elementAt(index)
                                          .description ??
                                      "",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(fontSize: 8.sp),
                                ),
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget setupAlertDialoadContainer() {
    return Container(
      height: 30.h, // Change as per your requirement
      width: 100.w, // Change as per your requirement
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text('Gujarat, India'),
          );
        },
      ),
    );
  }

  Padding mergeBill(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(2.sp),
        child: Column(
          children: [
            Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(1.sp),
                  child: formMergeBill(context),
                )),
            Expanded(
                flex: 8,
                child: Container(
                    color: primaryLightGrey,
                    child: Padding(
                      padding: EdgeInsets.all(1.sp),
                      child: controller.mergeBill.value.bills!.isNotEmpty
                          ? ListView.builder(
                              itemCount:
                                  controller.mergeBill.value.bills!.length,
                              itemBuilder: (context, index) => Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 2.h),
                                    child: Obx(() => SizedBox(
                                          child: Card(
                                              child: initOrderMerge(
                                                  controller
                                                      .mergeBill.value.bills!
                                                      .elementAt(index),
                                                  context)),
                                        )),
                                  ))
                          : const Center(
                              child: Text("Masih kosong"),
                            ),
                    ))),
            Expanded(
                flex: 1,
                child: Container(
                  color: Colors.black,
                  child: ElevatedButton(
                    child: Text('Gabung', style: TextStyle(fontSize: 6.sp)),
                    onPressed: () {
                      controller.submitMerge();
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(100),
                      primary: primaryDarkGreen,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                )),
          ],
        ));
  }

  initOrderMerge(int id, BuildContext context) {
    return SizedBox(
      // height: 8.h,
      child: ListTile(
        leading: Icon(
          Icons.list,
          size: 14.sp,
        ),
        dense: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                controller.getCartMergeData(id).id.toString(),
                style: TextStyle(color: primaryGrey, fontSize: 8.sp),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                controller.converDateMillisToString(
                        controller.getCartMergeData(id).createdAt!) ??
                    '',
                textAlign: TextAlign.right,
                style: TextStyle(color: primaryGrey, fontSize: 6.sp),
              ),
            ),
          ],
        ),
        subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(1),
                child: Text(
                  controller.getCartMergeData(id).name ?? '',
                  style: TextStyle(color: primaryGrey, fontSize: 9.sp),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(1),
                child: Text(
                  controller.checkTotalEveryList(
                      controller.getCartMergeData(id).items),
                  style: TextStyle(
                      color: primaryGrey,
                      fontWeight: FontWeight.bold,
                      fontSize: 10.sp),
                ),
              ),
            ]),
      ),
    );
  }

  Form formMergeBill(BuildContext context) {
    var node = FocusScope.of(context);
    return Form(
        key: controller.formKeyMerge,
        child: Row(children: [
          Expanded(
            flex: 4,
            child: Container(
              color: Colors.amber,
              child: TextFormField(
                style: TextStyle(fontSize: 8.sp, fontWeight: FontWeight.normal),
                enabled: true,
                controller: controller.tfNameController.value,
                keyboardType: TextInputType.text,
                maxLines: null,
                expands: true,
                onSaved: (String? val) {},
                decoration: InputDecoration(
                  fillColor: primaryLightGrey,
                  filled: true,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  prefixIconConstraints: BoxConstraints(minWidth: 5.w),
                  suffixIconConstraints: BoxConstraints(minWidth: 5.w),
                  // border: outlineInputBorder,
                  hintText: "Nama *wajib",
                  // labelText: label,
                  labelStyle: const TextStyle(color: primaryGrey),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.h),
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(right: 1.w),
                    child: Icon(
                      Icons.person,
                      color: primaryGoldText,
                      size: 9.sp,
                    ),
                  ),
                ),
                onEditingComplete: () => node.nextFocus(),
              ),
            ),
          ),
          SizedBox(
            width: 1.w,
          ),
          Expanded(
            flex: 4,
            child: TextFormField(
              style: TextStyle(fontSize: 8.sp, fontWeight: FontWeight.normal),
              enabled: true,
              controller: controller.tfNoteController.value,
              keyboardType: TextInputType.text,
              maxLines: null,
              expands: true,
              onSaved: (String? val) {},
              decoration: InputDecoration(
                fillColor: primaryLightGrey,
                filled: true,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                prefixIconConstraints: BoxConstraints(minWidth: 5.w),
                suffixIconConstraints: BoxConstraints(minWidth: 5.w),
                // border: outlineInputBorder,
                hintText: "Keterangan (optional)",
                // labelText: label,
                labelStyle: const TextStyle(color: primaryGrey),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.h),
                suffixIcon: Padding(
                  padding: EdgeInsets.only(right: 1.w),
                  child: Icon(
                    Icons.note_alt,
                    color: primaryGoldText,
                    size: 9.sp,
                  ),
                ),
              ),
              onEditingComplete: () => node.nextFocus(),
            ),
          ),
          SizedBox(
            width: 1.w,
          ),
        ]));
  }

  Column checkoutListView(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 4,
          child: ListTile(
            leading: Icon(
              Icons.shopping_cart,
              size: 14.sp,
              color: primaryGoldText,
            ),
            dense: true,
            title: Text(
              "Pembayaran",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: primaryGoldText,
                  fontSize: 10.sp),
            ),
            subtitle: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Subtotal",
                        style: TextStyle(
                            fontSize: 8.sp,
                            color: primaryDarkGreen,
                            fontWeight: FontWeight.bold)),
                    Obx(
                      () => Text(
                          controller
                              .convertPrice(controller.checkOut.value.subTotal),
                          style: TextStyle(
                              fontSize: 8.sp,
                              color: primaryDarkGreen,
                              fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => Text("Diskon ${controller.discountCharge.value}",
                          style: TextStyle(
                              fontSize: 8.sp,
                              color: primaryDarkGreen,
                              fontWeight: FontWeight.bold)),
                    ),
                    Obx(
                      () => Text(
                          controller
                              .convertPrice(controller.checkOut.value.discount),
                          style: TextStyle(
                              fontSize: 8.sp,
                              color: primaryDarkGreen,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => Text("Service  ${controller.serviceCharge.value}",
                          style: TextStyle(
                              fontSize: 8.sp,
                              color: primaryDarkGreen,
                              fontWeight: FontWeight.bold)),
                    ),
                    Obx(
                      () => Text(
                          controller
                              .convertPrice(controller.checkOut.value.service),
                          style: TextStyle(
                              fontSize: 8.sp,
                              color: primaryDarkGreen,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => Text("Pajak  ${controller.taxCharge.value}",
                          style: TextStyle(
                              fontSize: 8.sp,
                              color: primaryDarkGreen,
                              fontWeight: FontWeight.bold)),
                    ),
                    Obx(
                      () => Text(
                          controller
                              .convertPrice(controller.checkOut.value.tax),
                          style: TextStyle(
                              fontSize: 8.sp,
                              color: primaryDarkGreen,
                              fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        // const Spacer(),
        Expanded(
            flex: 2,
            child: Container(
              color: Colors.transparent,
              child: Obx(
                () => ListTile(
                  leading: Icon(
                    Icons.money,
                    size: 14.sp,
                    color: primaryGoldText,
                  ),
                  title: Text(
                    controller.convertPrice(controller.checkOut.value.total),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
            )),
      ],
    );
  }

  ListView generateListViewOrder(BuildContext context) {
    return ListView.builder(
        controller: controller.scrollControllerOrderList.value,
        // itemCount: controller.allOrder.value.allOrderList!.length,
        itemCount: controller.orderList.value.length +
            (controller.allLoadedPageOrder.value ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < controller.orderList.length) {
            return Obx(() => SizedBox(
                  // height: 9.h,
                  child: Card(
                    child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: controller.orderList.elementAt(index).isDone ==
                                  'PENDING' &&
                              controller.isMerge.isFalse
                          ? () => controller.seeOrderList(index)
                          : () => controller.insertMergeBill(
                              controller.orderList.elementAt(index).id!),
                      child: Container(
                        color: (() {
                          if (controller.isMerge.isTrue) {
                            return controller.getColorChangeMerge(
                                controller.orderList.elementAt(index).id);
                          } else {
                            if (controller.order.value.id ==
                                controller.orderList.elementAt(index).id) {
                              return const Color(0x7C154D51);
                            }
                            return Colors.transparent;
                          }
                        }()),
                        height: 9.h,
                        child: ListTile(
                          leading: Icon(
                            Icons.list,
                            size: 12.sp,
                            color: controller.getColorTextChangeMerge(
                                controller.orderList.elementAt(index).id),
                          ),
                          dense: true,
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  controller.orderList
                                      .elementAt(index)
                                      .id
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 6.sp,
                                      color: controller.getColorTextChangeMerge(
                                          controller.orderList
                                              .elementAt(index)
                                              .id)),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  controller.converDateMillisToString(controller
                                          .orderList
                                          .elementAt(index)
                                          .createdAt!) ??
                                      '',
                                  style: TextStyle(
                                      fontSize: 6.sp,
                                      color: controller.getColorTextChangeMerge(
                                          controller.orderList
                                              .elementAt(index)
                                              .id)),
                                ),
                              ),
                            ],
                          ),
                          subtitle: SizedBox(
                            height: 6.h,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(1.sp),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Text(
                                        //   "Nama",
                                        //   style: TextStyle(
                                        //       fontSize: 8.sp,
                                        //       color: controller
                                        //           .getColorTextChangeMerge(
                                        //               controller.orderList
                                        //                   .elementAt(index)
                                        //                   .id)),
                                        // ),
                                        Text(
                                          controller.orderList
                                                  .elementAt(index)
                                                  .name ??
                                              '',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 9.sp,
                                              color: controller
                                                  .getColorTextChangeMerge(
                                                      controller.orderList
                                                          .elementAt(index)
                                                          .id)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: EdgeInsets.all(1.sp),
                                      child: Text(
                                        controller.checkTotalEveryList(
                                            controller.orderList
                                                .elementAt(index)
                                                .items),
                                        style: TextStyle(
                                            fontSize: 9.sp,
                                            color: controller
                                                .getColorTextChangeMerge(
                                                    controller.orderList
                                                        .elementAt(index)
                                                        .id),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )
                                ]),
                          ),
                          isThreeLine: false,
                        ),
                      ),
                    ),
                  ),
                ));
          } else {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: Center(
                child: Text("Tidak ada lagi daftar order",
                    style: TextStyle(
                      fontSize: 7.sp,
                    )),
              ),
            );
          }
        });
  }

  ListView initBodyCard(BuildContext context) {
    return ListView.builder(
      itemCount: controller.cartItem.length,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.symmetric(vertical: 1.h),
        child: Obx(
          () => initCartCard(context, index),
        ),
      ),
    );
  }

  Row initCartCard(BuildContext ctx, int idx) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color(0x53343434),
                  offset: Offset(4, 4),
                  spreadRadius: 1,
                  blurRadius: 8,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: controller.cartItem[idx].pic != 'No Pic'
                  ? Image.network(
                      controller.cartItem[idx].pic.toString(),
                    )
                  : Image.asset('assets/images/no_pic.png'),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          flex: 7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.cartItem[idx].name ?? '',
                style: TextStyle(
                    color: primaryDarkGreen,
                    fontWeight: FontWeight.w600,
                    fontSize: 6.sp),
                overflow: TextOverflow.ellipsis,
              ),
              // const SizedBox(height: 10),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${controller.convertPrice(controller.cartItem[idx].unitPrice)}",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 6.sp,
                        color: const Color(0xAF000000),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Obx(
                      () => Text(
                        'x' + controller.cartItem[idx].amount.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 7.sp,
                          color: primaryDarkGreen,
                        ),
                      ),
                    ),
                    // const SizedBox(width: 20),
                  ],
                ),
              ),
              Obx(
                () => Text(
                  "${controller.convertPrice(controller.cartItem[idx].totalPrice)}",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 8.sp,
                    color: primaryGoldText,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // LIST ORDER
  // =====================================
  ListView generateListViewOrder2(BuildContext context) {
    return ListView.builder(
        controller: controller.scrollControllerOrderList.value,
        // itemCount: controller.allOrder.value.allOrderList!.length,
        itemCount: controller.orderList.value.length +
            (controller.allLoadedPageOrder.value ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < controller.orderList.length) {
            return Obx(
              () => Card(
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: controller.orderList.elementAt(index).isDone ==
                              'PENDING' &&
                          controller.isMerge.isFalse
                      ? () => controller.seeOrderList(index)
                      : () => controller.insertMergeBill(
                          controller.orderList.elementAt(index).id!),
                  child: Container(
                    color: (() {
                      if (controller.isMerge.isTrue) {
                        return controller.getColorChangeMerge(
                            controller.orderList.elementAt(index).id);
                      } else {
                        if (controller.order.value.id ==
                            controller.orderList.elementAt(index).id) {
                          return const Color(0x7C154D51);
                        }
                        return Colors.transparent;
                      }
                      // if (controller.order.value.id ==
                      //     controller.orderList.elementAt(index).id) {
                      //   return const Color(0x7C154D51);
                      // } else if (controller.isMerge.isTrue) {
                      //   controller.getColorChangeMerge(
                      //       controller.orderList.elementAt(index).id);
                      // } else {
                      //   Colors.transparent;
                      // }
                    }()),
                    child: SizedBox(
                      // width: getProportionateScreenWidth(40),
                      // height: getProportionateScreenHeight(40),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(controller.converDateMillisToString(
                                        controller.orderList
                                            .elementAt(index)
                                            .createdAt!) ??
                                    ''),
                                Text(
                                  "No. ${controller.orderList.elementAt(index).id.toString().substring(0, 8)}xxxx",
                                  style: TextStyle(
                                      color: Color(0xFF494949),
                                      fontSize: displayWidth(context) * 0.03),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Nama'),
                                Text(
                                  controller.orderList.elementAt(index).name ??
                                      '-',
                                  style:
                                      const TextStyle(color: Color(0xFF494949)),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Meja'),
                                controller.orderList
                                        .elementAt(index)
                                        .tableIds!
                                        .isEmpty
                                    ? const Text(
                                        'Take Away',
                                        style:
                                            TextStyle(color: Color(0xFF078EEE)),
                                      )
                                    : Text(
                                        '${controller.orderList.elementAt(index).tableIds!.isEmpty ? "" : controller.checkTable(controller.orderList.elementAt(index).tableIds!)}',
                                        style: const TextStyle(
                                            color: Color(0xFFCF2727)),
                                      ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox.fromSize(
                                  size: const Size(
                                      56, 30), // button width and height
                                  child: Material(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    color: Colors.orange, // button color
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(10),
                                      splashColor: primaryBlue, // splash color
                                      onTap: controller.orderList
                                                  .elementAt(index)
                                                  .isDone ==
                                              "PENDING"
                                          ? () {
                                              // controller.printData(index);
                                            }
                                          : null, // button pressed
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(Icons.print,
                                              color: Colors.white), // icon
                                          // Text("Call"), // text
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                getStatusPayment(controller.orderList
                                    .elementAt(index)
                                    .isDone
                                    .toString()),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: const Center(
                child: Text("Tidak ada lagi daftar order"),
              ),
            );
          }
        });
  }

  getStatusPayment(String? status) {
    switch (status) {
      case 'CANCEL':
        return Container(
          constraints: const BoxConstraints(minWidth: 100),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), // <= No more error here :)
            color: const Color(0xFFdc3545),
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          margin: const EdgeInsets.only(bottom: 5.0),
          child: const Text(
            "Batal",
            style: TextStyle(fontSize: 14, color: Color(0xFFFFFFFF)),
          ), // Text
        );
      case 'SPLIT':
        return Container(
          constraints: const BoxConstraints(minWidth: 100),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), // <= No more error here :)
            color: const Color(0xFF28a745),
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          margin: const EdgeInsets.only(bottom: 5.0),
          child: const Text(
            "Pisah",
            style: TextStyle(fontSize: 14, color: Color(0xFFFFFFFF)),
          ), // Text
        );
      case 'PENDING':
        return Container(
          constraints: const BoxConstraints(minWidth: 100),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), // <= No more error here :)
            color: const Color(0xF2B88D17),
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          margin: const EdgeInsets.only(bottom: 5.0),
          child: const Text(
            "Pending",
            style: TextStyle(fontSize: 14, color: Color(0xFFFFFFFF)),
          ), // Text
        );
      default:
        return const Text('');
    }
  }

  TextButton generateButtonRefresOrder() {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
            controller.isMerge.isFalse ? primaryDarkGreen : primaryLightGrey),
        elevation: MaterialStateProperty.all(8),
        minimumSize: MaterialStateProperty.all(Size.fromHeight(6.h)),
      ),
      child: controller.loadingPageOrder.isFalse
          ? Icon(
              Icons.refresh,
              color: Colors.white,
              size: 12.sp,
            )
          : SizedBox(
              height: 1.9.h,
              width: 3.3.w,
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
                backgroundColor: Colors.blue,
                strokeWidth: 3,
              ),
            ),
      onPressed: controller.isMerge.isFalse
          ? () {
              debugPrint('Work');
              controller.refreshDataAllOrder();
              controller.getAllOrderList();
              controller.refresh();
            }
          : null,
    );
  }

  // SEARCH
  // =====================================
  Center searchField(BuildContext context) {
    return Center(
      child: Container(
          // width: 100.w,
          // height: 40.h,
          padding: EdgeInsets.all(1.sp),
          color: Colors.white.withOpacity(.2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                child: TextField(
                  controller: controller.searchController.value,
                  style: TextStyle(fontSize: 7.sp),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                            width: 1, color: primaryDarkGreen)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                            width: 1, color: primaryDarkGreen)),
                    hintText: "Cari...",
                    label: Text(
                      "Pencarian",
                      style: TextStyle(fontSize: 9.sp),
                    ),
                    filled: true,
                    fillColor: primaryLightGrey.withOpacity(.5),
                  ),
                ),
              ),
              FittedBox(
                child: InkWell(
                  onTap: () => {
                    FocusManager.instance.primaryFocus?.unfocus(),
                    controller.searchOrderList()
                  },
                  child: Icon(Icons.search_outlined, size: 14.sp),
                ),
              ),
            ],
          )),
    );
  }
}
//   @override
//   void didChangeDependencies(BuildContext context) {
//     controller.navigator = Navigator.of(context);
//     //   super.didChangeDependencies();
//   }

//   static NavigatorState of(
//     BuildContext context, {
//     bool rootNavigator = false,
//   }) {
//     // Handles the case where the input context is a navigator element.
//     NavigatorState? navigator;
//     if (context is StatefulElement && context.state is NavigatorState) {
//       navigator = context.state as NavigatorState;
//     }
//     if (rootNavigator) {
//       navigator =
//           context.findRootAncestorStateOfType<NavigatorState>() ?? navigator;
//     } else {
//       navigator =
//           navigator ?? context.findAncestorStateOfType<NavigatorState>();
//     }
//     return navigator!;
//   }
// }
