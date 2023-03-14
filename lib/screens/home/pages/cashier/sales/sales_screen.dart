import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/cashier/sales_controller.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:sizer/sizer.dart';

class SalesScreen extends GetView<SalesController> {
  static String routeName = "/sales";
  const SalesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: buildAppBar(context),
        body: body(context));
  }

  Container body(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 0.5.h),
          Expanded(
              flex: 1,
              child: Container(
                color: Colors.transparent,
                child: Row(
                  children: [
                    SizedBox(width: 0.5.w),
                    Expanded(
                      flex: 1,
                      child: Obx(() {
                        return DropdownButtonFormField<int>(
                          // key: controller.dropStatus,
                          items: controller.dbStartDate,
                          value: controller.days.value,
                          isExpanded: true,
                          style: TextStyle(fontSize: 8.sp, color: mtGrey800),
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 2.w, vertical: 1.0.h),
                            label: Text("Tanggal",
                                style: TextStyle(
                                    fontSize: 8.sp, color: mtGrey800)),
                            helperStyle:
                                TextStyle(fontSize: 8.sp, color: mtGrey800),
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
                            controller.updateStartDate(controller.days.value);
                            controller.refreshDataAll();
                            controller.getSalesList();
                          },
                        );
                      }),
                    ),
                    SizedBox(width: 0.5.w),
                    Expanded(
                      flex: 1,
                      child: Obx(() {
                        return DropdownButtonFormField<String>(
                          // key: controller.dropStatus,
                          items: controller.dDStatus,
                          value: controller.status.value,
                          isExpanded: true,
                          style: TextStyle(fontSize: 8.sp, color: mtGrey800),
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 2.w, vertical: 1.0.h),
                            label: Text("Status",
                                style: TextStyle(
                                    fontSize: 8.sp, color: mtGrey800)),
                            helperStyle:
                                TextStyle(fontSize: 8.sp, color: mtGrey800),
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
                            controller.refreshDataAll();
                            controller.getSalesList();
                          },
                        );
                      }),
                    ),
                    SizedBox(width: 0.5.w),
                    Expanded(
                      flex: 1,
                      child: Obx(() {
                        return DropdownButtonFormField<String>(
                          // key: controller.dropStatus,
                          items: controller.dDOption,
                          value: controller.option.value,
                          isExpanded: true,
                          style: TextStyle(fontSize: 8.sp, color: mtGrey800),
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 2.w, vertical: 1.0.h),
                            label: Text("Opsional Pencarian",
                                style: TextStyle(
                                    fontSize: 8.sp, color: mtGrey800)),
                            helperStyle:
                                TextStyle(fontSize: 8.sp, color: mtGrey800),
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
                            controller.option.value = value!;
                          },
                        );
                      }),
                    ),
                    SizedBox(width: 0.5.w),
                    Expanded(flex: 1, child: searchField(context)),
                  ],
                ),
              )),
          Expanded(
              flex: 8,
              child: Container(
                color: Colors.transparent,
                child: areaListView(context),
              )),
          Expanded(
              flex: 1,
              child: Container(
                color: Colors.grey,
              )),
        ],
      ),
    );
  }

  Padding areaListView(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.sp),
      child: Row(
        children: [
          Expanded(
              flex: 4,
              child: Container(
                color: Colors.transparent,
                child: Padding(
                    padding: EdgeInsets.all(1.sp),
                    child: Obx(() => generateListViewSales(context))),
              )),
          Expanded(
              flex: 6,
              child: Container(
                color: Colors.transparent,
                child: Padding(
                    padding: EdgeInsets.all(10.sp),
                    child: Column(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      "Nama :",
                                      style: TextStyle(
                                          fontSize: 9.sp,
                                          fontWeight: FontWeight.bold),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Obx(
                                      () => Text(
                                        controller.onSales.value.name ?? "",
                                        style: TextStyle(fontSize: 9.sp),
                                      ),
                                    )),
                              ],
                            )),
                        Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      "Keterangan :",
                                      style: TextStyle(
                                          fontSize: 9.sp,
                                          fontWeight: FontWeight.bold),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Obx(
                                      () => Text(
                                        controller.onSales.value.note ?? "",
                                        style: TextStyle(fontSize: 9.sp),
                                      ),
                                    )),
                              ],
                            )),
                        Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      "Sub Total :",
                                      style: TextStyle(
                                          fontSize: 9.sp,
                                          fontWeight: FontWeight.bold),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Obx(
                                      () => Text(
                                        "${controller.convertPrice(controller.onSales.value.subTotal)}",
                                        style: TextStyle(fontSize: 9.sp),
                                      ),
                                    )),
                              ],
                            )),
                        Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      "Diskon :",
                                      style: TextStyle(
                                          fontSize: 9.sp,
                                          fontWeight: FontWeight.bold),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Obx(
                                      () => Text(
                                        "${controller.convertPrice(controller.onSales.value.discount)}",
                                        style: TextStyle(fontSize: 9.sp),
                                      ),
                                    )),
                              ],
                            )),
                        Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      "Service :",
                                      style: TextStyle(
                                          fontSize: 9.sp,
                                          fontWeight: FontWeight.bold),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Obx(
                                      () => Text(
                                        "${controller.convertPrice(controller.onSales.value.service)}",
                                        style: TextStyle(fontSize: 9.sp),
                                      ),
                                    )),
                              ],
                            )),
                        Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      "Pajak :",
                                      style: TextStyle(
                                          fontSize: 9.sp,
                                          fontWeight: FontWeight.bold),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Obx(
                                      () => Text(
                                        "${controller.convertPrice(controller.onSales.value.tax)}",
                                        style: TextStyle(fontSize: 9.sp),
                                      ),
                                    )),
                              ],
                            )),
                        Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      "Total :",
                                      style: TextStyle(
                                          fontSize: 9.sp,
                                          fontWeight: FontWeight.bold),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Obx(
                                      () => Text(
                                        "${controller.convertPrice(controller.onSales.value.total)}",
                                        style: TextStyle(fontSize: 9.sp),
                                      ),
                                    )),
                              ],
                            )),
                        Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      "Tipe Pembayaran :",
                                      style: TextStyle(
                                          fontSize: 9.sp,
                                          fontWeight: FontWeight.bold),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Obx(() => Text(
                                          "${controller.seePaymentMethod(controller.onSales.value.paymentMethod)}",
                                          style: TextStyle(fontSize: 9.sp),
                                        ))),
                              ],
                            )),
                        Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      "Kasir :",
                                      style: TextStyle(
                                          fontSize: 9.sp,
                                          fontWeight: FontWeight.bold),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Obx(
                                      () => Text(
                                        controller.onSales.value.cashierName ??
                                            "",
                                        style: TextStyle(fontSize: 9.sp),
                                      ),
                                    )),
                              ],
                            )),
                        Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      "Tanggal :",
                                      style: TextStyle(
                                          fontSize: 9.sp,
                                          fontWeight: FontWeight.bold),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Obx(
                                      () => Text(
                                        controller.converDateMillisToString(
                                            controller
                                                    .onSales.value.createdAt ??
                                                DateTime.now()
                                                    .millisecondsSinceEpoch),
                                        style: TextStyle(fontSize: 9.sp),
                                      ),
                                    )),
                              ],
                            )),
                        Expanded(
                          flex: 1,
                          child: Obx(
                            () => ElevatedButton.icon(
                              label: Text('Print',
                                  style: TextStyle(fontSize: 6.sp)),
                              icon: Icon(
                                Icons.print,
                                size: 9.sp,
                              ),
                              onPressed: controller.onSales.value.id != null
                                  ? () {
                                      controller.printOnSales();
                                    }
                                  : null,
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
                        ),
                      ],
                    )),
              )),
        ],
      ),
    );
  }

  ListView generateListViewSales(BuildContext context) {
    return ListView.builder(
        controller: controller.scrollController.value,
        // itemCount: controller.allOrder.value.allOrderList!.length,
        itemCount: controller.salesList.value.length +
            (controller.allLoadedPageSales.value ? 1 : 0),
        itemBuilder: (context, index) {
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
          onTap: () => {controller.seeDetailSales(idx)},
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

  Center searchField(BuildContext context) {
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
                  controller: controller.textSearchController.value,
                  style: TextStyle(fontSize: 7.sp, color: Colors.white),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.0.h),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                            width: 1, color: primaryDarkGreen)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                            width: 1, color: primaryDarkGreen)),
                    hintText: "Cari...",
                    filled: true,
                    fillColor: primaryLightGrey.withOpacity(.5),
                  ),
                  onChanged: (value) => {controller.search.value = value},
                ),
              )),
              FittedBox(
                child: InkWell(
                  onTap: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    controller.refreshDataAll();
                    controller.getSalesList();
                  },
                  child: Icon(Icons.search_outlined,
                      size: 9.sp, color: Colors.white),
                ),
              ),
            ],
          )),
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
      title: Column(
        children: const [
          Text(
            "Daftar Penjualan",
            style: TextStyle(color: Colors.white),
          ),
          Text(
            "Kasir",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
