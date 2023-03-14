import 'package:flutter/material.dart';
import 'package:siangmalam/models/product.dart';
import 'package:siangmalam/widgets/custom_input.dart';
import 'package:siangmalam/widgets/rounded_icon_btn.dart';
import 'package:sizer/sizer.dart';


class ColorDots extends StatelessWidget {
  const ColorDots({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    // Now this is fixed and only for demo
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: 5.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 30.w,
            // height: 10.h,
            child: TextField(
              // maxLength: 2,
              keyboardType: TextInputType.number,
              decoration: CustomFormWidget.customInputDecoration("", "Jumlah"),
            ),
          ),
          // const Spacer(),
          RoundedIconBtn(
            icon: Icons.remove,
            press: () {},
          ),
          SizedBox(width: 5.w),
          RoundedIconBtn(
            icon: Icons.add,
            showShadow: true,
            press: () {},
          ),
        ],
      ),
    );
  }
}
