import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/commons/size_config.dart';
import 'package:siangmalam/widgets/default_button.dart';

class CheckoutCard extends StatelessWidget {
  const CheckoutCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 4.w,
        horizontal: getProportionateScreenWidth(30),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -15),
            blurRadius: 20,
            color: mtGrey900.withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row(
            //   children: [
            //     // Container(
            //     //   padding: const EdgeInsets.all(10),
            //     //   height: getProportionateScreenWidth(40),
            //     //   width: getProportionateScreenWidth(40),
            //     //   decoration: BoxDecoration(
            //     //     color: whiteBg,
            //     //     borderRadius: BorderRadius.circular(10),
            //     //   ),
            //     //   child: SvgPicture.asset("assets/icons/receipt.svg"),
            //     // ),
            //     // const Spacer(),
            //     // const Text("Add voucher code"),
            //     //  SizedBox(width: 2.w),
            //     const Icon(
            //       Icons.arrow_forward_ios,
            //       size: 12,
            //       color: textColor,
            //     )
            //   ],
            // ),
            // SizedBox(height: getProportionateScreenHeight(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text.rich(
                  TextSpan(
                    text: "Total:\n",
                    children: [
                      TextSpan(
                        text: "\$337.15",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(190),
                  child: DefaultButton(
                    text: "Bayar",
                    press: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
