import 'package:sizer/sizer.dart';
import 'top_rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:siangmalam/models/product.dart';
import 'package:siangmalam/widgets/default_button.dart';
import 'package:siangmalam/screens/product_detail/components/amount.dart';
import 'package:siangmalam/screens/product_detail/components/product_images.dart';
import 'package:siangmalam/screens/product_detail/components/product_description.dart';

/* Created By Dwi Sutrisno */

class Body extends StatelessWidget {
  final Product product;

  const Body({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        ProductImages(product: product),
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ProductDescription(
                product: product,
                pressOnSeeMore: () {},
              ),
              TopRoundedContainer(
                color: Colors.white,
                child: Column(
                  children: [
                    ColorDots(product: product),
                    TopRoundedContainer(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 10.w,
                          right: 10.w,
                          bottom: 5.h,
                          top: 1.w,
                        ),
                        child: DefaultButton(
                          text: "Add To Cart",
                          press: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
