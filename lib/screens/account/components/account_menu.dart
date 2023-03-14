import 'package:siangmalam/widgets/custom_button.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';

// Created By Dwi Sutrisno

class AccountMenu extends StatelessWidget {
  const AccountMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.press,
  }) : super(key: key);

  final String text, icon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.3.h),
      child: CustomButtonWithIcon(assets: icon, text: text,icon: Icons.arrow_forward_ios, press: press),
    );
  }
}
