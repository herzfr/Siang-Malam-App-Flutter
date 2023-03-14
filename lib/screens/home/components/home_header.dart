import 'package:get/get.dart';
import 'package:siangmalam/commons/routes/routes_name.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:siangmalam/screens/home/components/search_field.dart';
import 'package:siangmalam/screens/home/components/icon_btn_with_counter.dart';

/* Created By Dwi Sutrisno */

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // input field
          const  SearchField(),
          // keranjang icons
          IconBtnWithCounter(
            svgSrc: Icons.shopping_cart_outlined,
            numOfItems: 2,
            press: () {
              print("cart");
              Get.toNamed(RouteName.cartScreen); 
            },
          ),
          IconBtnWithCounter(
            svgSrc: Icons.notifications_none_outlined,
            numOfItems: 0,
            press: () {},
          ),
        ],
      ),
    );
  }
}
