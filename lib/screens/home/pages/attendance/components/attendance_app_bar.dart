import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/commons/custom_style.dart';
import 'package:siangmalam/commons/controllers/home/attendance_controller.dart';

/* Created By Dwi Sutrisno */

class AttendanceAppBar extends GetView<AttendanceController> {
  const AttendanceAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          appBarIconButton(Icons.chevron_left, 10.w, () {
            Get.back();
          }),
          appBarIconButton(Icons.refresh, 5.w, () {
            controller.getCurrentLocation();
          }),
        ],
      ),
    ));
  }

  Container appBarIconButton(IconData icon, double iconSize, VoidCallback press) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 1.h),
      height: 10.w,
      width: 10.w,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: roundedIconBtnStyleBorder,
          backgroundColor: primaryYellow,
          elevation: 5,
          padding: EdgeInsets.zero,
        ),
        onPressed: press,
        child: Icon(
          icon,
          color: mtGrey800,
          size: 8.w,
        ),
      ),
    );
  }
}
