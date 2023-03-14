import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/home/home_controller.dart';
import 'package:siangmalam/constans/values.dart';
import 'package:sizer/sizer.dart';
// import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/widgets/snack_bar.dart';
import 'package:siangmalam/services/app_static.dart';
import 'package:siangmalam/commons/custom_style.dart';
import 'package:siangmalam/models/branch/branch.dart';
import 'package:siangmalam/models/user/user_level.dart';
import 'package:siangmalam/commons/routes/routes_name.dart';
import 'package:siangmalam/models/attendance/coordinate.dto.dart';
import 'package:siangmalam/services/attendance/attendance_service.dart';

/* Created By Dwi Sutrisno */

class Categories extends StatelessWidget {
  Categories({Key? key}) : super(key: key);
  HomeController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Obx(
          () => _gridView(controller),
        ));
  }
}

showList(HomeController controller) {
  List<Map<String, dynamic>> categories = [];
  // print("=====");
  // print(controller.userDto.value.role);
  // print(AppStatic.userData.role);
  // print("=====");
  switch (controller.userDto.value.role) {
    case "KASIR":
      categories = [
        {"icon": "assets/icons/Cart.svg", "text": "Pesanan", "route": RouteName.orderScreen},
        {"icon": "assets/icons/Cashier.svg", "text": "Kasir", "route": RouteName.cashierScreen},
        {
          "icon": "assets/icons/Supplies.svg",
          "text": "Suplier",
          "route": RouteName.suplierScreen,
          "type": "button",
        },
        {
          "icon": "assets/icons/Customer.svg",
          "text": "Customer",
          "route": RouteName.customerScreen,
          "type": "button",
        },
        {
          "icon": "assets/icons/List Product.svg",
          "text": "Belanja Produk",
          "route": RouteName.poProductScreen,
          "type": "button",
        },
        {
          "icon": "assets/icons/List Items.svg",
          "text": "Belanja Bahan",
          "route": RouteName.poItemScreen,
          "type": "button",
        },
      ];
      break;
    case "USER":
      categories = [
        {"icon": "assets/icons/Cart.svg", "text": "Pesanan", "route": RouteName.orderScreen},
        {
          "icon": "assets/icons/Printer.svg",
          "text": "Printer",
          "route": RouteName.printerScreen,
          "type": "button",
        },
      ];
      break;
    case "MANAGER":
      categories = [
        {
          "icon": "assets/icons/Supplies.svg",
          "text": "Suplier",
          "route": RouteName.suplierScreen,
          "type": "button",
        },
        {
          "icon": "assets/icons/Customer.svg",
          "text": "Customer",
          "route": RouteName.customerScreen,
          "type": "button",
        },
        {
          "icon": "assets/icons/List Product.svg",
          "text": "Belanja Produk",
          "route": RouteName.poProductScreen,
          "type": "button",
        },
        {
          "icon": "assets/icons/List Items.svg",
          "text": "Belanja Bahan",
          "route": RouteName.poItemScreen,
          "type": "button",
        },
        {
          "icon": "assets/icons/Product.svg",
          "text": "Stok Produk",
          "route": RouteName.stockProductScreen,
          "type": "button",
        },
        {
          "icon": "assets/icons/Items.svg",
          "text": "Stok Bahan",
          "route": RouteName.stockItemScreen,
          "type": "button",
        },
        {
          "icon": "assets/icons/Discount.svg",
          "text": "Diskon",
          "route": RouteName.discountScreen,
          "type": "button",
        },
        {
          "icon": "assets/icons/Bill.svg",
          "text": "Laporan Bill",
          "route": RouteName.reportBillScreen,
          "type": "button",
        },
        {
          "icon": "assets/icons/Debt.svg",
          "text": "Laporan Kasbon",
          "route": RouteName.reportCashbonScreen,
          "type": "button",
        },
        {
          "icon": "assets/icons/Income.svg",
          "text": "Pendapatan",
          "route": RouteName.unknownScreen,
          "type": "button",
        },
        {
          "icon": "assets/icons/Analysis.svg",
          "text": "Laporan",
          "route": RouteName.unknownScreen,
          "type": "button",
        },
        {
          "icon": "assets/icons/Printer.svg",
          "text": "Printer",
          "route": RouteName.printerScreen,
          "type": "button",
        },
        {
          "icon": "assets/icons/Product.svg",
          "text": "Transfer Produk",
          "route": RouteName.stockProductScreen,
          "type": "button",
        },
      ];
      break;
    case "ADMIN":
      categories = [
        {
          "icon": "assets/icons/Wallet.svg",
          "text": "Arus Kas",
          "route": RouteName.unknownScreen,
          "type": "button",
        },
        {
          "icon": "assets/icons/Bill.svg",
          "text": "Pembayaran",
          "route": RouteName.unknownScreen,
          "type": "button",
        },
        {
          "icon": "assets/icons/Product.svg",
          "text": "Stok Produk",
          "route": RouteName.stockProductScreen,
          "type": "button",
        },
        {
          "icon": "assets/icons/Items.svg",
          "text": "Stok Bahan",
          "route": RouteName.stockItemScreen,
          "type": "button",
        },
        {
          "icon": "assets/icons/List Product.svg",
          "text": "Belanja Produk",
          "route": RouteName.poProductScreen,
          "type": "button",
        },
        {
          "icon": "assets/icons/List Items.svg",
          "text": "Belanja Bahan",
          "route": RouteName.poItemScreen,
          "type": "button",
        },
        {
          "icon": "assets/icons/Stock-out.svg",
          "text": "Bahan Keluar",
          "route": RouteName.stoScreen,
          "type": "button",
        },
        {
          "icon": "assets/icons/Discount.svg",
          "text": "Diskon",
          "route": RouteName.discountScreen,
          "type": "button",
        },
        {
          "icon": "assets/icons/Income.svg",
          "text": "Pendapatan",
          "route": RouteName.unknownScreen,
          "type": "button",
        },
        {
          "icon": "assets/icons/Expense.svg",
          "text": "Pengeluaran",
          "route": RouteName.unknownScreen,
          "type": "button",
        },
        {
          "icon": "assets/icons/Supplies.svg",
          "text": "Suplier",
          "route": RouteName.suplierScreen,
          "type": "button",
        },
        {
          "icon": "assets/icons/Customer.svg",
          "text": "Customer",
          "route": RouteName.customerScreen,
          "type": "button",
        },
        {
          "icon": "assets/icons/Device Scan.svg",
          "text": "Absen",
          "route": RouteName.attendanceScreen,
          "type": "options",
        },
        {
          "icon": "assets/icons/Analysis.svg",
          "text": "Laporan",
          "route": RouteName.unknownScreen,
          "type": "button",
        },
        {
          "icon": "assets/icons/Printer.svg",
          "text": "Printer",
          "route": RouteName.printerScreen,
          "type": "button",
        },
        {
          "icon": "assets/icons/Product.svg",
          "text": "Transfer Produk",
          "route": RouteName.stockProductScreen,
          "type": "button",
        },
      ];
      break;
    default:
      categories = [
        {"icon": "assets/icons/Cart.svg", "text": "Pesanan", "route": RouteName.orderScreen},
        {"icon": "assets/icons/Cashier.svg", "text": "Kasir", "route": RouteName.cashierScreen},
        {
          "icon": "assets/icons/Wallet.svg",
          "text": "Arus Kas",
          "route": RouteName.unknownScreen,
          "type": "button",
        },
        {
          "icon": "assets/icons/Bill.svg",
          "text": "Pembayaran",
          "route": RouteName.unknownScreen,
          "type": "button",
        },
        {
          "icon": "assets/icons/Product.svg",
          "text": "Stok Produk",
          "route": RouteName.stockProductScreen,
          "type": "button",
        },
        {
          "icon": "assets/icons/Items.svg",
          "text": "Stok Bahan",
          "route": RouteName.stockItemScreen,
          "type": "button",
        },
        {
          "icon": "assets/icons/List Product.svg",
          "text": "Belanja Produk",
          "route": RouteName.poProductScreen,
          "type": "button",
        },
        {
          "icon": "assets/icons/List Items.svg",
          "text": "Belanja Bahan",
          "route": RouteName.poItemScreen,
          "type": "button",
        },
        {
          "icon": "assets/icons/Stock-out.svg",
          "text": "Bahan Keluar",
          "route": RouteName.stoScreen,
          "type": "button",
        },
        {
          "icon": "assets/icons/Discount.svg",
          "text": "Diskon",
          "route": RouteName.discountScreen,
          "type": "button",
        },
        {
          "icon": "assets/icons/Income.svg",
          "text": "Pendapatan",
          "route": RouteName.unknownScreen,
          "type": "button",
        },
        {
          "icon": "assets/icons/Expense.svg",
          "text": "Pengeluaran",
          "route": RouteName.unknownScreen,
          "type": "button",
        },
        {
          "icon": "assets/icons/Supplies.svg",
          "text": "Suplier",
          "route": RouteName.suplierScreen,
          "type": "button",
        },
        {
          "icon": "assets/icons/Customer.svg",
          "text": "Customer",
          "route": RouteName.customerScreen,
          "type": "button",
        },
        {
          "icon": "assets/icons/Device Scan.svg",
          "text": "Absen",
          "route": RouteName.attendanceScreen,
          "type": "options",
        },
        {
          "icon": "assets/icons/Analysis.svg",
          "text": "Laporan",
          "route": RouteName.unknownScreen,
          "type": "button",
        },
        {
          "icon": "assets/icons/Printer.svg",
          "text": "Printer",
          "route": RouteName.printerScreen,
          "type": "button",
        },
        {
          "icon": "assets/icons/Product.svg",
          "text": "Transfer Produk",
          "route": RouteName.stockProductScreen,
          "type": "button",
        },
      ];
      break;
  }

  return categories;
}

GridView _gridView(HomeController controller) {
  // List<Map<String, dynamic>> categories = controller.categories;

  return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 70.sp, childAspectRatio: 1, crossAxisSpacing: 10, mainAxisSpacing: 20),
      physics: const BouncingScrollPhysics(),
      // to disable GridView's scrolling
      shrinkWrap: true,
      itemCount: controller.categories.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext ctx, index) {
        switch (controller.categories[index]['type']) {
          case 'options':
            return Obx(() => CategoryCard(
                  icon: controller.categories[index]['icon'],
                  text: controller.categories[index]['text'],
                  press: () {
                    attendanceAction();
                  },
                ));
          default:
            return Obx(
              () => CategoryCard(
                icon: controller.categories[index]['icon'],
                text: controller.categories[index]['text'],
                press: () {
                  Get.toNamed(controller.categories[index]['route']);
                },
              ),
            );
        }
      });
}

Future<dynamic> attendanceAction() {
  var userBranchData = AppStatic.userBranchData;
  int subBranchLength = userBranchData.subBranch!.length;

  //get presences status
  AttendanceService().getPresenceStatus();

  return Get.bottomSheet(
    SizedBox(
      height: AppStatic.userData.level != UserLevel().admin ? 35.h : 20.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        child: Column(
          children: [
            AppStatic.userData.level != UserLevel().admin
                ? ListTile(
                    leading: const Icon(
                      Icons.login_outlined,
                      color: mtGrey700,
                    ),
                    title: Text(
                      'Absen masuk',
                      style: TextStyle(color: mtGrey700, fontSize: 10.sp, fontWeight: FontWeight.normal),
                    ),
                    onTap: () async {
                      Get.back();
                      // var log = Logger();

                      /* Jika user telah melakukan absensi  */
                      if (AppStatic.userPresenceStatus.isHashCheckIn) {
                        Snackbar.show("Hai ${AppStatic.userData.firstName}", "Anda sudah absen masuk hari ini", primaryYellow, mtGrey700);
                      }
                      /* Jika user belum melakukan absensi */
                      else {
                        if (AppStatic.userData.level == UserLevel().admin) {
                          Snackbar.show("Hai", "Admin tidak memerlukan absensi", primaryYellow, mtGrey700);
                        }

                        if (AppStatic.userData.level == UserLevel().branch) {
                          if (subBranchLength > 1) {
                            // log.w("lebih dari 1 subbranch");
                            showWorkPlaceChoice(1, placeChoiceLabel);
                          }
                        }

                        if (AppStatic.userData.level == UserLevel().subBranch) {
                          // log.wtf("subbranch level ${AppStatic.userBranchData.subBranch}");
                          // if (subBranchLength > 1) {
                          //   log.d("lebih dari 1 subbranch");
                          // } else {
                          //   log.d("hanya 1 branch");
                          // }
                          showWorkPlaceChoice(1, placeChoiceLabel);
                        }
                      }
                    },
                  )
                : Container(),
            AppStatic.userData.level != UserLevel().admin
                ? ListTile(
                    leading: const Icon(
                      Icons.logout_outlined,
                      color: mtGrey700,
                    ),
                    title: Text(
                      'Absen pulang',
                      style: TextStyle(color: mtGrey700, fontSize: 10.sp, fontWeight: FontWeight.normal),
                    ),
                    onTap: () {
                      Get.back();
                      // var log = Logger();
                      // print("ischeckin: ${AppStatic.userPresenceStatus.isHashCheckIn}");
                      if (AppStatic.userPresenceStatus.isHasCheckout) {
                        Snackbar.show('Hai ${AppStatic.userData.firstName}', "Anda sudah absen pulang hari ini", primaryYellow, mtGrey700);
                      } else if (AppStatic.userPresenceStatus.isHashCheckIn) {
                        if (AppStatic.userData.level == UserLevel().branch) {
                          if (subBranchLength > 1) {
                            // log.w("lebih dari 1 subbranch");
                            showWorkPlaceChoice(2, 'Pilih lokasi pulang');
                          }
                        }

                        if (AppStatic.userData.level == UserLevel().subBranch) {
                          // log.d("user subbranch level");
                        }

                        if (AppStatic.userData.level == UserLevel().admin) {
                          Snackbar.show("Hai", "Admin tidak memerlukan absensi", primaryYellow, mtGrey700);
                        }
                      } else {
                        Snackbar.show("Hai ${AppStatic.userData.firstName}", "Anda belum melakukan absensi masuk", primaryYellow, mtGrey700);
                      }
                    },
                  )
                : Container(),
            ListTile(
              leading: const Icon(
                Icons.person_off,
                color: mtGrey700,
              ),
              title: Text(
                'Pengajuan Izin/Cuti/Dll',
                style: TextStyle(color: mtGrey700, fontSize: 10.sp, fontWeight: FontWeight.normal),
              ),
              onTap: () {
                Get.back();
                Get.toNamed(RouteName.leavePermissionScreen);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.fact_check_outlined,
                color: mtGrey700,
              ),
              title: Text(
                'Riwayat absensi',
                style: TextStyle(color: mtGrey700, fontSize: 10.sp, fontWeight: FontWeight.normal),
              ),
              onTap: () {
                Get.back();
                var data = {'type': 3};
                Get.toNamed(RouteName.attendanceHistoryScreen, arguments: data);
              },
            ),
          ],
        ),
      ),
    ),
    elevation: 20.0,
    enableDrag: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15.0),
        topRight: Radius.circular(15.0),
      ),
    ),
  );
}

/*Show WorkPlace List Bottom Sheet Function*/
showWorkPlaceChoice(int argumentType, String title) {
  int totalWorkPlace = AppStatic.workPlaceList.length;
  List<BranchData> branchsData = AppStatic.workPlaceList;

  Get.bottomSheet(
    ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 40.h,
        minHeight: 25.h,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 2.h),
              child: Center(
                child: Text(
                  title,
                  style: panelaSubTitleTextSytle,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: totalWorkPlace,
                  itemBuilder: (BuildContext context, int index) {
                    BranchData branch = branchsData[index];

                    return ListTile(
                      leading: const Icon(Icons.chevron_right),
                      title: branch.isBranch!
                          ? Text(
                              'Induk ${branch.name!}',
                              style: panelContentTextSytle,
                            )
                          : Text(
                              "Cabang ${branch.name}",
                              style: panelContentTextSytle,
                            ),
                      onTap: () {
                        Get.back();
                        var data = {'type': argumentType};
                        AppStatic.workPlaceLocation = CoordinateDto(
                          latitude: branch.latitude,
                          longitude: branch.longitude,
                          distanceTolerance: branch.tolerance,
                        );
                        Get.toNamed(RouteName.attendanceScreen, arguments: data);
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
    ),
    elevation: 20.0,
    enableDrag: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15.0),
        topRight: Radius.circular(15.0),
      ),
    ),
  );
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: 15.w,
        child: Column(
          children: [
            Expanded(
                child: Align(
              alignment: Alignment.center,
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  padding: EdgeInsets.all(5.w),
                  decoration: BoxDecoration(color: primaryYellow, borderRadius: BorderRadius.circular(10), boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 3,
                      blurRadius: 3.5,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ]),
                  child: SvgPicture.asset(icon, color: mtGrey700),
                  // color: Colors.pink,
                ),
              ),
            )),
            SizedBox(height: 0.5.h),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(color: mtGrey700, fontSize: 6.sp, fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}
