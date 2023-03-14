import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siangmalam/commons/controllers/po-product/po_product_controller.dart';
import 'package:siangmalam/commons/custom_style.dart';
import 'package:siangmalam/commons/theme.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/form_values.dart';
import 'package:sizer/sizer.dart';

class DateFilterPanelProduct extends GetView<PoProductController> {
  const DateFilterPanelProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90.w,
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: primaryGoldText,
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
              style: GoogleFonts.raleway(
                  fontSize: 9.sp,
                  color: Colors.white,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold),
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
                      color: Colors.white,
                      size: 20.sp,
                    ),
                  ),
                  SizedBox(
                    width: 0.5.w,
                  ),
                  Row(
                    children: [
                      Text(
                        controller.displayStartDate.value,
                        style: GoogleFonts.raleway(
                            fontSize: 10.sp,
                            color: Colors.white,
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.white,
                        size: 14.sp,
                      ),
                      Text(
                        controller.displayEndDate.value,
                        style: GoogleFonts.raleway(
                            fontSize: 10.sp,
                            color: Colors.white,
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold),
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
