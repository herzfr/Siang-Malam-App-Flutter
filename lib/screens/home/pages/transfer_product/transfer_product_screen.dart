import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siangmalam/commons/controllers/product/transfer_product_controller.dart';
import 'package:siangmalam/commons/routes/routes_name.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/values.dart';
import 'package:siangmalam/models/transfer/transfer.dart';
import 'package:siangmalam/screens/home/pages/transfer_product/component/transfer_date_filter.dart';
import 'package:siangmalam/widgets/custom_input.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:sizer/sizer.dart';

class TransferProductScreen extends GetView<TransferProductController> {
  static String routeName = " //transfer-products";
  const TransferProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.panelHeightOpen = 40.h;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: buildAppBar(context),
      body: SlidingUpPanel(
        maxHeight: controller.panelHeightOpen,
        minHeight: controller.panelHeightClosed,
        controller: controller.pcs,
        parallaxEnabled: true,
        parallaxOffset: .10,
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
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
        child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
          const Icon(
            Icons.arrow_drop_up,
            color: primaryGrey,
          ),
          SizedBox(
            height: 0.5.h,
          ),
          DropdownButtonFormField<int>(
            // key: controller.dropStatus,
            items: controller.subbranch,
            value: controller.subBranchId,
            decoration: CustomFormWidget.customInputDecoration('', 'Cabang'),
            onChanged: (value) {
              controller.subBranchId = value;
              controller.refreshListPageTransfer();
              controller.getAllTransferList();
            },
          ),
          SizedBox(
            height: 2.h,
          ),
          // Obx(() {
          //   return DropdownButtonFormField<String>(
          //     // key: controller.dropStatus,
          //     items: controller.ddTypeTf,
          //     value: controller.as.value,
          //     decoration: CustomFormWidget.customInputDecoration(
          //         '', 'Tipe Transfer'),
          //     onChanged: (value) {
          //       controller.as.value = value!;
          //       controller.refreshListPageTransfer();
          //       controller.getAllTransferList();
          //     },
          //   );
          // }),
          SizedBox(
            height: 0.5.h,
          ),
          const TransferFilterPanel(),
        ]));
  }

  Container body(BuildContext context) {
    return Container(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: Obx(() => transferList()),
        ));
  }

  ListView transferList() {
    return ListView.builder(
        controller: controller.scrollController.value,
        // itemCount: controller.allOrder.value.allOrderList!.length,
        itemCount: controller.transferlist.length + (controller.allLoadedPageTransfer.value ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < controller.transferlist.length) {
            return Obx(() => initListCard(context, index));
          } else {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: Center(
                child: Text("Tidak ada lagi daftar transfer",
                    style: TextStyle(
                      fontSize: 7.sp,
                    )),
              ),
            );
          }
        });
  }

  Card initListCard(BuildContext ctx, int idx) {
    return Card(
      elevation: 4,
      color: Colors.white,
      child: Padding(
          padding: EdgeInsets.all(2.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.transferlist.elementAt(idx).note ?? '-',
                style: GoogleFonts.raleway(fontSize: 12.sp, color: primaryDarkGreen, letterSpacing: 1, fontWeight: FontWeight.bold),
              ),
              Container(
                color: Colors.white,
                height: 40.h,
                child: Stepper(
                  type: StepperType.horizontal,
                  steps: [
                    Step(
                      title: const Text('Dikirim'),
                      content: showListStatus(idx),
                      isActive: controller.transferlist.elementAt(idx).isDelivery!,
                    ),
                    Step(
                      title: const Text('Batal'),
                      content: showListStatus(idx),
                      isActive: controller.transferlist.elementAt(idx).isCanceled!,
                    ),
                    Step(
                      title: const Text('Diterima'),
                      content: showListStatus(idx),
                      isActive: controller.transferlist.elementAt(idx).isReceiverApproved!,
                    ),
                  ],
                  currentStep: controller.checkStep(idx) ?? 0,
                  onStepTapped: (int newIndex) {
                    controller.currentStep.value = newIndex;
                  },
                  controlsBuilder: (BuildContext ctx, ControlsDetails dtl) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        TextButton(
                          onPressed: () {
                            showDialog(
                                context: ctx,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      'Rincian Produk',
                                      style: GoogleFonts.raleway(
                                          fontSize: 12.sp, color: primaryDarkGreen, letterSpacing: 1, fontWeight: FontWeight.bold),
                                    ),
                                    content: setupAlertDialoadContainer(idx),
                                  );
                                });
                          },
                          child: const Text('RINCIAN'),
                        ),
                        getButtonReceiver(idx),
                        getButtonCancel(idx),
                      ],
                    );
                  },
                ),
              )
            ],
          )),
    );
  }

  Widget setupAlertDialoadContainer(int idx) {
    return Container(
      height: 30.h, // Change as per your requirement
      width: 30.w, // Change as per your requirement
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: controller.transferlist.elementAt(idx).products!.isNotEmpty ? controller.transferlist.elementAt(idx).products!.length : 0,
        itemBuilder: (BuildContext context, int index) {
          List<ProductsTransfer> prod = controller.transferlist.elementAt(idx).products!;
          return ListTile(
            title: Text(prod[index].name!),
            trailing: Text(prod[index].quantity.toString()),
          );
        },
      ),
    );
  }

  Widget getButtonReceiver(int idx) {
    if (controller.transferlist.elementAt(idx).isBack! && controller.role == 'MANAGER' && controller.transferlist.elementAt(idx).isDelivery!) {
      return TextButton(
        onPressed: () {
          Get.toNamed(RouteName.transferProductReceiveScreen, arguments: controller.transferlist.elementAt(idx))?.then((value) => {
                if (value != null) {value ? controller.oneShot() : null}
              });
        },
        child: const Text('TERIMA'),
      );
    } else {
      return Container();
    }
  }

  Widget getButtonCancel(int idx) {
    if (controller.transferlist.elementAt(idx).isBack! && controller.role == 'MANAGER' && controller.transferlist.elementAt(idx).isDelivery!) {
      return TextButton(
        onPressed: () {
          Get.defaultDialog(
              title: "Batal?",
              middleText: "Transfer produk ${controller.transferlist.elementAt(idx).note} akan dibatalkan, lanjutkan?",
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
                controller.cancelTransfer(idx);
              });
        },
        child: const Text('BATAL'),
      );
    } else {
      return Container();
    }
  }

  Column showListStatus(idx) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: const Icon(
            Icons.delivery_dining,
            color: Color(0xFF178295),
          ),
          title: Text(
            controller.transferlist.elementAt(idx).sendBy ?? '-',
            style: GoogleFonts.raleway(fontSize: 12.sp, color: primaryDarkGreen, letterSpacing: 1, fontWeight: FontWeight.bold),
          ),
          subtitle: const Text('Pengirim'),
          trailing: controller.checkIsSenderApproved(idx) ? const Text('Terkirim') : const Text('-'),
        ),
        ListTile(
          leading: const Icon(
            Icons.cancel,
            color: Color(0xFF95171C),
          ),
          title: controller.transferlist.elementAt(idx).isCanceled!
              ? Text(
                  controller.transferlist.elementAt(idx).sendBy ?? '-',
                  style: GoogleFonts.raleway(fontSize: 12.sp, color: primaryDarkGreen, letterSpacing: 1, fontWeight: FontWeight.bold),
                )
              : Text(
                  'Lanjut',
                  style: GoogleFonts.raleway(fontSize: 12.sp, color: primaryDarkGreen, letterSpacing: 1, fontWeight: FontWeight.bold),
                ),
          subtitle: const Text('Pembatal'),
          trailing: controller.transferlist.elementAt(idx).isCanceled! ? const Text('Batal') : const Text('-'),
        ),
        ListTile(
          leading: const Icon(
            Icons.approval,
            color: Color(0xFF069865),
          ),
          title: Text(
            controller.transferlist.elementAt(idx).receiveBy ?? '-',
            style: GoogleFonts.raleway(fontSize: 12.sp, color: primaryDarkGreen, letterSpacing: 1, fontWeight: FontWeight.bold),
          ),
          subtitle: const Text('Penerima'),
          trailing: controller.transferlist.elementAt(idx).isReceiverApproved! ? const Text('Disetujui') : const Text('-'),
        ),
        Row(
          children: [
            const Expanded(child: Text('Status')),
            Expanded(
                child: Text(
              controller.transferlist.elementAt(idx).isBack == true ? 'Pengembalian Produk' : 'Pengiriman Produk',
              textAlign: TextAlign.right,
              style: const TextStyle(color: primaryDarkGreen),
            )),
          ],
        )
      ],
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
          contentPadding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.5.h),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
      backgroundColor: primaryDarkGreen,
      elevation: 2,
      leading: IconButton(
        padding: EdgeInsets.only(left: 5.w),
        onPressed: () {
          Get.back();
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
      ),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 9,
            child: searchField(context),
          ),
          // SizedBox(height: 2.5.h),
          Expanded(
            flex: 1,
            child: PopupMenuButton<dynamic>(
              initialValue: controller.size,
              icon: const Icon(Icons.more_vert, color: Colors.white),
              onSelected: (value) => controller.popupChoose(value),
              itemBuilder: (context) {
                return [
                  const CheckedPopupMenuItem(
                    value: 0,
                    // checked: controller.size.value == 15,
                    child: Text("Refresh Data"),
                  ),
                  const CheckedPopupMenuItem(
                    value: 1,
                    // checked: controller.size.value == 15,
                    child: Text("Buat Transferan"),
                  ),
                ];
              },
            ),
          )
        ],
      ),
    );
  }
}
