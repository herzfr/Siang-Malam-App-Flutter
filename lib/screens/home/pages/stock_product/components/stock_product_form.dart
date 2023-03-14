import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/form_values.dart';
import 'package:siangmalam/constans/values.dart';
import 'package:siangmalam/models/warehouse/warehouse.dart';
import 'package:siangmalam/widgets/custom_back_app_bar.dart';
import 'package:siangmalam/widgets/custom_button.dart';
import 'package:siangmalam/widgets/custom_input.dart';
import 'package:sizer/sizer.dart';
import 'package:siangmalam/commons/controllers/product/stock_product_form_controller.dart';

class StockProductFormScreen extends StatelessWidget {
  static String routeName = "/stockproduct/transfer";
  const StockProductFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        constraints: BoxConstraints(minHeight: 100.h),
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage(backgroundimage),
          fit: BoxFit.cover,
        )),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisSize: MainAxisSize.max,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomBackAppBar(),
            SizedBox(
              height: 2.5.h,
            ),
            Text(
              "Transfer Persediaan",
              style: TextStyle(fontSize: 20.0.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 3.h,
            ),
            const StockProductForm()
          ],
        ),
      ),
    ));
  }
}

class StockProductForm extends GetView<StockProductFormController> {
  const StockProductForm({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var node = FocusScope.of(context);
    final TextStyle headline4 = Theme.of(context).textTheme.bodyLarge!;
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Obx(() {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Container(
                  margin: const EdgeInsets.only(right: 10),
                  height: 10.h,
                  width: 100.w,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    boxShadow: [
                      BoxShadow(
                        color: greyBG,
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 0),
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Obx(
                        () => Text(
                          controller.productName,
                          style: GoogleFonts.raleway(
                              textStyle: headline4,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Obx(
                        () => Text(
                          controller.fromWarehouse,
                          style: GoogleFonts.raleway(
                              textStyle: headline4,
                              fontWeight: FontWeight.normal,
                              fontSize: 14),
                        ),
                      ),
                    ],
                  )),
              const SizedBox(height: 20),
              DropdownButtonFormField<ListWarehouse>(
                key: controller.dropdownState,
                items: controller.menuItems,
                value: null,
                decoration: CustomFormWidget.customInputDecoration(
                    dropdownwarehouseLabel, dropdownwarehouseHint),
                onChanged: (value) {
                  // print("data => " + value.toString());
                  controller.selectedItem.value = value ?? ListWarehouse();
                },
                // hint: const Text(
                //   'Pilih Gudang',
                // ),
                isExpanded: true,
              ),
              const SizedBox(height: 10),
              Form(
                key: controller.formKey,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: CustomInputFieldWithController(
                        controller: controller.fromQty,
                        hint: "Transfer Persediaan",
                        label: labelQuantityFrom,
                        enable: false,
                        icon: Icons.arrow_right,
                        node: node,
                        inputType: TextInputType.number,
                        dataInstance: (String? val) {},
                        validationBuilder: ValidationBuilder().build(),
                      ),
                    ),
                    const Expanded(
                      flex: 1,
                      child: ImageIcon(
                        AssetImage("assets/images/arrow_transfer.png"),
                        color: Color.fromARGB(255, 32, 2, 2),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: CustomInputFieldWithController(
                        controller: controller.toQty,
                        hint: "Transfer Persediaan",
                        label: labelQuantityTo,
                        enable: true,
                        icon: Icons.arrow_left,
                        node: node,
                        inputType: TextInputType.number,
                        dataInstance: (String? val) {},
                        validationBuilder: ValidationBuilder().build(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.remove();
                        },
                        child: const Icon(Icons.exposure_minus_1),
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all(const CircleBorder()),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(20)),
                          backgroundColor: MaterialStateProperty.all(
                              primaryYellow), // <-- Button color
                          overlayColor:
                              MaterialStateProperty.resolveWith<Color?>(
                                  (states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.redAccent;
                            } // <-- Splash color
                          }),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.add();
                        },
                        child: const Icon(Icons.plus_one),
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all(const CircleBorder()),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(20)),
                          backgroundColor: MaterialStateProperty.all(
                              primaryYellow), // <-- Button color
                          overlayColor:
                              MaterialStateProperty.resolveWith<Color?>(
                                  (states) {
                            if (states.contains(MaterialState.pressed)) {
                              return primaryGreen;
                            } // <-- Splash color
                          }),
                        ),
                      ),
                    ),
                  ]),
              const SizedBox(height: 10),
              CustomButton(
                text: 'Transfer Persediaan',
                icon: Icons.send,
                press: () {
                  controller.submitTransfer();
                },
              ),
              // Expanded(
              //   flex: 1,
              //   child: CustomButton(
              //     text: btnSaveTxt,
              //     icon: Icons.save,
              //     press: () {
              //       controller.submitProfile();
              //     },
              //   ),
              // ),
            ],
          );
        }));
  }
}
