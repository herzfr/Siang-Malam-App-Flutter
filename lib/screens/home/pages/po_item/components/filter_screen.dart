import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/po/po_item_controller.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/screens/home/pages/po_item/components/date_filter_panel.dart';
import 'package:siangmalam/widgets/custom_input.dart';
import 'package:sizer/sizer.dart';

class FilterScreen extends GetView<PoItemController> {
  const FilterScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.arrow_drop_up,
              color: primaryGrey,
            ),
            const SizedBox(
              height: 5,
            ),
            Obx(() {
              return DropdownButtonFormField<int>(
                // key: controller.dropStatus,
                items: controller.subbranch,
                value: controller.subBranchId.value,
                decoration:
                    CustomFormWidget.customInputDecoration('', 'Cabang'),
                onChanged: (value) {
                  controller.subBranchId.value = value!;
                  controller.searchData();
                },
              );
            }),
            const SizedBox(
              height: 20,
            ),
            Obx(() {
              return DropdownButtonFormField<String>(
                // key: controller.dropStatus,
                items: controller.itemStatus,
                value: controller.status.value,
                decoration: CustomFormWidget.customInputDecoration(
                    '', 'Status Pembayaran'),
                onChanged: (value) {
                  controller.status.value = value!;
                  controller.searchData();
                },
              );
            }),
            const SizedBox(
              height: 20,
            ),
            Obx(() {
              return DropdownButtonFormField<String>(
                // key: controller.dropStatus,
                items: controller.itemOpt,
                value: controller.option.value,
                decoration:
                    CustomFormWidget.customInputDecoration('', 'Berdasarkan'),
                onChanged: (value) {
                  controller.option.value = value!;
                  controller.searchData();
                },
              );
            }),
            const SizedBox(
              height: 20,
            ),
            Obx(() {
              return DropdownButtonFormField<String>(
                // key: controller.dropStatus,
                items: controller.itemorderBy,
                value: controller.orderBy.value,
                decoration:
                    CustomFormWidget.customInputDecoration('', 'Pesanan'),
                onChanged: (value) {
                  controller.orderBy.value = value!;
                  controller.searchData();
                },
              );
            }),
            const SizedBox(
              height: 20,
            ),
            Obx(() {
              return DropdownButtonFormField<String>(
                // key: controller.dropStatus,
                items: controller.itemsortBy,
                value: controller.sortBy.value,
                decoration:
                    CustomFormWidget.customInputDecoration('', 'Urutan'),
                onChanged: (value) {
                  controller.sortBy.value = value!;
                  controller.searchData();
                },
              );
            }),
            const SizedBox(
              height: 20,
            ),
            const DateFilterPanel(),
          ]),
    );
  }
}
