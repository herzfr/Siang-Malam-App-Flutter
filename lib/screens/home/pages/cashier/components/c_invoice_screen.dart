import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/cashier/invoice_controller.dart';
import 'package:sizer/sizer.dart';

class CashierInvoiceListScreen extends GetView<InvoiceListController> {
  const CashierInvoiceListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              // color: Colors.green,
              alignment: Alignment.center,
              height: 100.h,
              child: Text("Daftar Invoice"),
            ),
          ),
          // Expanded(
          //   flex: 3,
          //   child: Container(
          //     color: Colors.yellow,
          //   ),
          // ),
        ],
      ),
    );
  }
}
