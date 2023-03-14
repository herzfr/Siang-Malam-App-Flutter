import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/product/transfer_product_receive_controller.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/values.dart';
import 'package:sizer/sizer.dart';

class TransferProductReceiveScreen
    extends GetView<TransferReceiveProductController> {
  static String routeName = " /transfer-products/receive";
  const TransferProductReceiveScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: buildAppBar(context),
        body: Obx(() => body()));
  }

  Container body() {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(10.sp),
        child: ListView.builder(
          itemCount: controller.productUpsert.length,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.symmetric(vertical: 0.5.h),
            child: Obx(
              () => initCartCard(context, index),
            ),
          ),
        ),
      ),
    );
  }

  Container initCartCard(BuildContext ctx, int idx) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(10.sp),
        child: Row(
          children: [
            Expanded(
              flex: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => Text(
                      controller.productUpsert[idx].name ?? '',
                      style: TextStyle(
                        color: primaryDarkGreen,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  // const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: Obx(
                          () => Text(
                            'Produk Sampai : ' +
                                controller.productUpsert[idx].quantity
                                    .toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp,
                              color: primaryBlue,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          height: 30,
                          width: 30,
                          child: TextButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(primaryGoldText)),
                            child: const Text('-',
                                style: TextStyle(color: Colors.white)),
                            onPressed: () {
                              controller.minus(idx);
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          height: 30,
                          width: 30,
                          child: TextButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    primaryDarkGreen)),
                            child: const Text('+',
                                style: TextStyle(color: Colors.white)),
                            onPressed: () {
                              controller.plus(idx);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Estimasi Jumlah Produk Sampai',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 10.sp,
                            color: primaryDarkGreen,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '${controller.productUpsert[idx].quantityFrom.toString()} Qty',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14.sp,
                            color: primaryGoldText,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        backgroundColor: primaryDarkGreen,
        elevation: 2,
        leading: IconButton(
          padding: EdgeInsets.only(left: 5.w),
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Expanded(
            flex: 7,
            child: Text(
              "Rincian Transfer",
              style: TextStyle(color: Colors.white, fontSize: 9.sp),
            ),
          ),
          Expanded(
            flex: 3,
            child: ElevatedButton(
              child: Text(
                'Terima',
                style: TextStyle(color: primaryDarkGreen, fontSize: 9.sp),
              ),
              style: ElevatedButton.styleFrom(
                primary: primaryLightGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              onPressed: () {
                Get.defaultDialog(
                    title: "Terima?",
                    middleText: "Anda ingin menerima produk, lanjutkan?",
                    backgroundColor: whiteBg,
                    titleStyle: const TextStyle(color: mtGrey700),
                    middleTextStyle: const TextStyle(color: mtGrey700),
                    textConfirm: confirmYes,
                    textCancel: confirmNo,
                    cancelTextColor: mtGrey700,
                    confirmTextColor: mtGrey700,
                    buttonColor: primaryYellow,
                    onConfirm: () {
                      FocusScope.of(context).requestFocus(null);
                      Get.back();
                      controller.doConfirm();
                    });
              },
            ),
          )
        ]));
  }
}
