import 'package:siangmalam/constans/colors.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';

// Created By Dwi Sutrisno

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key? key,
    required this.title,
    required this.press,
  }) : super(key: key);

  final String title;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 13.5.sp,
            color: Colors.black,
          ),
        ),
        GestureDetector(
          onTap: press,
          child: const Text(
            "See More",
            style: TextStyle(color: primaryGrey),
          ),
        ),
      ],
    );
  }
}
