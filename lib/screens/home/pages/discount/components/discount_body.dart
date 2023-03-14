import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:siangmalam/commons/controllers/discount/discount_controller.dart';
import 'package:siangmalam/commons/routes/routes_name.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/values.dart';
import 'package:siangmalam/models/discount/discount.dart';
import 'package:sizer/sizer.dart';

class DiscountBody extends GetView<DiscountController> {
  const DiscountBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      constraints: BoxConstraints(minHeight: size.height),
      width: size.width,
      // height: size.height,
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(horizontal: 1.w),
      child: SizedBox(
        height: size.height,
        child: Column(children: [
          // Expanded(
          //   flex: 1,
          //   child: Container(
          //     height: MediaQuery.of(context).size.height,
          //     color: Colors.transparent,
          //     child: Card(
          //       color: Colors.amberAccent,
          //       child: Column(
          //         children: [
          //           ListTile(
          //             leading: const Icon(Icons.question_answer),
          //             title: const Text('Diskon'),
          //             subtitle: Text(
          //               'Setiap diskon memiliki tipe Rp untuk mengatur pengurangan dalam bentuk uang, dan % pengurangan dalam bentuk persenan.',
          //               style: TextStyle(color: Colors.black.withOpacity(0.6)),
          //               textScaleFactor: 0.7,
          //             ),
          //           )
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          Expanded(
            // flex: 5,
            child: Container(child: getListView(controller)),
          ),
          // getListView(controller)
        ]),
      ),
    );
  }
}

getListView(DiscountController controller) {
  return Obx(
    () {
      return PagedListView<int, ListDiscount>.separated(
        pagingController: controller.pagingController.value,
        // padding: const EdgeInsets.all(0),
        separatorBuilder: (context, index) => const SizedBox(
          height: 0,
        ),
        // shrinkWrap: true,
        builderDelegate: PagedChildBuilderDelegate<ListDiscount>(
          itemBuilder: (context, disc, index) => Card(
            clipBehavior: Clip.antiAlias,
            child: Column(children: [
              ListTile(
                leading:
                    Icon(Icons.discount, size: 16.sp, color: primaryGoldText),
                title: Text(
                  disc.name ?? '',
                  style: GoogleFonts.raleway(
                      fontSize: 12.sp,
                      color: primaryGoldText,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  disc.description ?? '',
                  style: GoogleFonts.raleway(
                      fontSize: 9.sp,
                      color: primaryGrey,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Tipe.',
                          style: GoogleFonts.raleway(
                              fontSize: 9.sp,
                              color: primaryGoldText,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                          flex: 0,
                          child: getType(
                            disc.type ?? '',
                          ))
                    ],
                  )),
              Padding(
                  padding: const EdgeInsets.only(
                      left: 10, top: 1, right: 10, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.all(1.sp),
                          child: OutlinedButton(
                            style: ElevatedButton.styleFrom(
                              primary: primaryDarkGreen,
                              side: const BorderSide(
                                  width: 1, color: Colors.transparent),
                            ),
                            child: Stack(
                              children: const [
                                Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(
                                      Icons.update,
                                      color: Colors.white,
                                    )),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Ubah',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                            onPressed: () {
                              print(disc.toJson());
                              controller.discSelected.value = disc;
                              Get.toNamed(RouteName.discountFormScreen)
                                  // ignore: avoid_print
                                  ?.then((value) => {
                                        if (value != null)
                                          {
                                            value
                                                ? controller.searchDataGeneral()
                                                : null
                                          }
                                      });
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 2.5.w,
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.pink,
                          size: 16.sp,
                        ),
                        tooltip: 'hapus diskon',
                        onPressed: () {
                          Get.defaultDialog(
                              title: "Hapus Diskon ${disc.name}",
                              middleText:
                                  "Anda akan menghapus diskon ${disc.name}, lanjutkan?",
                              backgroundColor: whiteBg,
                              titleStyle: const TextStyle(color: mtGrey700),
                              middleTextStyle:
                                  const TextStyle(color: mtGrey700),
                              textConfirm: confirmYes,
                              textCancel: confirmNo,
                              cancelTextColor: mtGrey700,
                              confirmTextColor: mtGrey700,
                              buttonColor: primaryYellow,
                              onConfirm: () {
                                Get.back();
                                controller.submitDelete(disc.id!);
                              });
                        },
                      ),
                    ],
                  ))
            ]),
          ),
        ),
      );
    },
  );
}

getType(String type) {
  switch (type) {
    case 'PERCENT':
      return Text(
        '%',
        style: GoogleFonts.raleway(
            fontSize: 12.sp,
            color: primaryGoldText,
            letterSpacing: 1,
            fontWeight: FontWeight.bold),
      );
    case 'RUPIAH':
      return Text(
        'Rp',
        style: GoogleFonts.raleway(
            fontSize: 9.sp,
            color: primaryGoldText,
            letterSpacing: 1,
            fontWeight: FontWeight.bold),
      );
    default:
  }
}
