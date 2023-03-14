import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/report/reportcashbon_controller.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/widgets/custom_input.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ReportCashbonScreen extends GetView<ReportCashbonController> {
  static String routeName = " /report-cashbon";
  const ReportCashbonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.panelHeightOpen = 60.h;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: buildAppBar(context),
      body: SlidingUpPanel(
        maxHeight: controller.panelHeightOpen,
        minHeight: controller.panelHeightClosed,
        controller: controller.pcs,
        parallaxEnabled: true,
        parallaxOffset: .10,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
        panel: Center(
          child: filter(context),
        ),
        body: body(context),
      ),
    );
  }

  Container filter(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.arrow_drop_up,
              color: primaryGrey,
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              flex: 1,
              child: DropdownButtonFormField<int>(
                // key: controller.dropStatus,
                items: controller.subbranch,
                value: controller.subBranchId,
                decoration:
                    CustomFormWidget.customInputDecoration('', 'Cabang'),
                onChanged: (value) {
                  controller.subBranchId = value!;
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              flex: 1,
              child: Obx(() {
                return DropdownButtonFormField<int>(
                  // key: controller.dropStatus,
                  items: controller.dbStartDate,
                  value: controller.days.value,
                  decoration:
                      CustomFormWidget.customInputDecoration('', 'Tanggal'),
                  onChanged: (value) {
                    controller.days.value = value!;
                  },
                );
              }),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              flex: 1,
              child: Obx(() {
                return DropdownButtonFormField<String>(
                  // key: controller.dropStatus,
                  items: controller.dbopt,
                  value: controller.option.value,
                  decoration:
                      CustomFormWidget.customInputDecoration('', 'Optional'),
                  onChanged: (value) {
                    controller.option.value = value!;
                  },
                );
              }),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              flex: 1,
              child: searchField(context),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.all(1.sp),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: Colors.black,
                        child: ElevatedButton.icon(
                          label: Text('Cari', style: TextStyle(fontSize: 9.sp)),
                          icon: Icon(
                            Icons.search,
                            size: 9.sp,
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(100),
                            primary: primaryDarkGreen,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          onPressed: () => {
                            controller.refreshDataAll(),
                            controller.getCashbon()
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    // Expanded(
                    //     flex: 1,
                    //     child: Container(
                    //       color: Colors.amber,
                    //       child: ElevatedButton.icon(
                    //         label: Text('Download',
                    //             style: TextStyle(fontSize: 9.sp)),
                    //         icon: Icon(
                    //           Icons.download,
                    //           size: 9.sp,
                    //         ),
                    //         style: ElevatedButton.styleFrom(
                    //           minimumSize: const Size.fromHeight(100),
                    //           primary: primaryDarkGreen,
                    //           elevation: 5,
                    //           shape: RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(5.0),
                    //           ),
                    //         ),
                    //         onPressed: () => {controller.downloadCashbon()},
                    //       ),
                    //     )),
                  ],
                ),
              ),
            ),
          ]),
    );
  }

  Container searchField(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width * .66,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          // color: primaryGrey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10)),
      child: TextField(
        textInputAction: TextInputAction.search,
        controller: controller.textFieldSearch.value,
        onChanged: (value) => {controller.search.value = value},
        onSubmitted: (value) => {},
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: "Cari...",
          filled: true,
          suffixIcon: IconButton(
              onPressed: () {
                controller.textFieldSearch.value.clear();
              },
              icon: const Icon(Icons.clear, color: Color(0xFFDFC012))),
          // icon: const Icon(Icons.clear),
          prefixIcon: const Icon(Icons.search, color: Color(0xFFDFC012)),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.5.h),
        ),
      ),
    );
  }

  Container body(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.all(1.sp),
        child: Obx(
          () => controller.loadingPage.isTrue
              ? Center(
                  child: SizedBox(
                    height: 1.9.h,
                    width: 3.3.w,
                    child: const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                      backgroundColor: Colors.blue,
                      strokeWidth: 3,
                    ),
                  ),
                )
              : controller.cashbonList.isNotEmpty
                  ? generateListViewCashbon(context)
                  : Center(
                      child: Text(
                      "Tidak Ada Data Kasbon",
                      style: TextStyle(fontSize: 9.sp),
                    )),
        ),
      ),
    );
  }

  ListView generateListViewCashbon(BuildContext context) {
    return ListView.builder(
        controller: controller.scrollController.value,
        // itemCount: controller.allOrder.value.allOrderList!.length,
        shrinkWrap: true,
        itemCount: controller.cashbonList.length +
            (controller.allLoadedPage.value ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < controller.cashbonList.length) {
            return initCashbonCard(context, index);
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

  Container initCashbonCard(BuildContext context, int index) {
    return Container(
      height: 13.h,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(3.sp),
          child: InkWell(
            onTap: () => {},
            child: Column(
              children: [
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.all(3.sp),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Text(
                                "Nama",
                                style: TextStyle(
                                    fontSize: 6.sp,
                                    fontWeight: FontWeight.bold),
                              )),
                          Expanded(
                              flex: 1,
                              child: Text(
                                controller.cashbonList.elementAt(index).name ??
                                    "",
                                textAlign: TextAlign.right,
                                style: TextStyle(fontSize: 6.sp),
                              )),
                        ],
                      ),
                    )),
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.all(3.sp),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Text(
                                "Username",
                                style: TextStyle(
                                    fontSize: 6.sp,
                                    fontWeight: FontWeight.bold),
                              )),
                          Expanded(
                              flex: 1,
                              child: Text(
                                controller.cashbonList
                                        .elementAt(index)
                                        .username ??
                                    "",
                                textAlign: TextAlign.right,
                                style: TextStyle(fontSize: 6.sp),
                              )),
                        ],
                      ),
                    )),
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.all(3.sp),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Text(
                                "Tipe Kasbon",
                                style: TextStyle(
                                    fontSize: 6.sp,
                                    fontWeight: FontWeight.bold),
                              )),
                          Expanded(
                              flex: 1,
                              child: Text(
                                controller.cashbonList.elementAt(index).type ??
                                    "",
                                textAlign: TextAlign.right,
                                style: TextStyle(fontSize: 6.sp),
                              )),
                        ],
                      ),
                    )),
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.all(3.sp),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Text(
                                "Total ",
                                style: TextStyle(
                                    fontSize: 6.sp,
                                    fontWeight: FontWeight.bold),
                              )),
                          Expanded(
                              flex: 1,
                              child: Text(
                                controller.convertPrice(controller.cashbonList
                                    .elementAt(index)
                                    .amount),
                                textAlign: TextAlign.right,
                                style: TextStyle(fontSize: 6.sp),
                              )),
                        ],
                      ),
                    )),
              ],
            ),
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
        "Laporan Kasbon",
        style: TextStyle(color: Colors.white, fontSize: 9.sp),
      ),
    );
  }
}
