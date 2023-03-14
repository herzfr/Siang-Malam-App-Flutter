// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/values.dart';
import 'package:siangmalam/screens/home/pages/stock_product/components/body.dart';
import 'package:sizer/sizer.dart';

class StockProductScreen extends StatelessWidget {
  static String routeName = "/stockproduct";
  const StockProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundimagerm),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(1.h),
            child: Container(
              color: primaryDarkGreen,
            ),
          ),
          body: Body(),
        ));
  }
}
