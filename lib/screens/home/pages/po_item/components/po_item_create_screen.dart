import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/po/po_item_create_controller.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/values.dart';
import 'package:siangmalam/screens/home/pages/po_item/components/filter_items_screen.dart';
import 'package:siangmalam/widgets/custom_input.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:sizer/sizer.dart';

class PoItemCreateScreen extends GetView<PoItemCreateController> {
  const PoItemCreateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.panelHeightOpen = MediaQuery.of(context).size.height * .70;
    Size size = MediaQuery.of(context).size;
    var bottom = MediaQuery.of(context).viewInsets.bottom;
    var appBar = buildAppBar(controller);
    var node = FocusScope.of(context);

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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.openClosePanelControl();
          },
          backgroundColor: primaryYellow,
          child: const Icon(
            Icons.search,
            color: Colors.black,
          ),
        ),
        // body: const Body(),
        body: SlidingUpPanel(
          maxHeight: controller.panelHeightOpen,
          minHeight: controller.panelHeightClosed,
          controller: controller.pcs,
          parallaxEnabled: true,
          parallaxOffset: .10,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
          panel: const Center(
            child: FilterItemsScreen(),
          ),
          body: Form(
            key: controller.formKey,
            child: SingleChildScrollView(
              reverse: true,
              child: Padding(
                padding: EdgeInsets.only(bottom: 15.h),
                child: Container(
                  constraints: BoxConstraints(minHeight: 100.h),
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Obx(
                        () => Padding(
                          padding: EdgeInsets.only(
                              left: 20,
                              top: controller.listItem.value.isEmpty
                                  ? 110.0
                                  : 10.0,
                              right: 20,
                              bottom: 10),
                          child: Obx(
                            () => TextFormField(
                                enabled: true,
                                controller:
                                    controller.textFieldNoteController.value,
                                keyboardType: TextInputType.text,
                                onSaved: (String? val) {},
                                validator: ValidationBuilder(
                                        requiredMessage: 'wajib diisi')
                                    .build(),
                                decoration: CustomFormWidget
                                    .customInputDecorationWithSuffix(
                                        'isi catatan bila kosong',
                                        'Catatan',
                                        Icons.note),
                                onEditingComplete: () => node.nextFocus(),
                                onFieldSubmitted: (value) {
                                  controller.textFieldNoteController.value
                                      .text = value;
                                  controller.poItemCreate.value.note = value;
                                },
                                onChanged: (value) => {
                                      // controller.controllersNote.value.text =
                                      //     value;
                                      controller.poItemCreate.value.note = value
                                    }),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, top: 10, right: 20, bottom: 10),
                        child: Obx(
                          () {
                            return DropdownButtonFormField<int>(
                              // key: controller.dropStatus,
                              items: controller.itemWarehouse.value,
                              value: controller.poItemCreate.value.warehouseId,
                              decoration:
                                  CustomFormWidget.customInputDecoration(
                                      '', 'Pilih Dapur Penyimpanan'),
                              validator: (value) {
                                if (value == null) {
                                  return 'wajib di pilih';
                                }
                              },
                              onChanged: (value) {
                                controller.poItemCreate.value.warehouseId =
                                    value!;
                              },
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, top: 10, right: 20, bottom: 10),
                        child: Obx(
                          () {
                            return DropdownButtonFormField<int>(
                              // key: controller.dropStatus,
                              items: controller.itemSuplier.value,
                              value: controller.poItemCreate.value.suplierId,
                              decoration:
                                  CustomFormWidget.customInputDecoration(
                                      '', 'Pilih Suplier/Toko'),
                              onChanged: (value) {
                                controller.poItemCreate.value.suplierId =
                                    value!;
                              },
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                            right: 20,
                            left: 20),
                        child: Obx(
                          () => controller.listItem.value.isEmpty
                              ? const Text(
                                  'Data Bahan Masih Kosong',
                                  textScaleFactor: 1,
                                )
                              : const ListCreate(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

AppBar buildAppBar(PoItemCreateController controller) {
  return AppBar(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(30),
      ),
    ),
    elevation: 0,
    backgroundColor: primaryYellow,
    // automaticallyImplyLeading: false,
    leading: Builder(
      builder: (BuildContext context) {
        return IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            // Scaffold.of(context).openDrawer();
            Get.back(result: controller.isUpdate.value);
          },
          // tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        );
      },
    ),
    title: const Text(
      'Belanja Bahan',
      style: TextStyle(color: Color(0xFF2A2A2A)),
    ),
    centerTitle: true,
    actions: [
      Obx(
        () => TextButton(
          style: TextButton.styleFrom(
            elevation: 0,
            primary: const Color(0xFF0A64FF),
            backgroundColor: Colors.transparent,
            onSurface: Colors.grey,
            padding: EdgeInsets.zero,
            // minimumSize: const Size(50, 50),
            alignment: Alignment.center,
            textStyle: const TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          onPressed: controller.listItem.isNotEmpty
              ? () {
                  Get.defaultDialog(
                      title: "Buat?",
                      middleText:
                          "Anda akan ingin membuat orderan ini, lanjutkan?",
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
                        controller.createPoItem();
                      });
                }
              : null,
          child: const Text(
            'Buat',
            style: TextStyle(color: primaryBlue, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ],
  );
}

class ListCreate extends GetView<PoItemCreateController> {
  const ListCreate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemCount: controller.listItem.value.length,
        itemBuilder: (context, index) {
          controller.controllersCost.value.add(TextEditingController(
              text: controller.listItem.value[index].cost.toString()));
          controller.controllersQty.value.add(TextEditingController(
              text: controller.listItem.value[index].quantity.toString()));

          return Card(
            elevation: 5,
            child: Obx(
              () => Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 1, top: 1, right: 1, bottom: 1),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                            width: 0.0, color: Colors.transparent),
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              (index + 1).toString(),
                              style: const TextStyle(color: primaryBlue),
                            ),
                          ),
                          const Align(
                              alignment: Alignment.centerRight,
                              child: Icon(
                                Icons.delete,
                                color: primaryBlue,
                              )),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              controller.listItem.value[index].name ?? '',
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: primaryBlue),
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
                        controller.deleteItem(index);
                      },
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 10, top: 5, right: 10, bottom: 5),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Obx(() => TextFormField(
                                enabled: true,
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
                                    controller.quantityIntChange(index))),
                          ),
                          SizedBox(
                            width: 2.5.w,
                          ),
                          Text(
                            controller.listItem.value[index].unit ?? '',
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
                            onPressed: () {
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
                            onPressed: () {
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
                        left: 10, top: 5, right: 10, bottom: 5),
                    child: TextFormField(
                      enabled: true,
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
                      // onEditingComplete: () => node.nextFocus(),
                      onFieldSubmitted: (value) {
                        controller.priceOnSubmit(index, value);
                      },
                      onChanged: (value) => controller.priceChange(index),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
