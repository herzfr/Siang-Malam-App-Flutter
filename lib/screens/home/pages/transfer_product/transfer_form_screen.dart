import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siangmalam/commons/controllers/product/transfer_product_form_controller.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/values.dart';
import 'package:siangmalam/models/warehouse/warehouse.dart';
import 'package:siangmalam/widgets/custom_input.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class TransferProductFormScreen extends GetView<TransferFormProductController> {
  static String routeName = " /transfer-products/form";
  const TransferProductFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.panelHeightOpen = 66.h;
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

  Container body(BuildContext context) {
    var node = FocusScope.of(context);
    return Container(
      color: primaryLightGrey,
      margin: EdgeInsets.only(bottom: 10.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 0.w),
        color: Colors.transparent,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
              child: Obx(() {
                return DropdownButtonFormField<ListWarehouse>(
                  // key: controller.dropStatus,
                  items: controller.warehouseDD,
                  value: null,
                  decoration: CustomFormWidget.customInputDecoration(
                      '', 'Cabang Tujuan'),
                  onChanged: controller.warehouseFrom.value.branchId != null
                      ? (value) {
                          controller.warehouseTo.value =
                              value ?? ListWarehouse();
                        }
                      : null,
                );
              }),
            ),
            Form(
              key: controller.formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
                child: CustomInputFieldWithControllerSingleFocus(
                  controller: controller.textFieldNote.value,
                  hint: 'Masukan Catatan',
                  label: "Catatan",
                  enable: true,
                  icon: Icons.edit,
                  node: node,
                  inputType: TextInputType.text,
                  dataInstance: (String? val) {},
                  validationBuilder:
                      ValidationBuilder(requiredMessage: 'Catatan tidak terisi')
                          .minLength(6, "minimal 6 karakter")
                          .build(),
                ),
              ),
            ),
            Obx(
              () => controller.productUpsert.isNotEmpty
                  ? const Text('Geser ke kiri untuk menghapus salah satu item')
                  : Container(),
            ),
            Expanded(
              child: Container(
                color: Colors.transparent,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: Obx(() => initBodyCard(context)),
                ),
              ),
            ),
            // Expanded(
            //   flex: 3, // 20%
            //   child: Obx(() => initHeadCart(context)),
            // ),
          ],
        ),
      ),
    );
  }

  Column filter(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 2.w),
          child: const Icon(
            Icons.arrow_drop_up,
            color: primaryGrey,
          ),
        ),
        // Padding(
        //   padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
        //   child: Obx(() {
        //     return DropdownButtonFormField<ListWarehouse>(
        //       // key: controller.dropStatus,
        //       items: controller.warehouseDDF,
        //       value: null,
        //       decoration:
        //           CustomFormWidget.customInputDecoration('', 'Cabang Awal'),
        //       onChanged: controller.warehouseTo.value.id == null
        //           ? (value) {
        //               if (controller.productUpsert.isNotEmpty) {
        //                 Get.defaultDialog(
        //                     title: "Perhatian!",
        //                     middleText:
        //                         "Jika anda ingin mengubah Cabang Awal akan menghapus daftar produk yang sudah dimasukan, lanjutkan?",
        //                     backgroundColor: whiteBg,
        //                     titleStyle: const TextStyle(color: mtGrey700),
        //                     middleTextStyle: const TextStyle(color: mtGrey700),
        //                     textConfirm: confirmYes,
        //                     textCancel: confirmNo,
        //                     cancelTextColor: mtGrey700,
        //                     confirmTextColor: mtGrey700,
        //                     buttonColor: primaryYellow,
        //                     onConfirm: () {
        //                       FocusScope.of(context).requestFocus(null);
        //                       Get.back();
        //                       controller.doTransfer();
        //                     });
        //               } else {
        //                 controller.changeDropdownFrom(value!);
        //               }
        //             }
        //           : null,
        //     );
        //   }),
        // ),
        searchField(context),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Obx(
              () => controller.listProduct.isNotEmpty
                  ? listProduct()
                  : const Center(child: Text('Produk Kosong')),
            ),
          ),
        )
        // : const Center(
        //     child: Text('Data produk tidak ada'),
        //   ))
      ],
    );
  }

  ListView initBodyCard(BuildContext context) {
    return ListView.builder(
      itemCount: controller.productUpsert.length,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.symmetric(vertical: 0.5.h),
        child: Dismissible(
          key: Key(controller.productUpsert[index].id.toString()),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            controller.productUpsert.removeAt(index);
            if (controller.productUpsert.isEmpty) {
              // controller.selectedTableActive.value = ListTable();
              // controller.createOrderRes.value = CreateOrderResponse();
              // controller.createOrderRes.refresh();
            }
          },
          background: Container(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            decoration: BoxDecoration(
              color: mtRed600,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                const Spacer(),
                SvgPicture.asset(
                  "assets/icons/Trash.svg",
                  color: textColor,
                  height: 3.h,
                ),
              ],
            ),
          ),
          child: Obx(
            () => initCartCard(context, index),
          ),
        ),
      ),
    );
  }

  Container initCartCard(BuildContext ctx, int idx) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(10.sp),
        child: Row(
          children: [
            Expanded(
              flex: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.productUpsert[idx].name ?? '',
                    style: TextStyle(
                      color: primaryDarkGreen,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  // const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: Obx(
                          () => Text(
                            'x' +
                                controller.productUpsert[idx].quantity
                                    .toString() +
                                " " +
                                controller.productUpsert[idx].unit!,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp,
                              color: primaryBlue,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          height: 30,
                          width: 30,
                          child: TextButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(primaryGoldText)),
                            child: const Text('-',
                                style: TextStyle(color: Colors.white)),
                            onPressed: () {
                              controller.minus(idx);
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          height: 30,
                          width: 30,
                          child: TextButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    primaryDarkGreen)),
                            child: const Text('+',
                                style: TextStyle(color: Colors.white)),
                            onPressed: () {
                              controller.plus(idx);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Estimasi Sisa',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 10.sp,
                            color: primaryDarkGreen,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Obx(
                          () => Text(
                            controller.productUpsert[idx].quantityFrom
                                .toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 10.sp,
                              color: primaryGoldText,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListView listProduct() {
    return ListView.builder(
        controller: controller.scrollController.value,
        // itemCount: controller.allOrder.value.allOrderList!.length,
        itemCount: controller.listProduct.length,
        itemBuilder: (context, index) {
          return Obx(() => iniProductCard(context, index));
        });
  }

  Card iniProductCard(BuildContext context, int index) {
    return Card(
      elevation: 2,
      shadowColor: Colors.grey,
      // color: Color(0xFFE9E9E9),
      margin: EdgeInsets.all(1.sp),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: GestureDetector(
          child: ListTile(
        leading: Icon(
          Icons.production_quantity_limits_rounded,
          color: primaryGoldText,
          size: 25.sp,
        ),
        title: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              controller.listProduct[index].product!.name!.toString(),
              style: GoogleFonts.raleway(
                  fontSize: 12.sp,
                  color: primaryDarkGreen,
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Text(
              controller.listProduct[index].quantity!.toString() +
                  " " +
                  controller.listProduct[index].product!.unit.toString(),
              style: GoogleFonts.raleway(
                  fontSize: 12.sp,
                  color: primaryDarkGreen,
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        subtitle: Text(
          controller.listProduct[index].warehouse?.name ?? 'Tidak ada Gudang',
          style: GoogleFonts.raleway(
              fontSize: 9.sp,
              color: primaryGoldText,
              letterSpacing: 1,
              fontWeight: FontWeight.bold),
        ),
        onTap: () {
          controller.insertItemToList(index);
        },
      )),
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
        onSubmitted: (value) =>
            {controller.refreshProduct(), controller.getAllProduList()},
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: "Cari...",
          filled: true,
          suffixIcon: IconButton(
              onPressed: () {
                controller.textFieldSearch.value.clear();
                controller.search.value = '';
                controller.refreshProduct();
                controller.getAllProduList();
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
            flex: 7,
            child: Text(
              "Form Pembuatan Transfer",
              style: TextStyle(color: Colors.white, fontSize: 9.sp),
            ),
          ),
          Expanded(
              flex: 3,
              child: Obx(
                () => ElevatedButton(
                  child: Text(
                    'Transfer',
                    style: TextStyle(color: primaryDarkGreen, fontSize: 9.sp),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: primaryLightGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: controller.productUpsert.isNotEmpty &&
                          controller.warehouseTo.value.branchId != null
                      ? () {
                          Get.defaultDialog(
                              title: "Transfer?",
                              middleText:
                                  "Transfer produk ke ${controller.warehouseTo.value.name}, lanjutkan?",
                              backgroundColor: whiteBg,
                              titleStyle: const TextStyle(color: mtGrey700),
                              middleTextStyle:
                                  const TextStyle(color: mtGrey700),
                              textConfirm: confirmYes,
                              textCancel: confirmNo,
                              cancelTextColor: mtGrey700,
                              confirmTextColor: mtGrey700,
                              buttonColor: primaryYellow,
                              onConfirm: () {
                                FocusScope.of(context).requestFocus(null);
                                Get.back();
                                controller.doTransfer();
                              });
                        }
                      : null,
                ),
              ))
        ],
      ),
    );
  }
}
