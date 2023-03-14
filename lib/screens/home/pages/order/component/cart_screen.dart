import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/order/order_controller.dart';
import 'package:siangmalam/commons/size_config.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/models/order/create-order-response.dart';
import 'package:siangmalam/models/order/table.dart';
import 'package:siangmalam/widgets/custom_input.dart';
import 'package:sizer/sizer.dart';

class OrderCartScreen extends GetView<OrderController> {
  const OrderCartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0.w),
      color: Colors.transparent,
      child: Column(
        children: [
          Obx(
            () => controller.cartList.isNotEmpty
                ? const Text('Geser ke kiri untuk menghapus salah satu item')
                : Container(),
          ),
          Expanded(
            flex: 7, // 60%
            child: Container(
              color: Colors.transparent,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Obx(() => initBodyCard(context)),
              ),
            ),
          ),
          Expanded(
            flex: 3, // 20%
            child: Obx(() => initHeadCart(context)),
          ),
        ],
      ),
    );
  }

  ListView initBodyCard(BuildContext context) {
    return ListView.builder(
      itemCount: controller.cartList.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Dismissible(
          key: Key(controller.cartList[index].menuId.toString()),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            controller.cartList.removeAt(index);
            if (controller.cartList.isEmpty) {
              controller.selectedTableActive.value = ListTable();
              controller.createOrderRes.value = CreateOrderResponse();
              controller.createOrderRes.refresh();
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

  Row initCartCard(BuildContext ctx, int idx) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: controller.cartList[idx].pic != "No Pic"
                ? Image.network(
                    controller.cartList[idx].pic.toString(),
                  )
                : Image.asset('assets/images/no_pic.png'),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.cartList[idx].name ?? 'No Pic',
                style: const TextStyle(color: Colors.black, fontSize: 14),
                overflow: TextOverflow.ellipsis,
              ),
              // const SizedBox(height: 10),
              Obx(
                () => Row(
                  children: [
                    Text(
                      "${controller.convertPrice(controller.cartList[idx].unitPrice)}",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 9.sp,
                        color: const Color(0xAF000000),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Obx(
                      () => Text(
                        'x' + controller.cartList[idx].amount.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                          color: primaryBlue,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 30,
                        width: 30,
                        child: TextButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(primaryYellow)),
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
                      flex: 1,
                      child: SizedBox(
                        height: 30,
                        width: 30,
                        child: TextButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(primaryBlue)),
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
              ),
              Row(
                children: [
                  Obx(
                    () => Text(
                      "${controller.convertPrice(controller.cartList[idx].totalPrice)}",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 10.sp,
                        color: primaryYellow,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Container initHeadCart(BuildContext context) {
    return Container(
      // color: Colors.black,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -15),
            blurRadius: 20,
            color: mtGrey900.withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 6,
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Nama : ${controller.createOrderRes.value.name} ",
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(color: Colors.black),
                                )),
                          ),
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text.rich(
                                TextSpan(
                                  text: "Tipe : ",
                                  children: [
                                    TextSpan(
                                      text: controller.optionTable.value == 2
                                          ? 'Makan ditempat'
                                          : 'Bawa pulang',
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                            flex: 3,
                            child: Text("Keterangan"),
                          ),
                          Expanded(
                            flex: 6,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                controller.createOrderRes.value.note ?? '',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text.rich(
                            TextSpan(
                              text: "Meja : ",
                              children: [
                                TextSpan(
                                  text: controller
                                          .selectedTableActive.value.name ??
                                      '-',
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Obx(
                            () => Text.rich(
                              TextSpan(
                                text: "Jumlah Item : ",
                                children: [
                                  TextSpan(
                                    text: controller.cartList.length.toString(),
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
            // SizedBox(height: 1.h, child: const Divider(color: Colors.black)),
            Expanded(
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 2.w, right: 2.w, top: 1.h, bottom: 1.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Obx(
                          () => Text.rich(
                            TextSpan(
                              text: "Jumlah Keseluruhan:\n",
                              children: [
                                TextSpan(
                                  text: controller.checkGrandTotalPrice(),
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          width: 5.w,
                          child: Obx(() => controller.cartList.isNotEmpty
                              ? Container(
                                  child: controller.createOrderRes.value.id ==
                                          null
                                      ? TextButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      primaryGreen)),
                                          child: const Text('Simpan',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          onPressed: controller
                                                  .cartList.isNotEmpty
                                              ? () async {
                                                  // await showDialogBlankOrder(
                                                  //     context);
                                                  controller
                                                      .generateBlankOrder();
                                                  await controller.saveOrder();
                                                }
                                              : () => {
                                                    Get.snackbar("Opps",
                                                        "Item masih kosong!")
                                                  },
                                        )
                                      : TextButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      primaryBlue)),
                                          child: controller.isLoading.isFalse
                                              ? const Text('Update',
                                                  style: TextStyle(
                                                      color: Colors.white))
                                              : const SizedBox(
                                                  height: 20,
                                                  width: 20,
                                                  child:
                                                      CircularProgressIndicator(
                                                    valueColor:
                                                        AlwaysStoppedAnimation(
                                                            Colors.white),
                                                    backgroundColor:
                                                        Colors.blue,
                                                    strokeWidth: 3,
                                                  ),
                                                ),
                                          onPressed: () {
                                            controller.updateOrder();
                                          },
                                        ),
                                )
                              : Container()),
                        ),
                      ),
                      SizedBox(
                          width: 5.w,
                          child: const Divider(color: Colors.black)),
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          width: 5.w,
                          child: Obx(() => controller.cartList.isNotEmpty
                              ? Container(
                                  child: controller.createOrderRes.value.id ==
                                          null
                                      ? TextButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.amber)),
                                          child: const Text('Hapus',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          onPressed: () {
                                            controller.selectedTableActive
                                                .value = ListTable();
                                            controller.cartList.clear();
                                            controller.cartList.refresh();
                                            controller.createOrderRes.value =
                                                CreateOrderResponse();
                                            controller.createOrderRes.refresh();
                                            controller.tabController.index = 0;
                                          },
                                        )
                                      : TextButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.pink)),
                                          child: const Text('Batal',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          onPressed: () {
                                            showDialogCancelOrder(context);
                                          },
                                        ),
                                )
                              : Container()),
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  setupAlertDialoadContainerList(BuildContext context) {
    var node = FocusScope.of(context);
    return Container(
      alignment: Alignment.center,
      height: 250.0, // Change as per your requirement
      width: 200.0, // Change as per your requirement
      child: Form(
        key: controller.formKey2,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.1.w),
          child: SingleChildScrollView(
            child: Column(children: [
              CustomInputFieldWithController(
                controller: controller.textFieldWhyController.value,
                hint: 'Masukan Alasan',
                label: 'Keterangan Alasan',
                enable: true,
                icon: Icons.person,
                node: node,
                inputType: TextInputType.text,
                dataInstance: (String? val) {},
                validationBuilder: ValidationBuilder()
                    .minLength(5, "Minimal 5 karakter")
                    .maxLength(15, "Maximal 15 karakter")
                    .build(),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  setupFormDialoadContainerList(BuildContext context) {
    var node = FocusScope.of(context);
    return Container(
      alignment: Alignment.center,
      height: 250.0, // Change as per your requirement
      width: 200.0, // Change as per your requirement
      child: Form(
        key: controller.formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.1.w),
          child: SingleChildScrollView(
            child: Column(children: [
              CustomInputFieldWithController(
                controller: controller.textFieldNameController.value,
                hint: 'Masukan Nama',
                label: 'Nama Pelanggan',
                enable: true,
                icon: Icons.person,
                node: node,
                inputType: TextInputType.text,
                dataInstance: (String? val) {},
                validationBuilder: ValidationBuilder()
                    .minLength(3, "Minimal 3 karakter")
                    .build(),
              ),
              SizedBox(
                height: 1.5.h,
              ),
              CustomInputFieldWithController(
                controller: controller.textFieldNoteController.value,
                hint: 'Masukan Catatan',
                label: 'Catatan Pesanan',
                enable: true,
                icon: Icons.edit,
                node: node,
                inputType: TextInputType.text,
                dataInstance: (String? val) {},
                validationBuilder: null,
              ),
              SizedBox(
                height: 1.5.h,
              ),
              controller.optionTable.value == 2
                  ? CustomInputFieldWithController(
                      controller: controller.textFieldCapacityController.value,
                      hint: 'Masukan Jumlah Kapasitas',
                      label: 'Kapasitas',
                      enable: true,
                      icon: Icons.reduce_capacity,
                      node: node,
                      inputType: TextInputType.number,
                      dataInstance: (String? val) {},
                      validationBuilder: ValidationBuilder()
                          .minLength(1, "Minimal 1 karakter")
                          .build(),
                    )
                  : Container(),
            ]),
          ),
        ),
      ),
    );
  }

  showDialogCancelOrder(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Center(child: Text('Batalkan pesanan?')),
            content: setupAlertDialoadContainerList(context),
            actions: <Widget>[
              Center(
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          child: const Text('Tidak'),
                          style: ElevatedButton.styleFrom(primary: primaryBlue),
                          onPressed: () {
                            controller.clearTextController();
                            Navigator.of(context).pop();
                          }),
                    ),
                    SizedBox(
                      width: 1.5.w,
                    ),
                    Expanded(
                      child: ElevatedButton(
                          child: const Text('Batalkan'),
                          style: ElevatedButton.styleFrom(primary: primaryBlue),
                          onPressed: () async {
                            await controller.cancelOrder();
                            controller.formKey2.currentState!.validate()
                                ? Navigator.of(context).pop()
                                : null;
                          }),
                    ),
                  ],
                ),
              ),
            ],
          );
        }).then((value) => null);
  }

  showDialogBlankOrder(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Center(child: Text('Isi Nama')),
            content: setupFormDialoadContainerList(context),
            actions: <Widget>[
              Center(
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          child: const Text('Batal'),
                          style: ElevatedButton.styleFrom(primary: primaryBlue),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                    ),
                    SizedBox(
                      width: 1.5.w,
                    ),
                    Expanded(
                      child: ElevatedButton(
                          child: const Text('Simpan'),
                          style: ElevatedButton.styleFrom(primary: primaryBlue),
                          onPressed: () async {
                            await controller.generateBlankOrder();
                            controller.formKey.currentState!.validate()
                                ? Navigator.of(context).pop()
                                : null;
                          }),
                    ),
                  ],
                ),
              ),
            ],
          );
        }).then((value) => null);
  }
}
