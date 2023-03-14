import 'dart:async';
import 'package:get/get.dart';
// import 'package:logger/logger.dart';
import 'package:siangmalam/commons/routes/routes_name.dart';
import 'package:siangmalam/models/user.dart';
import 'package:siangmalam/services/app_static.dart';
import 'package:siangmalam/models/branch/branch.dart';
import 'package:siangmalam/services/auth/auth_service.dart';
import 'package:siangmalam/services/branch/branch_service.dart';
import 'package:siangmalam/services/attendance/attendance_service.dart';
import 'package:barcode/barcode.dart';

/* Created By Dwi Sutrisno */

class HomeController extends GetxController {
  var userDto = UserDto().obs;
  var greeting = 'Selamat Pagi'.obs;
  var categories = <Map<String, dynamic>>[].obs;
  // var log = Logger();

  var isShow = true.obs;

  @override
  void onInit() async {
    super.onInit();
    refreshInterval();
    getUserData();
    getDayTime();
    getWorkPlaceData();
    getPresenceStatus();
    categories.clear();
    categories.addAll(await getMenu(userDto.value.role));
  }

  @override
  void onReady() async {
    super.onInit();
    getDayTime();
  }

  buildBarcode(
    Barcode bc,
    String data, {
    String? filename,
    double? width,
    double? height,
    double? fontHeight,
  }) {
    /// Create the Barcode
    var svg = bc.toSvg(
      data,
      width: width ?? 200,
      height: height ?? 80,
      fontHeight: fontHeight,
    );
    return svg;
  }

  @override
  void onClose() {
    categories.clear();
  }

  // GET MENU
  getMenu(role) async {
    // log.d(role);
    switch (role) {
      case "KASIR":
        return [
          {
            "icon": "assets/icons/Cart.svg",
            "text": "Pesanan",
            "route": RouteName.orderScreen
          },
          {
            "icon": "assets/icons/Cashier.svg",
            "text": "Kasir",
            "route": RouteName.cashierScreen
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

      case "USER":
        return [
          {
            "icon": "assets/icons/Cart.svg",
            "text": "Pesanan",
            "route": RouteName.orderScreen
          },
          {
            "icon": "assets/icons/Product.svg",
            "text": "Penerbitan Produk",
            "route": RouteName.spaScreen,
            "type": "button",
          },
          {
            "icon": "assets/icons/Printer.svg",
            "text": "Printer",
            "route": RouteName.printerScreen,
            "type": "button",
          },
        ];

      case "MANAGER":
        return [
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
            "route": RouteName.poproductScreenV2,
            "type": "button",
          },
          {
            "icon": "assets/icons/List Items.svg",
            "text": "Belanja Bahan",
            "route": RouteName.poitemScreenV2,
            "type": "button",
          },
          {
            "icon": "assets/icons/Stock-out.svg",
            "text": "Bahan Keluar",
            "route": RouteName.stoScreen,
            "type": "button",
          },
          // {
          //   "icon": "assets/icons/Product.svg",
          //   "text": "Transfer Stok Produk",
          //   "route": RouteName.stockProductScreen,
          //   "type": "button",
          // },
          // {
          //   "icon": "assets/icons/Items.svg",
          //   "text": "Transfer Stok Bahan",
          //   "route": RouteName.stockItemScreen,
          //   "type": "button",
          // },
          {
            "icon": "assets/icons/Discount.svg",
            "text": "Diskon",
            "route": RouteName.discountScreen,
            "type": "button",
          },
          // {
          //   "icon": "assets/icons/Bill.svg",
          //   "text": "Laporan Bill",
          //   "route": RouteName.ReportBillScreen,
          //   "type": "button",
          // },
          {
            "icon": "assets/icons/Debt.svg",
            "text": "Laporan Kasbon",
            "route": RouteName.reportCashbonScreen,
            "type": "button",
          },
          // {
          //   "icon": "assets/icons/Income.svg",
          //   "text": "Pendapatan",
          //   "route": RouteName.unknownScreen,
          //   "type": "button",
          // },
          // {
          //   "icon": "assets/icons/Analysis.svg",
          //   "text": "Laporan",
          //   "route": RouteName.unknownScreen,
          //   "type": "button",
          // },
          {
            "icon": "assets/icons/Printer.svg",
            "text": "Printer",
            "route": RouteName.printerScreen,
            "type": "button",
          },
          {
            "icon": "assets/icons/Wallet.svg",
            "text": "Uang Celengan",
            "route": RouteName.savingScreen,
            "type": "button",
          },
          {
            "icon": "assets/icons/Product.svg",
            "text": "Transfer Produk",
            "route": RouteName.transferProductScreen,
            "type": "button",
          },
        ];

      case "ADMIN":
        return [
          // {
          //   "icon": "assets/icons/Wallet.svg",
          //   "text": "Arus Kas",
          //   "route": RouteName.unknownScreen,
          //   "type": "button",
          // },
          // {
          //   "icon": "assets/icons/Bill.svg",
          //   "text": "Pembayaran",
          //   "route": RouteName.unknownScreen,
          //   "type": "button",
          // },
          // {
          //   "icon": "assets/icons/Product.svg",
          //   "text": "Stok Produk",
          //   "route": RouteName.stockProductScreen,
          //   "type": "button",
          // },
          // {
          //   "icon": "assets/icons/Items.svg",
          //   "text": "Stok Bahan",
          //   "route": RouteName.stockItemScreen,
          //   "type": "button",
          // },
          // {
          //   "icon": "assets/icons/List Product.svg",
          //   "text": "Belanja Produk",
          //   "route": RouteName.poProductScreen,
          //   "type": "button",
          // },
          // {
          //   "icon": "assets/icons/List Items.svg",
          //   "text": "Belanja Bahan",
          //   "route": RouteName.poItemScreen,
          //   "type": "button",
          // },
          // {
          //   "icon": "assets/icons/Stock-out.svg",
          //   "text": "Bahan Keluar",
          //   "route": RouteName.stoScreen,
          //   "type": "button",
          // },
          {
            "icon": "assets/icons/Discount.svg",
            "text": "Diskon",
            "route": RouteName.discountScreen,
            "type": "button",
          },
          // {
          //   "icon": "assets/icons/Income.svg",
          //   "text": "Pendapatan",
          //   "route": RouteName.unknownScreen,
          //   "type": "button",
          // },
          // {
          //   "icon": "assets/icons/Expense.svg",
          //   "text": "Pengeluaran",
          //   "route": RouteName.unknownScreen,
          //   "type": "button",
          // },
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
          // {
          //   "icon": "assets/icons/Device Scan.svg",
          //   "text": "Absen",
          //   "route": RouteName.attendanceScreen,
          //   "type": "options",
          // },
          // {
          //   "icon": "assets/icons/Analysis.svg",
          //   "text": "Laporan",
          //   "route": RouteName.unknownScreen,
          //   "type": "button",
          // },
          {
            "icon": "assets/icons/Printer.svg",
            "text": "Printer",
            "route": RouteName.printerScreen,
            "type": "button",
          },
        ];

      default:
        return [
          {
            "icon": "assets/icons/Cart.svg",
            "text": "Pesanan",
            "route": RouteName.orderScreen
          },
          {
            "icon": "assets/icons/Cashier.svg",
            "text": "Kasir",
            "route": RouteName.cashierScreen
          },
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
        ];
    }
  }

  /* Get User Data Function */
  getUserData() {
    userDto.value = Get.arguments ?? AppStatic.userData;
  }

  /* Get Work Place Data Function */
  getWorkPlaceData() async {
    //get user branch data from api
    BranchDto userBranchData = await BranchService.getBranchData();
    //initialize branch data list
    List<BranchData> branchList = <BranchData>[];

    //Parent Branch data
    var parentBranch = BranchData.set(
      userBranchData.id,
      userBranchData.name,
      userBranchData.description,
      double.parse(userBranchData.latitude!),
      double.parse(userBranchData.longitude!),
      userBranchData.tolerance,
      userBranchData.workingHour,
      true,
    );
    branchList.add(parentBranch);
    //Parent Branch data

    for (var element in userBranchData.subBranch!) {
      BranchData data = BranchData.set(
          element.id,
          element.name,
          element.description,
          double.parse(element.latitude!),
          double.parse(element.longitude!),
          element.tolerance,
          element.workingHour,
          false);
      branchList.add(data);
    }

    //set data to app static
    AppStatic.userBranchData = userBranchData;
    AppStatic.workPlaceList = branchList;
  }

  //auth refresh function
  refreshInterval() {
    //refresh authentication token
    Timer.periodic(
      const Duration(minutes: 10),
      (_) {
        AuthService.sendRefresh();
      },
    );
    //refresh presence status value
    Timer.periodic(
      const Duration(hours: 1),
      (_) {
        getPresenceStatus();
      },
    );
  }

  //get user presence checkin and checkout status
  getPresenceStatus() async {
    await AttendanceService().getPresenceStatus();
  }

  /* Get Day Time Function */
  getDayTime() {
    var now = DateTime.now().hour;
    if (now < 10) {
      greeting.value = 'Selamat Pagi';
    } else if (now >= 10 && now < 15) {
      greeting.value = 'Selamat Siang';
    } else if (now >= 15 && now < 19) {
      greeting.value = 'Selamat Sore';
    } else {
      greeting.value = 'Selamat Malam';
    }
  }
}
