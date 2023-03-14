import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/sto/sto_controller.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/screens/home/pages/stock_item_out/components/sto_date.dart';
import 'package:siangmalam/widgets/custom_input.dart';
import 'package:sizer/sizer.dart';

class StoFilterScreen extends GetView<StoController> {
  const StoFilterScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
        const Icon(
          Icons.arrow_drop_up,
          color: primaryGrey,
        ),
        const SizedBox(
          height: 5,
        ),
        DropdownButtonFormField<int>(
          // key: controller.dropStatus,
          items: controller.subbranch,
          value: null,
          decoration: CustomFormWidget.customInputDecoration('', 'Cabang'),
          onChanged: (value) {
            controller.subBranchId = value;
            controller.searchData();
          },
        ),
        const SizedBox(
          height: 20,
        ),
        DropdownButtonFormField<String>(
          // key: controller.dropStatus,
          items: controller.itemsortBy,
          value: controller.sortBy.value,
          decoration: CustomFormWidget.customInputDecoration('', 'Urutan'),
          onChanged: (value) {
            controller.sortBy.value = value!;
            controller.searchData();
          },
        ),
        const SizedBox(
          height: 20,
        ),
        const StoDateFilterPanel(),
      ]),
    );
  }
}
