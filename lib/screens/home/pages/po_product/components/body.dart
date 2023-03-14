import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:siangmalam/commons/controllers/po-product/po_product_controller.dart';
import 'package:siangmalam/commons/routes/routes_name.dart';
import 'package:siangmalam/constans/colors.dart';
import 'dart:ui' as ui;
import 'package:sizer/sizer.dart';

import 'package:siangmalam/models/purchase-order-product/po_products.dart';

class BodyPoProduct extends GetView<PoProductController> {
  const BodyPoProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return PagedListView<int, PoProductList>.separated(
        pagingController: controller.pagingController.value,
        // padding: const EdgeInsets.all(0),
        separatorBuilder: (context, index) => SizedBox(
          height: 0.1.h,
        ),
        shrinkWrap: true,
        builderDelegate: PagedChildBuilderDelegate<PoProductList>(
          itemBuilder: (context, poprod, index) => Card(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  // color: Colors.red,
                  height: 20.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                        colors: [primaryDarkGreen, primaryGoldText],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight),
                    boxShadow: const [
                      BoxShadow(
                          color: primaryDarkGreen,
                          blurRadius: 10,
                          offset: Offset(0, 0))
                    ],
                  ),
                ),
                Positioned(
                  right: -10,
                  bottom: 0,
                  top: 0,
                  child: CustomPaint(
                    size: const Size(100, 150),
                    painter: CustomCardShapePainters(
                        10, primaryGoldText, primaryGoldText),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5.sp),
                      child: ListTile(
                        leading: getStatus(poprod.status),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 7,
                              child: Text(
                                'No. ${poprod.orderNo}',
                                style: GoogleFonts.raleway(
                                    fontSize: 12.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              width: 1.w,
                            ),
                            Expanded(
                              flex: 3,
                              child: ElevatedButton.icon(
                                label: Text(
                                  'Rincian',
                                  style: GoogleFonts.raleway(
                                      fontSize: 7.sp,
                                      color: primaryDarkGreen,
                                      fontWeight: FontWeight.bold),
                                ),
                                icon: Icon(
                                  Icons.list_alt,
                                  size: 9.sp,
                                  color: primaryDarkGreen,
                                ),
                                onPressed: () {
                                  controller.chooseDetail(index);
                                  Get.toNamed(RouteName.poProductDetailsScreen)
                                      ?.then((value) => {
                                            if (value) {controller.searchData()}
                                          });
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              'GUDANG ',
                              style: GoogleFonts.raleway(
                                  fontSize: 8.sp,
                                  color: Colors.white,
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              poprod.warehouse!.name ?? '-',
                              textAlign: TextAlign.right,
                              style: GoogleFonts.raleway(
                                  fontSize: 8.sp,
                                  color: Colors.white,
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              'DIBUAT ',
                              style: GoogleFonts.raleway(
                                  fontSize: 8.sp,
                                  color: Colors.white,
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              poprod.createdAt ?? '-',
                              textAlign: TextAlign.right,
                              style: GoogleFonts.raleway(
                                  fontSize: 8.sp,
                                  color: Colors.white,
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              'DIUBAH ',
                              style: GoogleFonts.raleway(
                                  fontSize: 8.sp,
                                  color: Colors.white,
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              poprod.updatedAt ?? '-',
                              textAlign: TextAlign.right,
                              style: GoogleFonts.raleway(
                                  fontSize: 8.sp,
                                  color: Colors.white,
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.w, vertical: 0.5.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'PEMBAYARAN ',
                            style: GoogleFonts.raleway(
                                fontSize: 8.sp,
                                color: Colors.white,
                                letterSpacing: 2,
                                fontWeight: FontWeight.bold),
                          ),
                          getStatusPayment(poprod.expenses!.status)
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      // color: Colors.white,
                      height: 5.h,
                      decoration: const BoxDecoration(
                          // borderRadius: BorderRadius.circular(5.0),
                          color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text(
                          poprod.note ?? '-',
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          softWrap: false,
                          style: GoogleFonts.raleway(
                              fontSize: 8.sp,
                              color: Colors.black,
                              letterSpacing: 2,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

      // );
    });
  }

  Column getStatus(String? status) {
    switch (status) {
      case 'CREATED':
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Icon(
              Icons.create,
              color: Colors.blueAccent,
              size: 24.0,
            ),
            Text(
              "DIBUAT",
              style: TextStyle(
                  // backgroundColor: Colors.blue,
                  color: Colors.blueAccent,
                  letterSpacing: 0.3),
            ),
          ],
        );
      case 'DONE':
        return Column(
          children: const [
            Icon(
              Icons.done_all,
              color: Colors.green,
              size: 24.0,
            ),
            Text(
              "SELESAI",
              style: TextStyle(
                  // backgroundColor: Colors.blue,
                  color: Colors.green,
                  letterSpacing: 0.3),
            ),
          ],
        );
      case 'CANCEL':
        return Column(
          children: const [
            Icon(
              Icons.cancel,
              color: Colors.pink,
              size: 24.0,
            ),
            Text(
              "BATAL",
              style: TextStyle(
                  // backgroundColor: Colors.blue,
                  color: Colors.pink,
                  letterSpacing: 0.3),
            ),
          ],
        );
      default:
        return Column(
          children: const [
            Icon(
              Icons.change_circle,
              color: Colors.grey,
              size: 24.0,
            ),
            Text(
              "DIUBAH",
              style: TextStyle(
                  // backgroundColor: Colors.blue,
                  color: Colors.grey,
                  letterSpacing: 0.3),
            ),
          ],
        );
      // return const Text('');
    }
  }

  getStatusPayment(String? status) {
    switch (status) {
      case 'UNPAID':
        return Container(
          constraints: const BoxConstraints(minWidth: 100),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), // <= No more error here :)
            color: const Color(0xFFdc3545),
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          margin: const EdgeInsets.only(bottom: 5.0),
          child: const Text(
            "Belum Bayar",
            style: TextStyle(fontSize: 14, color: Color(0xFFFFFFFF)),
          ), // Text
        );
      case 'PAID':
        return Container(
          constraints: const BoxConstraints(minWidth: 100),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), // <= No more error here :)
            color: const Color(0xFF28a745),
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          margin: const EdgeInsets.only(bottom: 5.0),
          child: const Text(
            "Lunas",
            style: TextStyle(fontSize: 14, color: Color(0xFFFFFFFF)),
          ), // Text
        );
      case 'PENDING':
        return Container(
          constraints: const BoxConstraints(minWidth: 100),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), // <= No more error here :)
            color: const Color(0xF2B88D17),
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          margin: const EdgeInsets.only(bottom: 5.0),
          child: const Text(
            "Pending",
            style: TextStyle(fontSize: 14, color: Color(0xFFFFFFFF)),
          ), // Text
        );
      case 'CANCEL':
        return Container(
          constraints: const BoxConstraints(minWidth: 100),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), // <= No more error here :)
            color: const Color(0xFFB81755),
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          margin: const EdgeInsets.only(bottom: 5.0),
          child: const Text(
            "Batal",
            style: TextStyle(fontSize: 14, color: Color(0xFFFFFFFF)),
          ), // Text
        );
      default:
        return const Text('');
    }
  }
}

class CustomCardShapePainters extends CustomPainter {
  final double radius;
  final Color startColor;
  final Color endColor;

  CustomCardShapePainters(this.radius, this.startColor, this.endColor);
  @override
  void paint(Canvas canvas, Size size) {
    var radius = 20.0;

    var paint = Paint();
    paint.shader = ui.Gradient.linear(
        const Offset(0, 0), Offset(size.width, size.height), [
      HSLColor.fromColor(startColor).withLightness(0.7).toColor(),
      endColor
    ]);

    var path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width - radius, size.height)
      ..quadraticBezierTo(
          size.width, size.height, size.width, size.height - radius)
      ..lineTo(size.width, radius)
      ..quadraticBezierTo(size.width, 0, size.width - radius, 0)
      ..lineTo(size.width - 1.5 * radius, 0)
      ..quadraticBezierTo(-radius, 2 * radius, 0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomCardShapePainters oldDelegate) {
    return true;
  }

  // @override
  // bool shouldRebuildSemantics(CustomCardShapePainter oldDelegate) => true;

}
