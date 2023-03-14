import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:sizer/sizer.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback press;

  const CustomButton({Key? key, required this.text, required this.press, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 6.8.h,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: primaryYellow, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), elevation: 4.0),
          onPressed: press,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              Text(
                text,
                style: TextStyle(fontSize: 12.5.sp, color: mtGrey700, fontWeight: FontWeight.bold),
              ),
              Icon(
                icon,
                color: mtGrey700,
                size: 3.5.h,
              )
            ],
          )),
    );
  }
}

class CustomButtonWithIcon extends StatelessWidget {
  final String assets;
  final String text;
  final IconData icon;
  final VoidCallback? press;

  const CustomButtonWithIcon({required this.assets, required this.text, required this.icon, required this.press, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        elevation: 5,
        primary: mtGrey700,
        padding: EdgeInsets.all(3.4.w),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        backgroundColor: primaryYellow,
      ),
      onPressed: press,
      child: Row(
        children: [
          SvgPicture.asset(
            assets,
            color: mtGrey700,
            width: 4.5.w,
          ),
          SizedBox(width: 5.w),
          Expanded(child: Text(text, style: TextStyle(fontSize: 9.sp),)),
          Icon(
            icon,
            color: mtGrey700,
            size: 2.5.h,
          ),
        ],
      ),
    );
  }
}
