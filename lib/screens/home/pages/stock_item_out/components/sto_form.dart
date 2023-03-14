import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/sto/sto_form_controller.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/widgets/custom_input.dart';
import 'package:sizer/sizer.dart';

class StoForm extends GetView<StoFormController> {
  const StoForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: controller.formKey,
      child: Padding(
        padding: EdgeInsets.only(
            top: 2.h,
            right: 2.w,
            left: 2.w,
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Obx(
                  () => DropdownButtonFormField<int>(
                    // key: controller.dropStatus,
                    items: controller.subbranch,
                    value: null,
                    decoration:
                        CustomFormWidget.customInputDecoration('', 'Gudang'),
                    onChanged: (value) {
                      print(value);
                      controller.warehouseid = value;
                      controller.changeWarehouse();
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Obx(
                  () => TextFormField(
                      enabled: true,
                      controller: controller.textFieldNoteController.value,
                      keyboardType: TextInputType.text,
                      onSaved: (String? val) {},
                      validator:
                          ValidationBuilder(requiredMessage: 'wajib diisi')
                              .build(),
                      decoration:
                          CustomFormWidget.customInputDecorationWithSuffix(
                              'isi catatan bila kosong', 'Catatan', Icons.note),
                      // onEditingComplete: () => node.nextFocus(),
                      onFieldSubmitted: (value) {
                        controller.stDto.value.note = value;
                      },
                      onChanged: (value) => {
                            controller.stDto.value.note = value
                            // controller.poItemCreate.value.note = value
                          }),
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      EdgeInsets.only(top: 5, bottom: 15.h, right: 5, left: 5),
                  child: Obx(() => controller.it.isEmpty
                      ? const Text(
                          'Data Bahan Masih Kosong',
                          textScaleFactor: 1,
                        )
                      : Container(
                          width: size.width,
                          height: size.height,
                          color: Colors.transparent,
                          child: const ListStoCreate(),
                        )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ListStoCreate extends GetView<StoFormController> {
  const ListStoCreate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var node = FocusScope.of(context);
    return Obx(
      () => ListView.builder(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          // reverse: true,
          itemCount: controller.it.value.length,
          itemBuilder: (context, index) {
            controller.controllersQty.value
                .add(TextEditingController(text: 0.toString()));

            return Center(
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: Text(
                        (index + 1).toString(),
                        style: const TextStyle(color: Colors.black),
                        textScaleFactor: 1.3,
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(controller.it.value[index].name ?? ''),
                          IconButton(
                            icon: const Icon(Icons.delete_forever),
                            tooltip: 'Hapus bahan',
                            onPressed: () {
                              controller.deleteItem(index);
                            },
                          )
                        ],
                      ),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Persediaan Awal : ${controller.it.value[index].initalStock}',
                            style: const TextStyle(color: Colors.black),
                          ),
                          Text(
                              'Sisa Bahan : ${controller.it.value[index].itemStock}',
                              style: const TextStyle(color: Colors.black)),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
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
                                        'Jumlah/${controller.listSto.value[index].items?.unit}',
                                        Icons.production_quantity_limits),
                                // onEditingComplete: () =>
                                // node.nextFocus(),
                                initialValue: null,
                                onFieldSubmitted: (value) {
                                  controller.qtyChange(index, value);
                                },
                                onChanged: (value) =>
                                    controller.quantityIntChange(index))),
                          ),
                        ),
                        TextButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(primaryYellow)),
                          child: const Text('-',
                              style: TextStyle(color: Colors.white)),
                          onPressed: () {
                            controller.minus(index);
                          },
                        ),
                        const SizedBox(width: 8),
                        TextButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(primaryBlue)),
                          child: const Text('+',
                              style: TextStyle(color: Colors.white)),
                          onPressed: () {
                            controller.plus(index);
                          },
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
