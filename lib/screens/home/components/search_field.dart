import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:siangmalam/constans/colors.dart';

/* Created By Dwi Sutrisno */

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.w,
      // height: 6.h,
      decoration: BoxDecoration(
          color: primaryGrey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15)),
      child: TextField(
        onChanged: (_) {},
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: "Search...",
          prefixIcon: const Icon(Icons.search, color: primaryGrey),
          contentPadding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 2.h),
        ),
      ),
    );
  }
}
