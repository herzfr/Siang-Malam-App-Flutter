import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/report/reportbill_controller.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:sizer/sizer.dart';

class ReportBillScreen extends GetView<ReportBillController> {
  static String routeName = " /report-bill";
  const ReportBillScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: buildAppBar(context),
        body: body(context));
  }

  Container body(BuildContext context) {
    return Container(
      child: Padding(
          padding: EdgeInsets.all(1.sp),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  child: Row(
                    children: [
                      Expanded(
                          flex: 3,
                          child: Container(
                            color: Colors.grey,
                            child: Obx(() {
                              return DropdownButtonFormField<int>(
                                // key: controller.dropStatus,
                                items: controller.subbranch,
                                value: controller.subBranchId,
                                isExpanded: true,
                                style:
                                    TextStyle(fontSize: 8.sp, color: mtGrey800),
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 2.w, vertical: 1.0.h),
                                  label: Text("Cabang",
                                      style: TextStyle(
                                          fontSize: 8.sp, color: mtGrey800)),
                                  helperStyle: TextStyle(
                                      fontSize: 8.sp, color: mtGrey800),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 2, color: primaryGrey),
                                    borderRadius: BorderRadius.circular(1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 2, color: primaryGrey),
                                    borderRadius: BorderRadius.circular(1),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 2, color: primaryGrey),
                                    borderRadius: BorderRadius.circular(1),
                                  ),
                                ),
                                onChanged: (value) {
                                  controller.subBranchId = value!;
                                },
                              );
                            }),
                          )),
                      SizedBox(
                        width: 0.5.w,
                      ),
                      Expanded(
                          flex: 3,
                          child: Container(
                            color: Colors.brown,
                            child: Obx(() {
                              return DropdownButtonFormField<int>(
                                // key: controller.dropStatus,
                                items: controller.dbStartDate,
                                value: controller.days.value,
                                isExpanded: true,
                                style:
                                    TextStyle(fontSize: 8.sp, color: mtGrey800),
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 2.w, vertical: 1.0.h),
                                  label: Text("Tanggal",
                                      style: TextStyle(
                                          fontSize: 8.sp, color: mtGrey800)),
                                  helperStyle: TextStyle(
                                      fontSize: 8.sp, color: mtGrey800),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 2, color: primaryGrey),
                                    borderRadius: BorderRadius.circular(1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 2, color: primaryGrey),
                                    borderRadius: BorderRadius.circular(1),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 2, color: primaryGrey),
                                    borderRadius: BorderRadius.circular(1),
                                  ),
                                ),
                                onChanged: (value) {
                                  controller.days.value = value!;
                                  controller
                                      .updateStartDate(controller.days.value);
                                },
                              );
                            }),
                          )),
                      SizedBox(
                        width: 0.5.w,
                      ),
                      Expanded(
                          flex: 3,
                          child: Container(
                            color: Colors.blueGrey,
                            child: Obx(() {
                              return DropdownButtonFormField<String>(
                                // key: controller.dropStatus,
                                items: controller.dbOptionShift,
                                value: controller.status.value,
                                isExpanded: true,
                                style:
                                    TextStyle(fontSize: 8.sp, color: mtGrey800),
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 2.w, vertical: 1.0.h),
                                  label: Text("Status",
                                      style: TextStyle(
                                          fontSize: 8.sp, color: mtGrey800)),
                                  helperStyle: TextStyle(
                                      fontSize: 8.sp, color: mtGrey800),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 2, color: primaryGrey),
                                    borderRadius: BorderRadius.circular(1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 2, color: primaryGrey),
                                    borderRadius: BorderRadius.circular(1),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 2, color: primaryGrey),
                                    borderRadius: BorderRadius.circular(1),
                                  ),
                                ),
                                onChanged: (value) {
                                  controller.status.value = value!;
                                },
                              );
                            }),
                          )),
                      SizedBox(
                        width: 0.5.w,
                      ),
                      Expanded(
                        flex: 1,
                        child: ElevatedButton.icon(
                          label: Text('Cari', style: TextStyle(fontSize: 6.sp)),
                          icon: Icon(
                            Icons.search,
                            size: 9.sp,
                          ),
                          onPressed: () {
                            controller.findItShift();
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(100),
                            primary: primaryGoldText,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 9,
                child: Container(
                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                            color: Colors.grey,
                            child: Obx(
                              () => controller.loadingPageShift.isTrue
                                  ? Center(
                                      child: SizedBox(
                                        height: 1.9.h,
                                        width: 3.3.w,
                                        child: const CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation(
                                              Colors.white),
                                          backgroundColor: Colors.blue,
                                          strokeWidth: 3,
                                        ),
                                      ),
                                    )
                                  : controller.shiftList.isNotEmpty
                                      ? generateListViewShift(context)
                                      : Center(
                                          child: Text(
                                          "Tidak Ada Data Shift",
                                          style: TextStyle(fontSize: 9.sp),
                                        )),
                            ),
                          )),
                      Expanded(
                          flex: 1,
                          child: Container(
                            color: primaryLightGrey,
                            child: Obx(
                              () => controller.loadingPageSales.isTrue
                                  ? Center(
                                      child: SizedBox(
                                        height: 1.9.h,
                                        width: 3.3.w,
                                        child: const CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation(
                                              Colors.white),
                                          backgroundColor: Colors.blue,
                                          strokeWidth: 3,
                                        ),
                                      ),
                                    )
                                  : controller.salesList.isNotEmpty
                                      ? generateListViewSales(context)
                                      : Center(
                                          child: Text(
                                          "Data penjualan kosong",
                                          style: TextStyle(fontSize: 9.sp),
                                        )),
                            ),
                          )),
                      Expanded(
                          flex: 1,
                          child: Container(
                            color: Colors.transparent,
                            child: Container(
                              color: Colors.transparent,
                              child: Padding(
                                  padding: EdgeInsets.all(10.sp),
                                  child: Column(
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    "Nama :",
                                                    style: TextStyle(
                                                        fontSize: 7.sp,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                              Expanded(
                                                  flex: 1,
                                                  child: Obx(
                                                    () => Text(
                                                      controller.onSales.value
                                                              .name ??
                                                          "",
                                                      style: TextStyle(
                                                          fontSize: 7.sp),
                                                    ),
                                                  )),
                                            ],
                                          )),
                                      Expanded(
                                          flex: 1,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    "Keterangan :",
                                                    style: TextStyle(
                                                        fontSize: 7.sp,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                              Expanded(
                                                  flex: 1,
                                                  child: Obx(
                                                    () => Text(
                                                      controller.onSales.value
                                                              .note ??
                                                          "",
                                                      style: TextStyle(
                                                          fontSize: 7.sp),
                                                    ),
                                                  )),
                                            ],
                                          )),
                                      Expanded(
                                          flex: 1,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    "Sub Total :",
                                                    style: TextStyle(
                                                        fontSize: 7.sp,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                              Expanded(
                                                  flex: 1,
                                                  child: Obx(
                                                    () => Text(
                                                      "${controller.convertPrice(controller.onSales.value.subTotal)}",
                                                      style: TextStyle(
                                                          fontSize: 7.sp),
                                                    ),
                                                  )),
                                            ],
                                          )),
                                      Expanded(
                                          flex: 1,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    "Diskon :",
                                                    style: TextStyle(
                                                        fontSize: 7.sp,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                              Expanded(
                                                  flex: 1,
                                                  child: Obx(
                                                    () => Text(
                                                      "${controller.convertPrice(controller.onSales.value.discount)}",
                                                      style: TextStyle(
                                                          fontSize: 7.sp),
                                                    ),
                                                  )),
                                            ],
                                          )),
                                      Expanded(
                                          flex: 1,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    "Service :",
                                                    style: TextStyle(
                                                        fontSize: 7.sp,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                              Expanded(
                                                  flex: 1,
                                                  child: Obx(
                                                    () => Text(
                                                      "${controller.convertPrice(controller.onSales.value.service)}",
                                                      style: TextStyle(
                                                          fontSize: 7.sp),
                                                    ),
                                                  )),
                                            ],
                                          )),
                                      Expanded(
                                          flex: 1,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    "Pajak :",
                                                    style: TextStyle(
                                                        fontSize: 7.sp,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                              Expanded(
                                                  flex: 1,
                                                  child: Obx(
                                                    () => Text(
                                                      "${controller.convertPrice(controller.onSales.value.tax)}",
                                                      style: TextStyle(
                                                          fontSize: 7.sp),
                                                    ),
                                                  )),
                                            ],
                                          )),
                                      Expanded(
                                          flex: 1,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    "Total :",
                                                    style: TextStyle(
                                                        fontSize: 7.sp,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                              Expanded(
                                                  flex: 1,
                                                  child: Obx(
                                                    () => Text(
                                                      "${controller.convertPrice(controller.onSales.value.total)}",
                                                      style: TextStyle(
                                                          fontSize: 7.sp),
                                                    ),
                                                  )),
                                            ],
                                          )),
                                      Expanded(
                                          flex: 1,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    "Tipe Pembayaran :",
                                                    style: TextStyle(
                                                        fontSize: 7.sp,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                              Expanded(
                                                  flex: 1,
                                                  child: Obx(() => Text(
                                                        "${controller.seePaymentMethod(controller.onSales.value.paymentMethod)}",
                                                        style: TextStyle(
                                                            fontSize: 7.sp),
                                                      ))),
                                            ],
                                          )),
                                      Expanded(
                                          flex: 1,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    "Kasir :",
                                                    style: TextStyle(
                                                        fontSize: 7.sp,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                              Expanded(
                                                  flex: 1,
                                                  child: Obx(
                                                    () => Text(
                                                      controller.onSales.value
                                                              .cashierName ??
                                                          "",
                                                      style: TextStyle(
                                                          fontSize: 7.sp),
                                                    ),
                                                  )),
                                            ],
                                          )),
                                      Expanded(
                                          flex: 1,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    "Waiters :",
                                                    style: TextStyle(
                                                        fontSize: 7.sp,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                              Expanded(
                                                  flex: 1,
                                                  child: Obx(
                                                    () => Text(
                                                      controller.onSales.value
                                                              .waiterName ??
                                                          "",
                                                      style: TextStyle(
                                                          fontSize: 7.sp),
                                                    ),
                                                  )),
                                            ],
                                          )),
                                      Expanded(
                                          flex: 1,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    "Tanggal :",
                                                    style: TextStyle(
                                                        fontSize: 7.sp,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                              Expanded(
                                                  flex: 1,
                                                  child: Obx(
                                                    () => Text(
                                                      controller.converDateMillisToString(
                                                          controller
                                                                  .onSales
                                                                  .value
                                                                  .createdAt ??
                                                              DateTime.now()
                                                                  .millisecondsSinceEpoch),
                                                      style: TextStyle(
                                                          fontSize: 7.sp),
                                                    ),
                                                  )),
                                            ],
                                          )),
                                    ],
                                  )),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }

  ListView generateListViewSales(BuildContext context) {
    return ListView.builder(
        controller: controller.scrollControllerSales.value,
        shrinkWrap: false,
        itemCount: controller.salesList.length +
            (controller.allLoadedPageSales.value ? 1 : 0),
        itemBuilder: (context, index) {
          // print("ini index ${(index + 1)}");
          // print(controller.shiftList.length);
          if (index < controller.salesList.length) {
            return Obx(
              () => initSalesCard(context, index),
            );
          } else {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: Center(
                child: Text("Tidak ada lagi daftar penjualan",
                    style: TextStyle(
                      fontSize: 7.sp,
                    )),
              ),
            );
          }
        });
  }

  ListView generateListViewShift(BuildContext context) {
    return ListView.builder(
        controller: controller.scrollControllerShift.value,
        shrinkWrap: false,
        itemCount: controller.shiftList.length +
            (controller.allLoadedPageShift.value ? 1 : 0),
        itemBuilder: (context, index) {
          // print("ini index ${(index + 1)}");
          // print(controller.shiftList.length);
          if (index < controller.shiftList.length) {
            return Obx(
              () => initShiftCard(context, index),
            );
          } else {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: Center(
                child: Text("Tidak ada lagi daftar kasbon",
                    style: TextStyle(
                      fontSize: 7.sp,
                    )),
              ),
            );
          }
        });
  }

  Card initSalesCard(BuildContext ctx, int idx) {
    return Card(
      elevation: 4,
      color:
          controller.onSales.value.id == controller.salesList.elementAt(idx).id
              ? primaryDarkGreen
              : Colors.white,
      child: Padding(
        padding: EdgeInsets.all(2.sp),
        child: InkWell(
          onTap: () =>
              {controller.onSales.value = controller.salesList.elementAt(idx)},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => Row(children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      controller.salesList[idx].name ?? '',
                      style: TextStyle(
                          color: controller.onSales.value.id ==
                                  controller.salesList.elementAt(idx).id
                              ? primaryLightGrey
                              : primaryDarkGreen,
                          fontWeight: FontWeight.w600,
                          fontSize: 6.sp),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      controller.salesList[idx].cashierName ?? '',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: controller.onSales.value.id ==
                                  controller.salesList.elementAt(idx).id
                              ? primaryLightGrey
                              : primaryDarkGreen,
                          fontWeight: FontWeight.w600,
                          fontSize: 6.sp),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ]),
              ),
              // const SizedBox(height: 10),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      controller.salesList[idx].status == 'DEBT'
                          ? 'DEBIT'
                          : 'TUNAI',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 6.sp,
                        color: controller.onSales.value.id ==
                                controller.salesList.elementAt(idx).id
                            ? primaryLightGrey
                            : primaryDarkGreen,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Obx(
                      () => Text(
                        controller.salesList[idx].items!.length.toString() +
                            " ITEM",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 7.sp,
                          color: controller.onSales.value.id ==
                                  controller.salesList.elementAt(idx).id
                              ? primaryLightGrey
                              : primaryDarkGreen,
                        ),
                      ),
                    ),
                    // const SizedBox(width: 20),
                  ],
                ),
              ),
              Obx(
                () => Text(
                  "${controller.convertPrice(controller.salesList[idx].total)}",
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
      ),
    );
  }

  Card initShiftCard(BuildContext ctx, int idx) {
    return Card(
      elevation: 4,
      color: controller.selectedShift.value.id ==
              controller.shiftList.elementAt(idx).id
          ? primaryDarkGreen
          : Colors.white,
      child: Padding(
        padding: EdgeInsets.all(2.sp),
        child: InkWell(
          onTap: () => {
            controller.selectedShift.value =
                controller.shiftList.elementAt(idx),
            controller.selectedShift.refresh(),
            controller.getFirstSalesData()
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => Row(children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      controller.shiftList[idx].startTime ?? '',
                      style: TextStyle(
                          color: controller.selectedShift.value.id ==
                                  controller.shiftList.elementAt(idx).id
                              ? primaryLightGrey
                              : primaryDarkGreen,
                          fontWeight: FontWeight.w600,
                          fontSize: 6.sp),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      controller.shiftList[idx].endTime ?? '',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: controller.selectedShift.value.id ==
                                  controller.shiftList.elementAt(idx).id
                              ? primaryLightGrey
                              : primaryDarkGreen,
                          fontWeight: FontWeight.w600,
                          fontSize: 6.sp),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ]),
              ),
              // const SizedBox(height: 10),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      controller.shiftList[idx].name ?? "",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 6.sp,
                        color: controller.selectedShift.value.id ==
                                controller.shiftList.elementAt(idx).id
                            ? primaryLightGrey
                            : primaryDarkGreen,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Obx(
                      () => Text(
                        controller.shiftList[idx].username ?? "",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 7.sp,
                          color: controller.selectedShift.value.id ==
                                  controller.shiftList.elementAt(idx).id
                              ? primaryLightGrey
                              : primaryDarkGreen,
                        ),
                      ),
                    ),
                    // const SizedBox(width: 20),
                  ],
                ),
              ),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Kas Awal",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 6.sp,
                        color: controller.selectedShift.value.id ==
                                controller.shiftList.elementAt(idx).id
                            ? primaryLightGrey
                            : primaryDarkGreen,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Obx(
                      () => Text(
                        controller
                            .convertPrice(controller.shiftList[idx].startCash),
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 6.sp,
                          color: primaryGoldText,
                        ),
                      ),
                    ),
                    // const SizedBox(width: 20),
                  ],
                ),
              ),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Kas Akhir",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 6.sp,
                        color: controller.selectedShift.value.id ==
                                controller.shiftList.elementAt(idx).id
                            ? primaryLightGrey
                            : primaryDarkGreen,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Obx(
                      () => Text(
                        controller
                            .convertPrice(controller.shiftList[idx].endCash),
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 6.sp,
                          color: primaryGoldText,
                        ),
                      ),
                    ),
                    // const SizedBox(width: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: primaryDarkGreen,
      leading: IconButton(
        padding: EdgeInsets.only(left: 0.w),
        onPressed: () {
          Get.back();
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
      ),
      title: Text(
        "Laporan Bill",
        style: TextStyle(color: Colors.white, fontSize: 9.sp),
      ),
    );
  }
}
