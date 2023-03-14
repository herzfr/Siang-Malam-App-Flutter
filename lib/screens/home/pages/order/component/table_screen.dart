import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/order/order_controller.dart';
import 'package:siangmalam/commons/routes/routes_name.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/models/order/table.dart';
import 'package:siangmalam/widgets/custom_input.dart';
import 'package:sizer/sizer.dart';

class TableScreen extends GetView<OrderController> {
  const TableScreen({Key? key}) : super(key: key);

  get raisedButtonStyle => null;

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 1.w),
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: DropdownButtonFormField<int>(
              // key: controller.dropStatus,
              items: controller.dDBranch,
              value: controller.subBranchId,
              decoration: CustomFormWidget.customInputDecoration('', 'Cabang'),
              onChanged: (value) {
                controller.subBranchId = value;
                controller.clearCreateOrder();
                controller.checkOptionType();
                controller.refreshDataMenu();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: DropdownButtonFormField<int>(
              // key: controller.dropStatus,
              items: controller.dDtypeOrder,
              value: controller.optionTable.value,
              decoration:
                  CustomFormWidget.customInputDecoration('', 'Tipe Pesanan'),
              onChanged: (value) {
                controller.optionTable.value = value!;
                controller.clearCreateOrder();
                controller.checkOptionType();
              },
            ),
          ),
          Expanded(
            flex: 10,
            child: Padding(
              padding: const EdgeInsets.all(1),
              child: Obx(
                () => controller.optionTable.value == 1
                    ? Container(
                        color: Colors.transparent,
                        child: controller.orderList.isNotEmpty
                            ? generateListViewAllOrderTakeAway(context)
                            : controller.loadingPageOrder.isFalse
                                ? const Center(
                                    child: Text('Belum ada orderan Bungkus'))
                                : const Center(
                                    child: SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation(
                                            Colors.white),
                                        backgroundColor: Colors.blue,
                                        strokeWidth: 3,
                                      ),
                                    ),
                                  ))
                    : Container(
                        color: Colors.transparent,
                        child: Obx(
                          () => controller.listTable.isNotEmpty
                              ? iniTable(controller)
                              : Center(
                                  child: Container(
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'Meja belum dibuat,\n mohon buat meja terlebih dahulu.',
                                    textAlign: TextAlign.center,
                                  ),
                                )),
                        ),
                      ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    Obx(() => controller.optionTable.value == 2
                        ? const Text(
                            'Tekan lama pada tabel meja untuk mengubah')
                        : Container()),
                    Obx(
                      () => controller.optionTable.value == 2
                          ? MaterialButton(
                              onPressed: () => {
                                Get.toNamed(RouteName.orderTableFormScreen)
                                    ?.then((value) =>
                                        {controller.refresSelectedTable()})
                              },
                              child: const Text('Buat Meja +'),
                            )
                          : Container(),
                    ),
                    Obx(
                      () => controller.optionTable.value != 2
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                generateOrderButtonTakeAway(context),
                                const SizedBox(
                                  width: 10,
                                ),
                                generateButtonRefresOrder()
                              ],
                            )
                          : Container(),
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }

  ListView generateListViewAllOrderTakeAway(BuildContext context) {
    return ListView.builder(
        controller: controller.scrollController.value,
        // itemCount: controller.allOrder.value.allOrderList!.length,
        itemCount: controller.orderList.value.length +
            (controller.allLoadedPageOrder.value ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < controller.orderList.length) {
            return Obx(
              () => Card(
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap:
                      controller.orderList.elementAt(index).isDone != 'PENDING'
                          ? () {}
                          : () => controller.seeOrderList(index),
                  child: Container(
                    color: (() {
                      // your code here
                      if (controller.createOrderRes.value.id ==
                          controller.orderList.elementAt(index).id) {
                        return const Color(0xFFE4E4E4);
                      } else {
                        Colors.transparent;
                      }
                    }()),
                    child: SizedBox(
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
                                  style:
                                      const TextStyle(color: Color(0xFF494949)),
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
                                              controller.printData(index);
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
      style:
          ButtonStyle(backgroundColor: MaterialStateProperty.all(primaryBlue)),
      child: controller.loadingPageOrder.isFalse
          ? const Text('refresh', style: TextStyle(color: Colors.white))
          : const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
                backgroundColor: Colors.blue,
                strokeWidth: 3,
              ),
            ),
      onPressed: () {
        controller.refreshDataAllOrder();
        controller.clearCreateOrder();
        controller.checkOptionType();
      },
    );
  }

  ElevatedButton generateOrderButtonTakeAway(BuildContext context) {
    return ElevatedButton(
        child: const Text('Pesanan Baru +'),
        style: ElevatedButton.styleFrom(primary: primaryBlue),
        onPressed: () async {
          controller.clearCreateOrder();
          controller.clearTextController();
          await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Center(child: Text('Data Pesanan?')),
                  content: setupFormDialoadContainerList(context),
                  actions: <Widget>[
                    Center(
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                child: const Text('Batal'),
                                style: ElevatedButton.styleFrom(
                                    primary: primaryBlue),
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
                                child: const Text('Lanjut Menu'),
                                style: ElevatedButton.styleFrom(
                                    primary: primaryBlue),
                                onPressed: () {
                                  controller.createOrder();
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
        });
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

  GridView iniTable(OrderController controller) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, childAspectRatio: 0.75),
        // const SliverGridDelegateWithMaxCrossAxisExtent(
        //     maxCrossAxisExtent: 200,
        //     childAspectRatio: 3 / 3,
        //     crossAxisSpacing: 20,
        //     mainAxisSpacing: 20),
        itemCount: controller.listTable.length,
        itemBuilder: (BuildContext ctx, index) {
          return Container(
            alignment: Alignment.center,
            // child: Text(controller.listTable[index].name.toString()),
            child: Container(
              padding: const EdgeInsets.all(1),
              // color: Colors.teal[300],
              child: Obx(
                () => ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: controller.listTable[index].isOccupied!
                        ? Colors.pink
                        : primaryBlue,
                  ),
                  onLongPress: () {
                    controller.selectedTableActive.value =
                        controller.listTable[index];
                    Get.toNamed(RouteName.orderTableFormScreen)!
                        .then((value) => controller.refresSelectedTable());
                  },
                  onPressed: controller.listTable[index].isOccupied!
                      ? () async {
                          controller.clearTextController();
                          controller.clearCreateOrder();
                          controller.selectedTableActive.value =
                              controller.listTable[index];
                          controller.selectedTableActive.refresh();
                          await controller.getOrderListBySalesId(controller
                              .listTable
                              .elementAt(index)
                              .salesId
                              .toString());
                        }
                      : () async {
                          controller.clearTextController();
                          controller.clearCreateOrder();
                          controller.selectedTableActive.value =
                              controller.listTable[index];
                          controller.selectedTableActive.refresh();
                          await showDialog(
                              context: ctx,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Center(
                                      child: Text(
                                          'Meja ${controller.listTable[index].name.toString()}')),
                                  content:
                                      setupFormDialoadContainerList(context),
                                  actions: <Widget>[
                                    Center(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                                child: const Text('Batal'),
                                                style: ElevatedButton.styleFrom(
                                                    primary: primaryBlue),
                                                onPressed: () {
                                                  controller
                                                      .clearTextController();
                                                  controller
                                                      .textFieldCapacityController
                                                      .value
                                                      .clear();
                                                  controller.selectedTableActive
                                                      .value = ListTable();
                                                  Navigator.of(context).pop();
                                                }),
                                          ),
                                          SizedBox(
                                            width: 1.5.w,
                                          ),
                                          Expanded(
                                            child: ElevatedButton(
                                                child:
                                                    const Text('Lanjut Menu'),
                                                style: ElevatedButton.styleFrom(
                                                    primary: primaryBlue),
                                                onPressed: () {
                                                  controller.createOrder();
                                                  controller
                                                          .formKey.currentState!
                                                          .validate()
                                                      ? Navigator.of(context)
                                                          .pop()
                                                      : null;
                                                }),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }).then((value) => null);
                        },
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(controller.listTable[index].name.toString(),
                            textScaleFactor: 2),
                        Text(
                          controller.listTable[index].description.toString(),
                          textAlign: TextAlign.center,
                        ),
                        controller.listTable[index].capacity != null
                            ? Text(
                                "Kapasitas " +
                                    controller.listTable[index].capacity
                                        .toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 9),
                              )
                            : const Text(
                                "Kapasitas 0",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 9),
                              )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(15)),
          );
        });
  }
}
