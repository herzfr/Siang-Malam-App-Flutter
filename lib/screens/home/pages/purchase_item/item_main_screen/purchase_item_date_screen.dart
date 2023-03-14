import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/po-purchasing/item/po-item.controller.dart';
import 'package:siangmalam/commons/custom_style.dart';
import 'package:siangmalam/commons/theme.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/form_values.dart';
import 'package:sizer/sizer.dart';

class PurchaseItemDate extends GetView<PoItemControllerV2> {
  const PurchaseItemDate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90.w,
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: primaryYellow,
        boxShadow: [
          boxShadowStyle,
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 2.w),
            child: Text(
              "Filter Tanggal",
              style: panelTitleTextSytle,
            ),
          ),
          Obx(
            () => InkWell(
              onTap: () {
                showPicker(context);
              },
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.calendar_month,
                      color: mtGrey700,
                      size: 8.5.w,
                    ),
                  ),
                  SizedBox(
                    width: 0.5.w,
                  ),
                  Row(
                    children: [
                      Text(
                        controller.displayStartDate.value,
                        style: TextStyle(
                            color: mtGrey700,
                            fontWeight: FontWeight.w500,
                            fontSize: 11.sp),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_right,
                        color: mtGrey700,
                      ),
                      Text(
                        controller.displayEndDate.value,
                        style: const TextStyle(
                            color: mtGrey700, fontWeight: FontWeight.w500),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  showPicker(BuildContext context) {
    showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 1),
      saveText: datePickerSaveTxt,
      builder: (context, child) {
        return datePickerTheme(child!);
      },
    ).then(
      (value) {
        if (value != null) {
          controller.setDate(value.start, value.end);
        }
      },
    );
  }
}
