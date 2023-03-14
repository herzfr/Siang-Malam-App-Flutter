import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/screens/product_detail/components/body.dart';
import 'package:siangmalam/screens/product_detail/components/custom_app_bar.dart';

import '../../models/product.dart';

// Created By Dwi Sutrisno

class ProductDetailsScreen extends StatelessWidget {

  const ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Product data = Get.arguments;

    return Scaffold(
      backgroundColor: whiteBg,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: CustomAppBar(rating: data.rating),
      ),
      body: Body(product: data),
    );
  }
}

class ProductDetailsArguments {
  final Product product;

  ProductDetailsArguments({required this.product});
}
