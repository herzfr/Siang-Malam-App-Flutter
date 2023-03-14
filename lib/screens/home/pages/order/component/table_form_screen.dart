import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/order/table_form_controller.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/values.dart';
import 'package:siangmalam/widgets/custom_input.dart';
import 'package:sizer/sizer.dart';

class TableFormScreen extends GetView<TableFormController> {
  const TableFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundimage),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: const Color.fromARGB(0, 237, 248, 243),
            appBar: PreferredSize(
              preferredSize:
                  const Size.fromHeight(60.0), // here the desired height
              child: buildAppBar(controller),
            ),
            body: initForm(context),
            bottomNavigationBar: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: SizedBox(
                  // width: 200.0,
                  height: 50.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          child: ElevatedButton(
                            child: const Text(
                              'Submit',
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: primaryYellow,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(5), // <-- Radius
                              ),
                            ),
                            onPressed: () => controller.submit(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      controller.initDeleteButton() &&
                              controller.lTable!.isOccupied! == false
                          ? SizedBox(
                              child: ElevatedButton(
                                child: const Text(
                                  'hapus',
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: primaryBlue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(5), // <-- Radius*
                                  ),
                                ),
                                onPressed: () => Get.defaultDialog(
                                    title: "Anda Yakin?",
                                    middleText:
                                        "Check terlebih dahulu jika ada orderan yang masih nempel",
                                    backgroundColor: whiteBg,
                                    titleStyle:
                                        const TextStyle(color: mtGrey700),
                                    middleTextStyle:
                                        const TextStyle(color: mtGrey700),
                                    textConfirm: confirmYes,
                                    textCancel: confirmNo,
                                    cancelTextColor: mtGrey700,
                                    confirmTextColor: mtGrey700,
                                    buttonColor: primaryYellow,
                                    onConfirm: () {
                                      Get.back();
                                      controller.deleteTable();
                                    }),
                              ),
                            )
                          : Container(),
                      const SizedBox(width: 5),
                    ],
                  ),
                ))));
  }

  AppBar buildAppBar(TableFormController controller) {
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
              controller.onClear();
              Get.back(result: true);
            },
            // tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        },
      ),
      title: const Text(
        'Meja',
        style: TextStyle(color: Color(0xFFFFFFFF)),
      ),
      centerTitle: true,
    );
  }

  Form initForm(BuildContext context) {
    var node = FocusScope.of(context);
    return Form(
      key: controller.formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(children: [
          SizedBox(
            height: 1.5.h,
          ),
          Obx(
            () => CustomInputFieldWithController(
              controller: controller.textFieldUpsertTableNameController.value,
              hint: "Masukan nama meja",
              label: "Nama Meja",
              enable: true,
              icon: Icons.table_bar,
              node: node,
              inputType: TextInputType.text,
              dataInstance: (String? val) {},
              validationBuilder:
                  ValidationBuilder(requiredMessage: "kolom ini harus terisi!")
                      .minLength(1, "minimal 1 karakter")
                      .maxLength(5, "maximal 5 karakter")
                      .build(),
            ),
          ),
          SizedBox(
            height: 1.5.h,
          ),
          Obx(
            () => CustomInputFieldWithController(
              controller: controller.textFieldUpsertTableDescController.value,
              hint: "Masukan keteranga meja",
              label: "Keterangan",
              enable: true,
              icon: Icons.description,
              node: node,
              inputType: TextInputType.text,
              dataInstance: (String? val) {},
              validationBuilder:
                  ValidationBuilder(requiredMessage: "kolom ini harus terisi!")
                      .minLength(1, "minimal 1 karakter")
                      .maxLength(10, "maximal 10 karakter")
                      .build(),
            ),
          ),
        ]),
      ),
    );
  }
}
