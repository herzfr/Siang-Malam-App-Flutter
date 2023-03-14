import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:siangmalam/models/product.dart';
import 'package:siangmalam/commons/size_config.dart';
import 'package:siangmalam/screens/home/components/product_card.dart';
import 'section_title.dart';

class PopularProducts extends StatelessWidget {
  
  const PopularProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 5.w),
          child: SectionTitle(title: "Popular Products", press: () {}),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                demoProducts.length,
                (index) {
                  
                  if (demoProducts[index].isPopular) {
                    return ProductCard(product: demoProducts[index]);
                  }

                  return const SizedBox
                      .shrink(); //jika kosong tampilkan widget kosong
                },
              ),
              SizedBox(width: 5.w),
            ],
          ),
        )
      ],
    );
  }
}
