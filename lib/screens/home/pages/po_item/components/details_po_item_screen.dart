import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/po/po_item_details_controller.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/values.dart';
import 'package:siangmalam/screens/home/pages/po_item/components/po_item_pic.dart';
import 'package:siangmalam/widgets/custom_input.dart';
import 'package:sizer/sizer.dart';

class DetailsPoItemScreen extends GetView<PoItemDetailsController> {
  static String routeName = "/po-item/details";
  const DetailsPoItemScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // var bottom = MediaQuery.of(context).viewInsets.bottom;
    //  var node = FocusScope.of(context);
    var appBar = buildAppBar(controller);
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundimage),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: const Color.fromARGB(0, 237, 248, 243),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0), // here the desired height
          child: appBar,
        ),
        body: FractionallySizedBox(
          alignment: Alignment.topCenter,
          widthFactor: 1,
          heightFactor: 1,
          child: Stack(
            children: [
              Container(
                width: size.width,
                height: size.height,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                        width: size.width,
                        height: 140,
                        color: const Color(0x00FF1F1F),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: getCardBuild(context, controller)),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: MediaQuery.of(context).size.height / 2,
                        color: Colors.transparent,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Text(
                                  'LIST BAHAN',
                                  style: TextStyle(
                                    color: Color(0xFF323232),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textScaleFactor: 1,
                                ),
                              ),
                              Container(
                                width: size.width,
                                height: 50,
                                color: Colors.transparent,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Expanded(
                                        flex: 1,
                                        child: SizedBox(
                                          child: Text(
                                            'Total Bahan',
                                            style: TextStyle(
                                              color: Color(0xFF323232),
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textScaleFactor: 1,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      SizedBox(
                                        child: Text(
                                          '${controller.poitemlist.value.items?.length}',
                                          style: const TextStyle(
                                            color: Color(0xFF323232),
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textScaleFactor: 1,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom,
                                    right: 20,
                                    left: 20),
                                child: Obx(
                                  () =>
                                      controller.poitemlist.value.items == null
                                          ? const Text(
                                              'Data Bahan Kosong',
                                              textScaleFactor: 1,
                                            )
                                          : const PoItemDetails(),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, top: 10, right: 20, bottom: 10),
                                child: Obx(
                                  () => TextFormField(
                                      enabled:
                                          controller.poitemlist.value.status ==
                                                      'DONE' ||
                                                  controller.poitemlist.value
                                                          .status ==
                                                      'CANCEL'
                                              ? false
                                              : true,
                                      controller:
                                          controller.controllersNote.value,
                                      keyboardType: TextInputType.text,
                                      onSaved: (String? val) {},
                                      validator: ValidationBuilder().build(),
                                      decoration: CustomFormWidget
                                          .customInputDecorationWithSuffix(
                                              'isi catatan bila kosong',
                                              'Catatan',
                                              Icons.note),
                                      // onEditingComplete: () =>
                                      // node.nextFocus(),
                                      onFieldSubmitted: (value) {
                                        controller.controllersNote.value.text =
                                            value;
                                        controller.poitemlist.value.note =
                                            value;
                                      },
                                      onChanged: (value) => {
                                            // controller.controllersNote.value.text =
                                            //     value;
                                            controller.poitemlist.value.note =
                                                value
                                          }),
                                ),
                              ),
                              Container(
                                width: size.width,
                                height: 50,
                                color: Colors.transparent,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: SizedBox(
                                          child: ElevatedButton(
                                            child: const Text(
                                              'Ubah',
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              primary: primaryYellow,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        5), // <-- Radius
                                              ),
                                            ),
                                            onPressed: controller.poitemlist
                                                            .value.status !=
                                                        'CANCEL' &&
                                                    controller.poitemlist.value
                                                            .status !=
                                                        'DONE'
                                                ? () {
                                                    dialogUp(controller, 1);
                                                    // controller.updateData();
                                                  }
                                                : null,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      SizedBox(
                                        child: ElevatedButton(
                                          child: const Text(
                                            'Batal',
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            primary: primaryBlue,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      5), // <-- Radius
                                            ),
                                          ),
                                          onPressed: controller.poitemlist.value
                                                          .status !=
                                                      'CANCEL' &&
                                                  controller.poitemlist.value
                                                          .status !=
                                                      'DONE'
                                              ? () {
                                                  dialogUp(controller, 2);
                                                  // controller.cancelData();
                                                }
                                              : null,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                    ],
                                  ),
                                ),
                              ),
                              PoItemPic(),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, top: 1, right: 20, bottom: 10),
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                        width: 1.0, color: primaryBlue),
                                  ),
                                  child: Stack(
                                    children: const [
                                      Align(
                                          alignment: Alignment.centerRight,
                                          child: Icon(
                                            Icons.save,
                                            color: primaryBlue,
                                          )),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Simpan Bukti',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: primaryBlue),
                                        ),
                                      ),
                                    ],
                                  ),
                                  onPressed: controller.disableButtonUpload()
                                      ? () {
                                          controller.prePostImages();
                                        }
                                      : null,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, top: 10, right: 20, bottom: 10),
                                child: Obx(
                                  () {
                                    return DropdownButtonFormField<String>(
                                      items: controller.statusStatement.value,
                                      value: controller.poitemlist.value.status,
                                      decoration: CustomFormWidget
                                          .customInputDecoration(
                                              '', 'Status Pernyataan'),
                                      // onChanged: (value) {
                                      //   controller.itempo.value[index].status = value!;
                                      // },
                                      onChanged:
                                          controller.poitemlist.value.status ==
                                                      'DONE' ||
                                                  controller.poitemlist.value
                                                          .status ==
                                                      'CANCEL'
                                              ? null
                                              : (value) {
                                                  controller.poitemlist.value
                                                      .status = value!;
                                                },
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, top: 5, right: 20, bottom: 10),
                                child: Obx(
                                  () {
                                    return DropdownButtonFormField<String>(
                                      // key: controller.dropStatus,
                                      items: controller.statusPayment.value,
                                      value: controller
                                          .poitemlist.value.expenses?.status,
                                      decoration: CustomFormWidget
                                          .customInputDecoration(
                                              '', 'Status Pembayaran'),
                                      // onChanged: (value) {
                                      //   controller.itempo.value[index].status = value!;
                                      // },
                                      onChanged:
                                          controller.poitemlist.value.status ==
                                                      'DONE' ||
                                                  controller.poitemlist.value
                                                          .status ==
                                                      'CANCEL'
                                              ? null
                                              : (value) {
                                                  controller
                                                      .poitemlist
                                                      .value
                                                      .expenses
                                                      ?.status = value!;
                                                },
                                    );
                                  },
                                ),
                              ),
                              Obx(() {
                                if (controller.disableButtonUpload()) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Text(
                                      'Upload Bukti Terlebih Dahulu sebelum menyetujui',
                                      // maxLines: 1,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 8.0.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                      ),
                                    ),
                                  );
                                } else {
                                  return const Text(
                                      'Tekan "Setuju" jika ingin menyetujui belanjaan ini');
                                }
                              }),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, top: 1, right: 20, bottom: 10),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: primaryBlue,
                                    side: const BorderSide(
                                        width: 0.0, color: Colors.transparent),
                                  ),
                                  child: Stack(
                                    children: const [
                                      Align(
                                          alignment: Alignment.centerRight,
                                          child: Icon(Icons.done_all)),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Setujui',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                  onPressed: controller.whoIs.value ==
                                              'MANAGER' &&
                                          controller.poitemlist.value.status !=
                                              'DONE' &&
                                          controller.poitemlist.value.status !=
                                              'CANCEL'
                                      ? () {
                                          dialogUp(controller, 0);
                                          // controller.proofData();
                                        }
                                      : null,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

AppBar buildAppBar(PoItemDetailsController controller) {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.transparent,
    automaticallyImplyLeading: false,
    title: const Text(
      'Rincian',
      style: TextStyle(color: Colors.black),
    ),
    centerTitle: true,
    actions: [
      TextButton(
        style: TextButton.styleFrom(
          textStyle: const TextStyle(fontSize: 20),
        ),
        onPressed: () {
          Get.back(result: controller.isUpdate.value);
        },
        child: const Text('Kembali'),
      ),
    ],
  );
}

Stack getCardBuild(BuildContext context, PoItemDetailsController controller) {
  Size size = MediaQuery.of(context).size;
  return Stack(
    alignment: Alignment.bottomCenter,
    children: [
      Container(
        height: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: primaryBlue,
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 15),
              blurRadius: 27,
              color: Colors.black12,
            ), //BoxShadow
            BoxShadow(
              offset: Offset(0, 15),
              blurRadius: 27,
              color: Colors.black12,
            ), //BoxShadow
          ],
        ),
        child: Container(
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22), color: primaryYellow),
        ),
      ),
      Positioned(
        top: 0,
        right: 0,
        child: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          height: 100,
          width: 100,
          child: getStatus(controller.poitemlist.value.status),
        ),
      ),
      Positioned(
        top: 10,
        bottom: 0,
        left: 0,
        child: SizedBox(
          height: 120,
          width: size.width - 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'No. ${controller.poitemlist.value.orderNo}',
                  textScaleFactor: 1.1,
                  maxLines: 1,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Catatan : ${controller.poitemlist.value.note}',
                  textScaleFactor: 0.9,
                  maxLines: 1,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  '${controller.poitemlist.value.warehouse?.name}',
                  textScaleFactor: 0.9,
                  maxLines: 1,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Suplier/Toko : ${controller.poitemlist.value.suplier?.name ?? ''}',
                  textScaleFactor: 0.9,
                  // maxLines: 1,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
      Positioned(
        child: Container(
          width: size.width,
          height: 40,
          color: Colors.transparent,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Pembayaran',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              getStatusPayment(controller.poitemlist.value.expenses?.status!),
            ],
          ),
        ),
      )
    ],
  );
}

class PoItemDetails extends GetView<PoItemDetailsController> {
  const PoItemDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var node = FocusScope.of(context);
    return Obx(
      () => ListView.builder(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemCount: controller.poitemlist.value.items?.length,
          itemBuilder: (context, index) {
            controller.controllersCost.value.add(TextEditingController(
                text:
                    controller.poitemlist.value.items?[index].cost.toString()));
            controller.controllersQty.value.add(TextEditingController(
                text: controller.poitemlist.value.items?[index].quantity
                    .toString()));

            return Card(
                elevation: 5,
                child: Obx(
                  () => Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, top: 5, right: 10, bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "Nama Bahan.",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF282828),
                              ),
                            ),
                            Text(
                              controller.poitemlist.value.items?[index].name ??
                                  '',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF282828),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 10, top: 5, right: 10, bottom: 5),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Obx(
                                  () => TextFormField(
                                    enabled: controller.poitemlist.value
                                                    .items?[index].status ==
                                                'DONE' ||
                                            controller
                                                    .poitemlist.value.status ==
                                                'DONE' ||
                                            controller
                                                    .poitemlist.value.status ==
                                                'CANCEL'
                                        ? false
                                        : true,
                                    controller:
                                        controller.controllersQty.value[index],
                                    keyboardType: TextInputType.number,
                                    onSaved: (String? val) {},
                                    validator: ValidationBuilder().build(),
                                    decoration: CustomFormWidget
                                        .customInputDecorationWithSuffix(
                                            'Qty',
                                            'Jumlah/Kuantitas',
                                            Icons.production_quantity_limits),
                                    // onEditingComplete: () =>
                                    // node.nextFocus(),
                                    onFieldSubmitted: (value) {
                                      controller.qtyChange(index, value);
                                    },
                                    onChanged: (value) =>
                                        controller.qtyChange(index, value),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 2.5.w,
                              ),
                              Text(
                                controller
                                        .poitemlist.value.items?[index].unit ??
                                    '',
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFF282828),
                                ),
                              ),
                            ],
                          )),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, top: 1, right: 10, bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 1,
                              child: ElevatedButton(
                                onPressed: controller.poitemlist.value
                                                .items?[index].status ==
                                            'DONE' ||
                                        controller.poitemlist.value.status ==
                                            'DONE' ||
                                        controller.poitemlist.value.status ==
                                            'CANCEL'
                                    ? null
                                    : () {
                                        controller.minus(index);
                                      },
                                child: const Icon(
                                  Icons.minimize,
                                  color: Color(0xFFFBFBFB),
                                  size: 24.0,
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: primaryYellow,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(5), // <-- Radius
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 2.5.w,
                            ),
                            Expanded(
                              flex: 1,
                              child: ElevatedButton(
                                onPressed: controller.poitemlist.value
                                                .items?[index].status ==
                                            'DONE' ||
                                        controller.poitemlist.value.status ==
                                            'DONE' ||
                                        controller.poitemlist.value.status ==
                                            'CANCEL'
                                    ? null
                                    : () {
                                        controller.plus(index);
                                      },
                                child: const Icon(
                                  Icons.add,
                                  color: Color(0xFFFBFBFB),
                                  size: 24.0,
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: primaryBlue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(5), // <-- Radius
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, top: 5, right: 10, bottom: 10),
                        child: TextFormField(
                          enabled: controller.poitemlist.value.items?[index]
                                          .status ==
                                      'DONE' ||
                                  controller.poitemlist.value.status ==
                                      'DONE' ||
                                  controller.poitemlist.value.status == 'CANCEL'
                              ? false
                              : true,
                          controller: controller.controllersCost.value[index],
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            CurrencyTextInputFormatter(
                              locale: 'id',
                              decimalDigits: 0,
                              symbol: 'Rp ',
                            ),
                          ],
                          onSaved: (String? val) {},
                          validator: ValidationBuilder().build(),
                          decoration:
                              CustomFormWidget.customInputDecorationWithSuffix(
                                  'Harga', 'Biaya', Icons.money),
                          onEditingComplete: () => node.nextFocus(),
                          onFieldSubmitted: (value) {
                            controller.priceOnSubmit(index, value);
                          },
                          onChanged: (value) => controller.priceChange(index),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, top: 5, right: 10, bottom: 10),
                        child: Obx(
                          () {
                            return DropdownButtonFormField<String>(
                              // key: controller.dropStatus,
                              items: controller.statusSt.value,
                              value: controller.itempo.value[index].status,
                              decoration:
                                  CustomFormWidget.customInputDecoration(
                                      '', 'Status'),
                              // onChanged: (value) {
                              //   controller.itempo.value[index].status = value!;
                              // },
                              onChanged: controller.poitemlist.value.status ==
                                      'DONE'
                                  ? null
                                  : (value) {
                                      controller.itempo.value[index].status =
                                          value!;
                                    },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ));
          }),
    );
  }
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

getStatusPayment(String? status) {
  switch (status) {
    case 'UNPAID':
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
    case 'PAID':
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
    case 'CANCEL':
      return Container(
        constraints: const BoxConstraints(minWidth: 100),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), // <= No more error here :)
          color: const Color(0xFFB81755),
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        margin: const EdgeInsets.only(bottom: 5.0),
        child: const Text(
          "Batal",
          style: TextStyle(fontSize: 14, color: Color(0xFFFFFFFF)),
        ), // Text
      );
    default:
      return const Text('');
  }
}

dialogUp(PoItemDetailsController controller, int choose) {
  switch (choose) {
    case 0:
      Get.defaultDialog(
          title: "Setuju?",
          middleText: "Anda akan menyetujui orderan ini, lanjutkan?",
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
            controller.proofData();
          });
      break;
    case 1:
      Get.defaultDialog(
          title: "Ubah?",
          middleText: "Anda akan merubah orderan ini, lanjutkan?",
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
            controller.updateData();
          });
      break;
    case 2:
      Get.defaultDialog(
          title: "Batal?",
          middleText: "Anda akan membatalkan orderan ini, lanjutkan?",
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
            controller.cancelData();
          });
      break;
    default:
  }
}
