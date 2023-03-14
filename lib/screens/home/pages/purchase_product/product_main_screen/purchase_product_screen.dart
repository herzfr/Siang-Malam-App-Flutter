import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siangmalam/commons/controllers/po-purchasing/product/po-product.controller.dart';
import 'package:siangmalam/commons/routes/routes_name.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/values.dart';
import 'package:siangmalam/models/purchase-orders/po-product.dart';
import 'package:siangmalam/screens/home/pages/purchase_product/product_main_screen/purchase_product_date_screen.dart';
import 'package:siangmalam/widgets/custom_input.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PurchaseProductScreen extends GetView<PoProductControllerV2> {
  static String routeName = " /v2/po-pruduct/";

  const PurchaseProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.panelHeightOpen = 60.h;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: buildAppBar(context),
      body: SlidingUpPanel(
        maxHeight: 50.h,
        minHeight: 10.h,
        controller: controller.pcs,
        parallaxEnabled: true,
        parallaxOffset: .10,
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
        panel: Container(padding: EdgeInsets.symmetric(horizontal: 5.w), child: filter(context)),
        body: body(context),
      ),
    );
  }

  Container body(BuildContext context) {
    return Container(color: Colors.transparent, child: Padding(padding: EdgeInsets.only(bottom: 10.h), child: Obx(() => page(context))));
  }

  Container page(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Stack(
        children: [
          Obx(
            () => controller.listpoproduct.isNotEmpty
                ? transferList()
                : Center(
                    child: Container(
                    alignment: Alignment.center,
                    child: const Text(
                      'Daftar produk pesanan kosong,\n Cari kata kunci lain.',
                      textAlign: TextAlign.center,
                    ),
                  )),
          ),
          if (controller.loadingPage.isTrue) ...[
            Positioned(
              left: 0,
              bottom: 10.h,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 80,
                child: const Center(child: CircularProgressIndicator()),
              ),
            ),
          ],
        ],
      ),
    );
  }

  ListView transferList() {
    return ListView.builder(
        controller: controller.scrollController.value,
        itemCount: controller.listpoproduct.length + (controller.allLoadedPage.value ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < controller.listpoproduct.length) {
            return Obx(() => initListCard(context, index));
          } else {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: Center(
                child: Text("Tidak ada lagi daftar pesanan pembelian",
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
        padding: EdgeInsets.all(5.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              dense: true,
              leading: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                child: getStatus(controller.listpoproduct[idx].status),
              ),
              title: Text(
                controller.listpoproduct.elementAt(idx).note ?? '-',
                style: GoogleFonts.raleway(fontSize: 12.sp, color: primaryDarkGreen, letterSpacing: 1, fontWeight: FontWeight.bold),
              ),
              subtitle: getStatusText(controller.listpoproduct.elementAt(idx).status),
              trailing: Text(
                controller.listpoproduct.elementAt(idx).orderNo ?? '-',
                style: GoogleFonts.raleway(fontSize: 10.sp, color: primaryDarkGreen, letterSpacing: 1, fontWeight: FontWeight.normal),
              ),
            ),
            ExpansionTile(
              title: const Text('Produk'),
              children: [detailProduct(idx)],
            ),
            controller.listpoproduct[idx].status == 'DONE'
                ? ExpansionTile(
                    leading: const Icon(Icons.payment),
                    title: Text(controller.convertPrice(controller.listpoproduct[idx].totalCost)),
                    children: [
                      ListTile(
                        title: Text('Sisa : ' + controller.convertPrice(controller.listpoproduct[idx].remaining)),
                        trailing: Text(controller.listpoproduct[idx].paidStatus == 'DONE' ? 'LUNAS' : 'BERSISA',
                            style: TextStyle(
                                fontSize: 14,
                                color: controller.listpoproduct[idx].paidStatus == 'DONE' ? const Color(0xFF1C9E80) : const Color(0xFF9E1C4C))),
                        subtitle: Text('Dibayarkan : ' + controller.convertPrice(controller.listpoproduct[idx].paid)),
                      )
                    ],
                  )
                : Container(),
            controller.listpoproduct[idx].status != 'CANCEL'
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      controller.listpoproduct[idx].status != 'DONE'
                          ? TextButton(
                              child: const Text('SETUJUI'),
                              onPressed: () {
                                Get.defaultDialog(
                                    title: "Setuju?",
                                    middleText: "Penyetujuan pembalian pesanan ${controller.listpoproduct[idx].orderNo}, lanjutkan?",
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
                                      controller.approveOrderPo(idx);
                                    });
                              },
                            )
                          : Container(),
                      controller.listpoproduct[idx].status != 'DONE'
                          ? TextButton(
                              child: const Text('BATAL'),
                              onPressed: () {
                                Get.defaultDialog(
                                    title: "Batal?",
                                    middleText: "Pembatalan pembalian pesanan ${controller.listpoproduct[idx].orderNo}, lanjutkan?",
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
                                      controller.cancelOrderPo(idx);
                                    });
                              },
                            )
                          : Container(),
                      const SizedBox(width: 8),
                      TextButton(
                        child: const Text('LIHAT'),
                        onPressed: () {
                          Get.toNamed(RouteName.poproductFormScreenV2, arguments: controller.listpoproduct[idx])?.then((value) => {
                                if (value != null) {value ? controller.oneShot() : null}
                              });
                        },
                      ),
                      const SizedBox(width: 8),
                      controller.listpoproduct[idx].status == 'DONE'
                          ? TextButton(
                              child: const Text('ANGSURAN'),
                              onPressed: () {
                                Get.toNamed(RouteName.poproductCreditScreenV2, arguments: controller.listpoproduct[idx])?.then((value) => {
                                      if (value != null)
                                        {
                                          value ? ({controller.recoverData(), controller.oneShot()}) : null
                                        }
                                    });
                              },
                            )
                          : Container(),
                      TextButton(
                        child: const Text('BUKTI'),
                        onPressed: () {
                          Get.toNamed(RouteName.poproductUploadScreenV2, arguments: controller.listpoproduct[idx])?.then((value) => {
                                if (value != null)
                                  {
                                    value ? ({controller.recoverData(), controller.oneShot()}) : null
                                  }
                              });
                        },
                      ),
                      const SizedBox(width: 8),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  detailProduct(idx) {
    final children = <Widget>[];
    List<ProductsPo> list = controller.listpoproduct[idx].products ?? [];
    for (var element in list) {
      children.add(ListTile(
        title: Text(element.name ?? '-'),
        trailing: Text('${element.quantity}/${element.unit}'),
        subtitle: Text(controller.convertPrice(element.cost)),
      ));
    }
    return Column(
      children: children,
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
            child: Obx(() => controller.filterPo.value.search != null
                ? searchField(context)
                : const Center(
                    child: Text('Loading..'),
                  )),
          ),
          // SizedBox(height: 2.5.h),
          Expanded(
            flex: 1,
            child: PopupMenuButton<dynamic>(
              initialValue: controller.filterPo.value.size,
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
                    child: Text("Buat PO"),
                  ),
                ];
              },
            ),
          )
        ],
      ),
    );
  }

  Column filter(BuildContext context) {
    controller.generateSelected();
    controller.initFilterPo();

    return Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
      const Icon(
        Icons.arrow_drop_up,
        color: primaryGrey,
      ),
      SizedBox(
        height: 0.5.h,
      ),
      const PurchaseProductDate(),
      SizedBox(
        height: 2.h,
      ),
      DropdownButtonFormField<int>(
        items: controller.subbranch,
        value: controller.subBranchId,
        decoration: CustomFormWidget.customInputDecoration('', 'Cabange'),
        onChanged: (value) {
          controller.subBranchId = value;
          controller.filterPo.value.subBranchId = controller.subBranchId;
          controller.oneShot();
        },
      ),
      SizedBox(
        height: 2.h,
      ),
      DropdownButtonFormField<String>(
        items: controller.itemStatus,
        value: controller.filterPo.value.status,
        decoration: CustomFormWidget.customInputDecoration('', 'Status Pembayaran'),
        onChanged: (value) {
          controller.filterPo.value.status = value!;
          controller.oneShot();
        },
      ),
      SizedBox(
        height: 2.h,
      ),
      DropdownButtonFormField<String>(
        items: controller.itemOpt,
        value: controller.filterPo.value.option,
        decoration: CustomFormWidget.customInputDecoration('', 'Berdasarkan'),
        onChanged: (value) {
          controller.filterPo.value.option = value!;
          controller.oneShot();
        },
      ),
      SizedBox(
        height: 2.h,
      ),
      DropdownButtonFormField<String>(
        // key: controller.dropStatus,
        items: controller.itemorderBy,
        value: controller.filterPo.value.orderBy,
        decoration: CustomFormWidget.customInputDecoration('', 'Pesanan'),
        onChanged: (value) {
          controller.filterPo.value.orderBy = value!;
          controller.getAllPoProduct();
          controller.oneShot(); 
        },
      ),
    ]);
  }

  Container searchField(BuildContext context) {
    return Container(
        // width: MediaQuery.of(context).size.width * .66,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            // color: primaryGrey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10)),
        child: Obx(
          () => TextField(
            textInputAction: TextInputAction.search,
            controller: controller.textFieldController.value,
            onChanged: (value) => {controller.filterPo.value.search = value},
            onSubmitted: (value) => {controller.oneShot()},
            decoration: InputDecoration(
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: "Cari...",
              filled: true,
              suffixIcon: IconButton(
                  onPressed: () {
                    controller.textFieldController.value.clear();
                    controller.filterPo.value.search = controller.textFieldController.value.text;
                    controller.oneShot();
                  },
                  icon: const Icon(Icons.clear, color: Color(0xFFDFC012))),
              // icon: const Icon(Icons.clear),
              prefixIcon: const Icon(Icons.search, color: Color(0xFFDFC012)),
              contentPadding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.5.h),
            ),
          ),
        ));
  }

  Image getStatus(String? status) {
    switch (status) {
      case 'CREATED':
        return Image.asset(
          'assets/images/doc_created.png',
          fit: BoxFit.cover,
        );
      case 'DONE':
        return Image.asset(
          'assets/images/doc_success.png',
          fit: BoxFit.cover,
        );
      case 'CANCEL':
        return Image.asset(
          'assets/images/doc_cancel.png',
          fit: BoxFit.cover,
        );
      default:
        return Image.asset(
          'assets/images/doc_update.png',
          fit: BoxFit.cover,
        );
      // return const Text('');
    }
  }

  Text getStatusText(String? status) {
    switch (status) {
      case 'CREATED':
        return Text(
          'DIBUAT',
          style: GoogleFonts.raleway(fontSize: 10.sp, color: primaryDarkGreen, letterSpacing: 1, fontWeight: FontWeight.normal),
        );
      case 'DONE':
        return Text(
          'SELESAI',
          style: GoogleFonts.raleway(fontSize: 10.sp, color: primaryDarkGreen, letterSpacing: 1, fontWeight: FontWeight.normal),
        );
      case 'CANCEL':
        return Text(
          'BATAL',
          style: GoogleFonts.raleway(fontSize: 10.sp, color: primaryDarkGreen, letterSpacing: 1, fontWeight: FontWeight.normal),
        );
      default:
        return Text(
          'DIUBAH',
          style: GoogleFonts.raleway(fontSize: 10.sp, color: primaryDarkGreen, letterSpacing: 1, fontWeight: FontWeight.normal),
        );
    }
  }

  getStatusPayment(String? status) {
    switch (status) {
      case 'UNFINISH':
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
            "Belum Bayar",
            style: TextStyle(fontSize: 14, color: Color(0xFFFFFFFF)),
          ), // Text
        );
      case 'FINISH':
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
            "Lunas",
            style: TextStyle(fontSize: 14, color: Color(0xFFFFFFFF)),
          ), // Text
        );
      default:
        return const Text('');
    }
  }
}
