import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siangmalam/commons/controllers/po-purchasing/item/po-item-form.controller.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/widgets/custom_input.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PurchaseItemFormScreen extends GetView<PoItemFormControllerV2> {
  static String routeName = "v2/po-item/form";
  const PurchaseItemFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.panelHeightOpen = 60.h;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: buildAppBar(context),
        body: panelF(context));
  }

  Widget panelF(BuildContext context) {
    if (controller.listPopitem.value.status != 'DONE') {
      return SlidingUpPanel(
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
      );
    } else {
      return body(context);
    }
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
            Obx(
              () => controller.warehouseDD.isNotEmpty
                  ? Padding(
                      padding: EdgeInsets.only(
                          top: 1.h, left: 2.w, right: 2.w, bottom: 0.5.h),
                      child: DropdownButtonFormField<int>(
                        items: controller.warehouseDD,
                        value: controller.listPopitem.value.warehouseId,
                        decoration: CustomFormWidget.customInputDecoration(
                            '', 'Dapur/Gudang'),
                        onChanged: controller.listPopitem.value.status != 'DONE'
                            ? (value) => {
                                  controller.listPopitem.value.warehouseId =
                                      value,
                                  controller.listPopitem.refresh()
                                }
                            : null,
                      ),
                    )
                  : Container(),
            ),
            Obx(
              () => controller.warehouseDD.isNotEmpty
                  ? Padding(
                      padding: EdgeInsets.only(
                          top: 1.h, left: 2.w, right: 2.w, bottom: 0.5.h),
                      child: DropdownButtonFormField<int>(
                        items: controller.suplierDD,
                        value: controller.listPopitem.value.suplierId,
                        decoration: CustomFormWidget.customInputDecoration(
                            '', 'Suplier'),
                        onChanged: controller.listPopitem.value.status != 'DONE'
                            ? (value) => {
                                  controller.listPopitem.value.suplierId =
                                      value,
                                  controller.listPopitem.refresh()
                                }
                            : null,
                      ),
                    )
                  : Container(),
            ),
            Form(
              key: controller.formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 2.w),
                child: CustomInputFieldWithControllerSingleFocus(
                  controller: controller.textFieldNote.value,
                  hint: 'Masukan Catatan',
                  label: "Catatan",
                  enable: controller.listPopitem.value.status != 'DONE',
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
              () => controller.listItem.isNotEmpty
                  ? const Text(
                      'Geser ke kiri untuk menghapus salah satu produk')
                  : Container(),
            ),
            Expanded(
              child: Container(
                color: Colors.transparent,
                child: Padding(
                    padding: controller.listPopitem.value.status != 'DONE'
                        ? EdgeInsets.only(bottom: 10.h)
                        : EdgeInsets.only(bottom: 0.h),
                    child: Obx(
                      () => controller.listPopitem.value.items != null
                          ? ListView.builder(
                              itemCount:
                                  controller.listPopitem.value.items!.length,
                              itemBuilder: (_, int i) => ListTile(
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(controller
                                          .listPopitem.value.items![i].name!),
                                      const SizedBox(width: 8),
                                      TextButton(
                                        child: const Text('HAPUS'),
                                        onPressed: controller
                                                    .listPopitem.value.status !=
                                                'DONE'
                                            ? () {
                                                controller.delete(i);
                                              }
                                            : null,
                                      ),
                                    ],
                                  ),
                                  subtitle: Column(
                                    children: [
                                      TextField(
                                        textInputAction: TextInputAction.done,
                                        enabled: controller
                                                .listPopitem.value.status !=
                                            'DONE',
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ], //
                                        controller:
                                            controller.quantityController[i],
                                        onChanged: (value) => {
                                          controller.changeQuantity(i, value)
                                        },
                                        onSubmitted: (value) => {},
                                        decoration: InputDecoration(
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          hintText: "Total",
                                          filled: true,
                                          suffixIcon: IconButton(
                                              onPressed: () {
                                                controller.plus(i);
                                              },
                                              icon: const Icon(
                                                  Icons.exposure_plus_1,
                                                  color: Color(0xFFDFC012))),
                                          // icon: const Icon(Icons.clear),
                                          prefixIcon: IconButton(
                                            onPressed: () {
                                              controller.minus(i);
                                            },
                                            icon: const Icon(
                                                Icons.exposure_minus_1,
                                                color: Color(0xFFDFC012)),
                                          ),
                                          contentPadding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom,
                                              left: 2.w,
                                              right: 2.w,
                                              top: 1.5.h),
                                          // contentPadding: EdgeInsets.symmetric(
                                          //     horizontal: 2.h, vertical: 1.5.h),
                                        ),
                                      ),
                                      SizedBox(height: 1.h),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: TextField(
                                              textInputAction:
                                                  TextInputAction.done,
                                              enabled: controller.listPopitem
                                                      .value.status !=
                                                  'DONE',
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ], //
                                              controller:
                                                  controller.costController[i],
                                              onChanged: (value) => {
                                                controller.changeCost(i, value)
                                              },
                                              onSubmitted: (value) => {},
                                              decoration: InputDecoration(
                                                enabledBorder: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                hintText: "Total",
                                                filled: true,
                                                // suffixIcon: IconButton(
                                                //     onPressed: () {
                                                //       controller.plus(i);
                                                //     },
                                                //     icon: const Icon(
                                                //         Icons.exposure_plus_1,
                                                //         color: Color(0xFFDFC012))),
                                                // icon: const Icon(Icons.clear),
                                                // prefixIcon: IconButton(
                                                //   onPressed: () {
                                                //     controller.minus(i);
                                                //   },
                                                //   icon: const Icon(
                                                //       Icons.exposure_minus_1,
                                                //       color: Color(0xFFDFC012)),
                                                // ),
                                                contentPadding: EdgeInsets.only(
                                                    bottom:
                                                        MediaQuery.of(context)
                                                            .viewInsets
                                                            .bottom,
                                                    left: 2.w,
                                                    right: 2.w,
                                                    top: 1.5.h),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Obx(
                                              () => Text(
                                                " /" +
                                                    controller.listPopitem.value
                                                        .items![i].quantity
                                                        .toString() +
                                                    ' ' +
                                                    controller.listPopitem.value
                                                        .items![i].unit! +
                                                    ' ' +
                                                    controller.convertPrice(
                                                        controller
                                                            .listPopitem
                                                            .value
                                                            .items![i]
                                                            .cost),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 10.sp,
                                                  color: primaryDarkGreen,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                            )
                          : Container(),
                    )),
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
        searchField(context),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Obx(
              () => controller.listItem.isNotEmpty
                  ? page(context)
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

  Container page(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Stack(
        children: [
          Obx(
            () => controller.listItem.isNotEmpty
                ? productList()
                : Center(
                    child: Container(
                    alignment: Alignment.center,
                    child: const Text(
                      'Daftar produk kosong,\n Cari kata kunci lain.',
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

  ListView productList() {
    return ListView.builder(
        controller: controller.scrollController.value,
        itemCount: controller.listItem.length +
            (controller.allLoadedPage.value ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < controller.listItem.length) {
            return Obx(() => InkWell(
                  onTap: () {
                    controller.insertItemToList(index);
                  },
                  child: ListTile(
                    dense: true,
                    leading: Icon(
                      Icons.production_quantity_limits_rounded,
                      color: primaryGoldText,
                      size: 20.sp,
                    ),
                    title: Text(
                      controller.listItem[index].name ?? '-',
                      style: GoogleFonts.raleway(
                          fontSize: 12.sp,
                          color: primaryDarkGreen,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ));
          } else {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: Center(
                child: Text("Tidak ada lagi daftar produk",
                    style: TextStyle(
                      fontSize: 7.sp,
                    )),
              ),
            );
          }
        });
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
            controller: controller.textFieldSearch.value,
            onChanged: (value) => {controller.mainFilter.value.search = value},
            onSubmitted: (value) =>
                {controller.recoverData(), controller.oneShot()},
            decoration: InputDecoration(
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: "Cari...",
              filled: true,
              suffixIcon: IconButton(
                  onPressed: () {
                    controller.textFieldSearch.value.clear();
                    controller.recoverData();
                    controller.oneShot();
                  },
                  icon: const Icon(Icons.clear, color: Color(0xFFDFC012))),
              // icon: const Icon(Icons.clear),
              prefixIcon: const Icon(Icons.search, color: Color(0xFFDFC012)),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.5.h),
            ),
          ),
        ));
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
              "Form pesanan pembelian",
              style: TextStyle(color: Colors.white, fontSize: 9.sp),
            ),
          ),
          Expanded(
              flex: 3,
              child: Obx(
                () => controller.listPopitem.value.items != null &&
                        controller.listPopitem.value.items!.isNotEmpty &&
                        controller.listPopitem.value.status != 'DONE'
                    ? generateSubmitButton()
                    : Container(),
              ))
        ],
      ),
    );
  }

  TextButton generateSubmitButton() {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(primaryLightGrey),
        elevation: MaterialStateProperty.all(8),
        minimumSize: MaterialStateProperty.all(Size.fromHeight(6.h)),
      ),
      child: controller.isSubmit.isFalse
          ? Text(
              'Sesuaikan',
              style: TextStyle(color: primaryDarkGreen, fontSize: 9.sp),
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
      onPressed: controller.listPopitem.value.items != null &&
              controller.listPopitem.value.items!.isNotEmpty &&
              controller.listPopitem.value.status != 'DONE'
          ? () {
              controller.isCreated.isTrue
                  ? controller.createSubmit()
                  : controller.updateSubmit();
            }
          : null,
    );
  }
}
