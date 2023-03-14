import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:siangmalam/models/cart.dart';
import 'package:siangmalam/constans/colors.dart';

// Created By Dwi Sutrisno

class CartCard extends StatelessWidget {
  const CartCard({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: customGrey2,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.asset(cart.product.images[0]),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cart.product.title,
              style: const TextStyle(color: Colors.black, fontSize: 16),
              maxLines: 2,
            ),
            const SizedBox(height: 10),
            Text.rich(
              TextSpan(
                text: "Rp${cart.product.price}",
                style:  TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12.sp,
                  color: primaryYellow,
                ),
                children: [
                  TextSpan(
                    text: " x${cart.numOfItem}",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
