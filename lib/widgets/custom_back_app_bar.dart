import 'package:get/get.dart';
import 'package:siangmalam/commons/custom_style.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:siangmalam/constans/values.dart';
import 'package:siangmalam/constans/colors.dart';

/* Created By Dwi Sutrisno */

class CustomBackAppBar extends StatelessWidget {
  const CustomBackAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Row(
        children: [
          SizedBox(
            height: 10.w,
            width: 10.w,
            child: TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                // primary: mtGrey700,
                backgroundColor: primaryYellow,
                elevation: 5,
                padding: EdgeInsets.zero,
              ),
              onPressed: () => Get.back(),
              child: SvgPicture.asset(
                iconBack,
                height: 4.5.w,
                color: mtGrey800,
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

class CustomAppbarWithTitle extends StatelessWidget implements PreferredSizeWidget {
  
  const CustomAppbarWithTitle({Key? key, required this.title, required this.backIcon}) : super(key: key);

  final String title;
  final IconData backIcon;

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: appBarTitleStyle,
      ),
      leading: Container(
        padding: EdgeInsets.only(left: 4.w),
        child: RawMaterialButton(
          onPressed: () {
            Get.back();
          },
          elevation: 2.0,
          fillColor: primaryYellow,
          child: Icon(
            backIcon,
            size: 9.w,
            color: mtGrey800,
          ),
          shape: const CircleBorder(),
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
    );
  }
}
