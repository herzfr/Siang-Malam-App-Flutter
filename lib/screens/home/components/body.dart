import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/home/home_controller.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/values.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:siangmalam/screens/home/components/categories.dart';
import 'package:siangmalam/screens/home/components/discount_banner.dart';

// Created By Dwi Sutrisno

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      // color: primaryLightGrey,
      // decoration: const BoxDecoration(
      //   image: DecorationImage(
      //     image: AssetImage(backgroundimagerm),
      //     fit: BoxFit.cover,
      //   ),
      // ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // SizedBox(height: 0.5.h),
              // const HomeHeader(),
              SizedBox(height: 2.5.h),
              const DiscountBanner(),
              SizedBox(height: 2.5.h),
              Categories(),
              // SizedBox(height: 2.3.h),
              // const SpecialOffers(),
              // SizedBox(height: 2.5.h),
              // const PopularProducts()
            ],
          ),
        ),
      ),
    );
  }
}
