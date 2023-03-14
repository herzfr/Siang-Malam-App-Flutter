import 'dart:developer';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/cashier/cashier_controller.dart';
import 'package:siangmalam/commons/controllers/cashier/orderlist_controller.dart';
import 'package:siangmalam/commons/custom_style.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/models/cashier/shift.dart';
import 'package:siangmalam/services/app_static.dart';
import 'package:siangmalam/widgets/custom_input.dart';
import 'package:sizer/sizer.dart';

class CashierScreen extends GetView<CashierController> {
  static String routeName = "/cashier";

  //  Padding(
  //              padding: EdgeInsets.only(
  //              bottom: MediaQuery.of(context).viewInsets.bottom));
  //  resizeToAvoidBottomInset: false,

  // AnimatedSwitcher(
  //           duration: const Duration(milliseconds: 500),
  //           transitionBuilder: (Widget child, Animation<double> animation) =>
  //               ScaleTransition(
  //                 scale: animation,
  //                 child: child,
  //               ),
  //           child: Container()),

  const CashierScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final CashierController _tabx = Get.put(CashierController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: buildAppBar(context),
      body: Container(
          color: Colors.transparent,
          child: Column(
            children: [
              SizedBox(
                height: 2.h,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.transparent,
                  child: generateAppBar(),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  color: Colors.black,
                  child: Row(
                    // mainAxisSize: MainAxisSize.max,
                    children: dataListButton(context),
                  ),
                ),
              ),
              Expanded(
                  flex: 6,
                  child: Container(
                    color: Colors.transparent,
                    child: listDetailShift(context),
                  )),
            ],
          )),
    );
  }

  Row listDetailShift(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 5,
            child: Container(
              color: Colors.transparent,
              child: formStartingCash(context),
            )),
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(2.sp),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 1,
                      offset: Offset(0, 0),
                      blurRadius: 8,
                    ),
                  ],
                  image: const DecorationImage(
                    image: AssetImage("assets/images/background_idcard.png"),
                    fit: BoxFit.cover,
                  )),
              child: Column(
                children: [
                  SizedBox(
                    height: 5.h,
                  ),
                  Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
                      child: Container(
                          color: Colors.transparent,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                    color: Colors.transparent,
                                    // height: 20.h,
                                    // width: 20.w,
                                    child: FittedBox(
                                      fit: BoxFit.fill,
                                      child: AppStatic.userData.picture != null
                                          ? CircleAvatar(
                                              radius: 10.0,
                                              backgroundImage: NetworkImage(
                                                  AppStatic.userData.picture!),
                                              backgroundColor:
                                                  Colors.transparent,
                                            )
                                          : const CircleAvatar(
                                              radius: 10.0,
                                              backgroundImage: AssetImage(
                                                  "assets/images/useravatar.png"),
                                              backgroundColor:
                                                  Colors.transparent,
                                            ),
                                    )),
                              ),
                              Expanded(
                                flex: 7,
                                child: generateListShiftDataSales(),
                              )
                            ],
                          )))
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Form formStartingCash(BuildContext context) {
    var node = FocusScope.of(context);
    return Form(
      key: controller.formKeyShift,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Obx(
                () => Padding(
                  padding: EdgeInsets.all(1.sp),
                  child: TextFormField(
                    enabled: controller.shiftData.value == ShiftObj()
                        ? false
                        : controller.shiftData.value.status == 'OPEN'
                            ? false
                            : true,
                    style: TextStyle(fontSize: 8.sp, color: mtGrey800),
                    controller: controller.tStartCashController.value,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      CurrencyTextInputFormatter(
                        locale: 'id',
                        decimalDigits: 0,
                        symbol: 'Rp ',
                      ),
                    ],
                    onSaved: (String? val) {},
                    validator: ValidationBuilder(
                            requiredMessage:
                                "Mohon diisi terlebih dahulu, isi 0 jika tidak ada nilai dan ingin memulai shift")
                        .build(),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      isDense: true,
                      label: Text(
                        "Kas Penjualan Awal",
                        style: TextStyle(fontSize: 8.sp),
                      ),
                      enabledBorder: outlineInputBorder,
                      border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: primaryLightGrey),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: primaryDarkGreen),
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    // onEditingComplete: () => node.nextFocus(),
                    onFieldSubmitted: (value) {
                      // controller.priceOnSubmit(index, value);
                    },
                    // onChanged: (value) => {},
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 1.5.h,
            ),
            // Expanded(
            //   flex: 1,
            //   child: Obx(
            //     () => Padding(
            //       padding: EdgeInsets.all(1.sp),
            //       child: TextFormField(
            //         enabled: controller.shiftData.value.status == 'CLOSE'
            //             ? true
            //             : false,
            //         style: TextStyle(fontSize: 8.sp, color: mtGrey800),
            //         controller: controller.tStartCashOprationalController.value,
            //         keyboardType: TextInputType.number,
            //         inputFormatters: <TextInputFormatter>[
            //           CurrencyTextInputFormatter(
            //             locale: 'id',
            //             decimalDigits: 0,
            //             symbol: 'Rp ',
            //           ),
            //         ],
            //         onSaved: (String? val) {},
            //         validator: ValidationBuilder(
            //                 requiredMessage:
            //                     "Mohon diisi terlebih dahulu, isi 0 jika tidak ada nilai dan ingin memulai shift")
            //             .build(),
            //         decoration: InputDecoration(
            //           fillColor: Colors.white,
            //           filled: true,
            //           isDense: true,
            //           label: Text(
            //             "Kas Operasional Awal",
            //             style: TextStyle(fontSize: 8.sp),
            //           ),
            //           enabledBorder: outlineInputBorder,
            //           border: OutlineInputBorder(
            //             borderSide:
            //                 const BorderSide(width: 1, color: primaryLightGrey),
            //             borderRadius: BorderRadius.circular(40),
            //           ),
            //           focusedBorder: OutlineInputBorder(
            //             borderSide:
            //                 const BorderSide(width: 1, color: primaryDarkGreen),
            //             borderRadius: BorderRadius.circular(40),
            //           ),
            //         ),
            //         // onEditingComplete: () => node.nextFocus(),
            //         onFieldSubmitted: (value) {
            //           // controller.priceOnSubmit(index, value);
            //         },
            //         // onChanged: (value) => {},
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 1.5.h,
            ),
            Expanded(
              flex: 1,
              child: Obx(
                () => Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: TextFormField(
                    enabled: controller.shiftData.value == ShiftObj()
                        ? false
                        : controller.shiftData.value.status == 'OPEN'
                            ? true
                            : false,
                    style: TextStyle(fontSize: 8.sp, color: mtGrey800),
                    controller: controller.tAddCashController.value,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      CurrencyTextInputFormatter(
                        locale: 'id',
                        decimalDigits: 0,
                        symbol: 'Rp ',
                      ),
                    ],
                    onSaved: (String? val) {},
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      isDense: true,
                      label: Text(
                        "Penambahan Kas",
                        style: TextStyle(fontSize: 8.sp),
                      ),
                      enabledBorder: outlineInputBorder,
                      border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: primaryLightGrey),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: primaryDarkGreen),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      suffixIconConstraints: BoxConstraints(
                        minWidth: 10.w,
                        minHeight: 1.h,
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                      suffixIcon: CircleAvatar(
                        radius: 30,
                        backgroundColor: primaryDarkGreen,
                        child: IconButton(
                            color: primaryDarkGreen,
                            icon: Icon(
                              Icons.add,
                              size: 9.sp,
                              color: primaryLightGrey,
                            ),
                            onPressed: () async {
                              controller.updateCash();
                            }),
                      ),
                    ),
                    // onEditingComplete: () => node.nextFocus(),
                    // onFieldSubmitted: (value) {
                    //   // controller.priceOnSubmit(index, value);
                    // },
                    // onChanged: (value) => {},
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 0.5.h,
            ),
            SizedBox(
              // height: 1.5.h,
              child: Text(
                "Celengan",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 6.sp,
                    color: primaryBlue,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
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
                    child: Obx(
                      () => Text(
                        controller.convertPrice(
                            controller.savingMoney.value.savingAmount),
                        style: TextStyle(
                            fontSize: 6.sp,
                            fontWeight: FontWeight.bold,
                            color: primaryGoldText),
                      ),
                    ),
                  ),
                ),
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
                          child: Obx(
                            () => ElevatedButton.icon(
                              label: Text('Masukan Celengan',
                                  style: TextStyle(fontSize: 6.sp)),
                              icon: Icon(
                                Icons.input,
                                size: 9.sp,
                              ),
                              onPressed:
                                  controller.shiftData.value.id != ShiftObj().id
                                      ? controller.savingMoney.value.id != null
                                          ? () => {controller.addSavingMoney()}
                                          : null
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
                          )),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                          padding: EdgeInsets.all(1.sp),
                          child: Obx(
                            () => ElevatedButton.icon(
                              label: Text('Cek Celengan',
                                  style: TextStyle(fontSize: 6.sp)),
                              icon: controller.isCheckPiggy.isFalse
                                  ? Icon(
                                      Icons.refresh,
                                      size: 9.sp,
                                    )
                                  : Icon(
                                      Icons.donut_large,
                                      size: 9.sp,
                                    ),
                              onPressed: () => {controller.checkPiggy()},
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(100),
                                primary: controller.isCheckPiggy.isFalse
                                    ? primaryBlue
                                    : const Color(0xFF841F18),
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                            ),
                          )),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  ListTile generateListShiftDataSales() {
    return ListTile(
      title: Obx(
        () => Text(
          controller.shiftData.value.name ?? "-",
          style: TextStyle(
              color: primaryGoldText,
              fontWeight: FontWeight.w600,
              fontSize: 10.sp),
        ),
      ),
      dense: true,
      trailing: const Icon(Icons.filter_tilt_shift),
      subtitle: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.all(1.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      "Mulai Shift",
                      style: TextStyle(
                          color: primaryGoldText,
                          fontWeight: FontWeight.w600,
                          fontSize: 7.sp),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Obx(
                      () => Text(
                        controller.shiftData.value.startTime ?? "-",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: primaryDarkGreen,
                            fontWeight: FontWeight.w500,
                            fontSize: 7.sp),
                      ),
                    ),
                  ),
                ],
              )),
          Padding(
              padding: EdgeInsets.all(1.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      "Akhir Shift",
                      style: TextStyle(
                          color: primaryGoldText,
                          fontWeight: FontWeight.w600,
                          fontSize: 7.sp),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Obx(
                      () => Text(
                        controller.shiftData.value.endTime ?? "-",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: primaryDarkGreen,
                            fontWeight: FontWeight.w500,
                            fontSize: 7.sp),
                      ),
                    ),
                  ),
                ],
              )),
          Padding(
              padding: const EdgeInsets.all(1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      "Produk Terjual",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: primaryGoldText,
                          fontWeight: FontWeight.w600,
                          fontSize: 7.sp),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Obx(
                      () => Text(
                        controller.shiftData.value.totalOrder == null
                            ? "0"
                            : controller.shiftData.value.totalOrder.toString(),
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: primaryDarkGreen,
                            fontWeight: FontWeight.w500,
                            fontSize: 7.sp),
                      ),
                    ),
                  ),
                ],
              )),
          Padding(
              padding: EdgeInsets.all(1.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      "Cash Awal",
                      style: TextStyle(
                          color: primaryGoldText,
                          fontWeight: FontWeight.w600,
                          fontSize: 7.sp),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Obx(
                      () => Text(
                        controller
                            .convertPrice(controller.shiftData.value.startCash),
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: primaryDarkGreen,
                            fontWeight: FontWeight.w500,
                            fontSize: 7.sp),
                      ),
                    ),
                  ),
                ],
              )),
          Padding(
              padding: EdgeInsets.all(1.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      "Operasional Awal",
                      style: TextStyle(
                          color: primaryGoldText,
                          fontWeight: FontWeight.w600,
                          fontSize: 7.sp),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Obx(
                      () => Text(
                        controller.convertPrice(
                            controller.shiftData.value.startOperationalCash),
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: primaryDarkGreen,
                            fontWeight: FontWeight.w500,
                            fontSize: 7.sp),
                      ),
                    ),
                  )
                ],
              )),
          Padding(
              padding: EdgeInsets.all(1.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      "Cash Akhir",
                      style: TextStyle(
                          color: primaryGoldText,
                          fontWeight: FontWeight.w600,
                          fontSize: 7.sp),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Obx(
                      () => Text(
                        controller
                            .convertPrice(controller.shiftData.value.endCash),
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: primaryDarkGreen,
                            fontWeight: FontWeight.w500,
                            fontSize: 7.sp),
                      ),
                    ),
                  )
                ],
              )),
          Padding(
              padding: EdgeInsets.all(1.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      "Operasional Akhir",
                      style: TextStyle(
                          color: primaryGoldText,
                          fontWeight: FontWeight.w600,
                          fontSize: 7.sp),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Obx(
                      () => Text(
                        controller.convertPrice(
                            controller.shiftData.value.endOperationalCash),
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: primaryDarkGreen,
                            fontWeight: FontWeight.w500,
                            fontSize: 7.sp),
                      ),
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }

  Container generateAppBar() {
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(horizontal: 1.w),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: Material(
                color: Colors.white,
                child: Center(
                  child: Ink(
                    decoration: const ShapeDecoration(
                      color: primaryDarkGreen,
                      shape: CircleBorder(),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      color: Colors.white,
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
              flex: 2,
              child: Container(
                color: Colors.transparent,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(2.sp),
                      child: Center(
                          child: Image(
                              width: 9.w,
                              // height: 2.h,
                              fit: BoxFit.fill,
                              image: const AssetImage(
                                  "assets/images/sm_logo.png"))),
                    ),
                    SizedBox(
                      width: 1.w,
                    ),
                    Expanded(
                        child: Obx(
                      () => Padding(
                        padding: EdgeInsets.all(2.sp),
                        child: controller.shiftData.value.id != ShiftObj().id
                            ? Obx(
                                () => ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary:
                                          controller.shiftData.value.status ==
                                                  'CLOSE'
                                              ? primaryDarkGreen
                                              : primaryGreen,
                                      minimumSize: const Size.fromHeight(
                                          double.infinity),
                                      elevation: 5),
                                  onPressed:
                                      controller.shiftData.value.status ==
                                              'CLOSE'
                                          ? () => {controller.startShiftNow()}
                                          : () => {controller.endShiftNow()},
                                  child: Text(
                                    controller.shiftData.value.status == 'CLOSE'
                                        ? "Mulai Shift"
                                        : "Akhiri Shift",
                                    style: TextStyle(fontSize: 7.sp),
                                  ),
                                ),
                              )
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: primaryDarkGreen,
                                    minimumSize:
                                        const Size.fromHeight(double.infinity),
                                    elevation: 5),
                                onPressed: () => {controller.startShiftNow()},
                                child: Text(
                                  "Mulai Shift",
                                  style: TextStyle(fontSize: 7.sp),
                                ),
                              ),
                      ),
                    )),
                  ],
                ),
              )),
          // const Spacer(),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          "Kasir",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.bold,
                              color: primaryDarkGreen),
                        ),
                      ),
                    ),
                    Text(
                      "Pusat ${AppStatic.userData.branch!}",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: primaryGoldText),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.h, vertical: 1.h),
              child: Obx(() {
                return DropdownButtonFormField<int>(
                  // key: controller.dropStatus,
                  items: controller.dDBranch,
                  value: controller.subBranchId,
                  isExpanded: true,
                  style: TextStyle(fontSize: 8.sp, color: mtGrey800),
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 2.h, vertical: 0.h),
                    label: Text("Cabang",
                        style: TextStyle(fontSize: 8.sp, color: mtGrey800)),
                    helperStyle: TextStyle(fontSize: 8.sp, color: mtGrey800),
                    enabledBorder: outlineInputBorder,
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 5, color: primaryGrey),
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                  onChanged: controller.shiftData.value.status == 'OPEN'
                      ? null
                      : (value) {
                          controller.subBranchId = value;
                          controller.checkShiftData();
                          // controller.clearCreateOrder();
                          // controller.checkOptionType();
                          // controller.refreshDataMenu();
                        },
                );
              }),
            ),
          ),
          Expanded(
            flex: 2,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Obx(() => Center(
                            child: Text(
                          controller.counter.value,
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey),
                        ))),
                    Center(
                        child: Text(
                      AppStatic.userData.firstName! +
                          " " +
                          AppStatic.userData.lastName!,
                      style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold,
                          color: primaryDarkGreen),
                    )),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> dataListButton(BuildContext context) {
    List<Widget> list = [];
    for (var item in controller.itemsDrawer) {
      list.add(generateButtonView(context, item));
    }
    return list; // all widget added now retrun the list here
  }

  Widget generateButtonView(BuildContext context, dynamic item) {
    return Expanded(
      child: Material(
        child: Obx(
          () => InkWell(
            onTap: controller.shiftData.value != ShiftObj()
                ? controller.shiftData.value.status == 'OPEN'
                    ? () => Get.toNamed(item["route"])!.then((value) => {
                          if (value) {controller.checkShiftData()}
                        })
                    : null
                : null,
            child: Container(
              margin: EdgeInsets.all(10.sp),
              decoration: BoxDecoration(
                color: controller.shiftData.value.status == 'CLOSE'
                    ? primaryGrey
                    : primaryLightGrey,
                borderRadius: BorderRadius.circular(15),
                boxShadow: controller.shiftData.value.status == 'OPEN'
                    ? const [
                        BoxShadow(
                          color: primaryDarkGreen,
                          offset: Offset(4, 4),
                          blurRadius: 8,
                          spreadRadius: 1,
                        ),
                        BoxShadow(
                          color: Color(0x10e7e6e1),
                          offset: Offset(0, 0),
                          blurRadius: 8,
                          spreadRadius: 2,
                        )
                      ]
                    : null,
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      flex: 7,
                      child: Padding(
                        padding: EdgeInsets.all(5.sp),
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: Icon(
                            item["icons"],
                            color: const Color(0xFF154d51),
                            size: 5.sp,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: EdgeInsets.all(4.sp),
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: Text(
                            item["key"],
                            style: TextStyle(
                                color:
                                    controller.shiftData.value.status == 'CLOSE'
                                        ? primaryDarkGreen
                                        : primaryGoldText,
                                fontWeight: FontWeight.bold,
                                fontSize: 10.sp),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
        backgroundColor: primaryYellow,
        leading: Row(
          children: [
            IconButton(
              padding: EdgeInsets.only(left: 2.w),
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
            const Expanded(child: Text("RM Siang Malam"))
          ],
        ),
        title: Container(
          color: Colors.transparent,
          child: const Expanded(
            child: Text(
              "Kasir",
              textScaleFactor: 2,
              style: TextStyle(color: Colors.black),
            ),
          ),
        ));
  }
}
