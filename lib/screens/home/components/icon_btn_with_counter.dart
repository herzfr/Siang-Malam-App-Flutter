import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:siangmalam/constans/colors.dart';

/* Created By Dwi Sutrisno */

class IconBtnWithCounter extends StatelessWidget {

  const IconBtnWithCounter({
    required this.svgSrc,
    required this.numOfItems,
    required this.press,
  }) : super();

  final IconData svgSrc;
  final int numOfItems;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      borderRadius: BorderRadius.circular(50),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.all(3.5.w),
            height: 6.4.h,
            width: 12.w,
            decoration: BoxDecoration(
              color: primaryGrey.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              svgSrc,
              color: primaryGrey,
            ),
          ),
          if (numOfItems != 0)
            Positioned(
              top: -3,
              right: 0,
              child: Container(
                height: 5.5.w,
                width: 6.w,
                decoration: BoxDecoration(
                  color: mtRed600,
                  shape: BoxShape.circle,
                  border: Border.all(width: 1.5, color: textColor),
                ),
                child: Center(
                  child: Text(
                    '$numOfItems',
                    style: TextStyle(
                        color: textColor,
                        fontSize: 6.2.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
