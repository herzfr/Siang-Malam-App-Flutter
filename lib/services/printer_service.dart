// import 'dart:developer';
import 'dart:io';

import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
// import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/models/cashier/payment.dart';
import 'package:siangmalam/models/cashier/response_checkout.dart';
import 'package:siangmalam/models/cashier/sales.dart';
import 'package:siangmalam/services/app_static.dart';
import 'package:siangmalam/widgets/snack_bar.dart';

class PrinterService {
  BluetoothDevice? device = AppStatic.device;
  BlueThermalPrinter printer = AppStatic.printerThermalInstance;
  late String pathImage;
  String header = "RM. SIANG MALAM";
  // var log = Logger();

  printCheckout(ResponseCheckout data) async {
    DateTime date = DateTime.now();
    bool dineIn = data.isDineIn ?? false;
    List<SalesCart> cart = data.itemsCheckout ?? <SalesCart>[];
    var box = GetStorage();
    // await initSavetoPath();

    if ((await printer.isConnected)!) {
      // HEADER TITLE
      printer.printNewLine();
      printer.printCustom(header, 3, 1);
      if (box.read("PRINT_BRANCH") != null) {
        printer.printCustom(box.read("PRINT_BRANCH"), 0, 1);
      }
      if (box.read("PRINT_ADDRESS") != null) {
        printer.printCustom(box.read("PRINT_ADDRESS"), 0, 1);
      }
      printer.printNewLine();

      // printer.printImage(pathImage); //path of your image/logo
      // printer.printNewLine();

      // SUBHEADER TITLE
      printer.printLeftRight("${data.cashierName}", "${data.id}", 1);
      printer.printLeftRight(
          "${converDateMillisToDate(date.millisecondsSinceEpoch)}",
          "${converDateMillisToTime(date.millisecondsSinceEpoch)}",
          1);
      printer.printLeftRight(
          "${data.name}", dineIn ? 'Dine In' : 'Take Away', 1);
      printer.printNewLine();

      // BODY ITEM PRINT
      for (var item in cart) {
        printer.printCustom("${item.name}", 0, 0);
        printer.printLeftRight(
            "x${item.amount}", "${convertPrice(item.unitPrice)}", 0);
        printer.printCustom(
            "${convertPrice(item.unitPrice! * item.amount!)}", 1, 2);
      }

      // BODY TOTAL
      printer.printNewLine();
      printer.printCustom("============SubTotal============", 0, 1);
      printer.printLeftRight(
          "${cart.length} Item", "${convertPrice(data.subTotal)}", 1);
      if (data.discount != 0) {
        printer.printLeftRight("Diskon", "${convertPrice(data.discount)}", 0);
      }
      if (data.tax != 0) {
        printer.printLeftRight("Pajak", "${convertPrice(data.discount)}", 0);
      }
      if (data.service != 0) {
        printer.printLeftRight("Service", "${convertPrice(data.service)}", 0);
      }
      printer.printCustom("==============Total=============", 0, 1);
      printer.printLeftRight("Total", "${convertPrice(data.total)}", 1);
      printer.printCustom("===========Pembayaran===========", 0, 1);
      printer.printLeftRight("Tunai", "${convertPrice(data.cash)}", 1);
      printer.printLeftRight("Kembali", "${convertPrice(data.change)}", 1);
      printer.printLeftRight("Status", "Lunas", 1);
      printer.printNewLine();

      // FOOTER INFO
      printer.printCustom("============================", 0, 1);
      if (box.read("PRINT_INFO") != null) {
        printer.printCustom(box.read("PRINT_INFO"), 0, 1);
      }
      printer.printCustom("============================", 0, 1);
      printer.printCustom("         Terima Kasih       ", 0, 1);
      printer.printCustom("============================", 0, 1);
      printer.printNewLine();
    } else {
      Snackbar.show("Opps", "Device Tidak Terkoneksi!", mtRed600, mtGrey50);
    }
  }

  printCheckoutCust(ResponseCheckout data, PaymentCustom payment) async {
    DateTime date = DateTime.now();
    bool dineIn = data.isDineIn ?? false;
    List<SalesCart> cart = data.itemsCheckout ?? <SalesCart>[];
    var box = GetStorage();
    // await initSavetoPath();

    if ((await printer.isConnected)!) {
      // HEADER TITLE
      printer.printNewLine();
      printer.printCustom(header, 3, 1);
      if (box.read("PRINT_BRANCH") != null) {
        printer.printCustom(box.read("PRINT_BRANCH"), 0, 1);
      }
      if (box.read("PRINT_ADDRESS") != null) {
        printer.printCustom(box.read("PRINT_ADDRESS"), 0, 1);
      }
      printer.printNewLine();

      // printer.printImage(pathImage); //path of your image/logo
      // printer.printNewLine();

      // SUBHEADER TITLE
      printer.printLeftRight("${data.cashierName}", "${data.id}", 1);
      printer.printLeftRight(
          "${converDateMillisToDate(date.millisecondsSinceEpoch)}",
          "${converDateMillisToTime(date.millisecondsSinceEpoch)}",
          1);
      printer.printLeftRight(
          "${data.name}", dineIn ? 'Dine In' : 'Take Away', 1);
      printer.printNewLine();

      // BODY ITEM PRINT
      for (var item in cart) {
        printer.printCustom("${item.name}", 0, 0);
        printer.printLeftRight(
            "x${item.amount}", "${convertPrice(item.unitPrice)}", 0);
        printer.printCustom(
            "${convertPrice(item.unitPrice! * item.amount!)}", 1, 2);
      }

      // BODY TOTAL
      printer.printNewLine();
      printer.printCustom("============SubTotal============", 0, 1);
      printer.printLeftRight(
          "${cart.length} Item", "${convertPrice(data.subTotal)}", 1);
      if (data.discount != 0) {
        printer.printLeftRight("Diskon", "${convertPrice(data.discount)}", 0);
      }
      if (data.tax != 0) {
        printer.printLeftRight("Pajak", "${convertPrice(data.discount)}", 0);
      }
      if (data.service != 0) {
        printer.printLeftRight("Service", "${convertPrice(data.service)}", 0);
      }
      printer.printCustom("==============Total=============", 0, 1);
      printer.printLeftRight("Total", "${convertPrice(data.total)}", 1);
      printer.printCustom("===========Pembayaran===========", 0, 1);

      printer.printLeftRight(
          "${payment.name}", "${convertPrice(data.total)}", 1);
      printer.printLeftRight("Status", "Lunas", 1);
      printer.printNewLine();

      // FOOTER INFO
      printer.printCustom("============================", 0, 1);
      if (box.read("PRINT_INFO") != null) {
        printer.printCustom(box.read("PRINT_INFO"), 0, 1);
      }
      printer.printCustom("============================", 0, 1);
      printer.printCustom("         Terima Kasih       ", 0, 1);
      printer.printCustom("============================", 0, 1);
      printer.printNewLine();
    } else {
      Snackbar.show("Opps", "Device Tidak Terkoneksi!", mtRed600, mtGrey50);
    }
  }

  printFromSales(Sales data) async {
    DateTime date = DateTime.now();
    bool dineIn = data.isDineIn ?? false;
    List<SalesItems> cart = data.items ?? <SalesItems>[];
    var box = GetStorage();

    // await initSavetoPath();

    if ((await printer.isConnected)!) {
      // HEADER TITLE
      printer.printNewLine();
      printer.printCustom(header, 3, 1);
      if (box.read("PRINT_BRANCH") != null) {
        printer.printCustom(box.read("PRINT_BRANCH"), 0, 1);
      }
      if (box.read("PRINT_ADDRESS") != null) {
        printer.printCustom(box.read("PRINT_ADDRESS"), 0, 1);
      }
      printer.printNewLine();

      // printer.printImage(pathImage); //path of your image/logo
      // printer.printNewLine();

      // SUBHEADER TITLE
      printer.printLeftRight("${data.cashierName}", "${data.id}", 1);
      printer.printLeftRight(
          "${converDateMillisToDate(date.millisecondsSinceEpoch)}",
          "${converDateMillisToTime(date.millisecondsSinceEpoch)}",
          1);
      printer.printLeftRight(
          "${data.name}", dineIn ? 'Dine In' : 'Take Away', 1);
      printer.printNewLine();

      // BODY ITEM PRINT
      for (var item in cart) {
        printer.printCustom("${item.name}", 0, 0);
        printer.printLeftRight(
            "x${item.amount}", "${convertPrice(item.unitPrice)}", 0);
        printer.printCustom(
            "${convertPrice(item.unitPrice! * item.amount!)}", 1, 2);
      }

      // BODY TOTAL
      printer.printNewLine();
      printer.printCustom("============SubTotal============", 0, 1);
      printer.printLeftRight(
          "${cart.length} Item", "${convertPrice(data.subTotal)}", 1);
      if (data.discount != 0) {
        printer.printLeftRight("Diskon", "${convertPrice(data.discount)}", 0);
      }
      if (data.tax != 0) {
        printer.printLeftRight("Pajak", "${convertPrice(data.discount)}", 0);
      }
      if (data.service != 0) {
        printer.printLeftRight("Service", "${convertPrice(data.service)}", 0);
      }
      printer.printCustom("==============Total=============", 0, 1);
      printer.printLeftRight("Total", "${convertPrice(data.total)}", 1);
      printer.printCustom("===========Pembayaran===========", 0, 1);
      if (data.paymentMethod == 'CASH') {
        printer.printLeftRight("Tunai", "${convertPrice(data.cash)}", 1);
        printer.printLeftRight("Kembali", "${convertPrice(data.change)}", 1);
        printer.printLeftRight("Status", 'Lunas', 1);
      } else if (data.paymentMethod == 'CUSTOM') {
        if (data.imageProof != "") {
          printer.printLeftRight("E-Wallet", "${convertPrice(data.total)}", 1);
          printer.printLeftRight("Status", 'Lunas', 1);
        } else {
          printer.printLeftRight(
              "DEBIT/KREDIT", "${convertPrice(data.total)}", 1);
          printer.printLeftRight("Status", 'Lunas', 1);
        }
      } else if (data.paymentMethod == 'CUST_DEBT') {
        printer.printLeftRight("Invoice", "${convertPrice(data.total)}", 1);
        printer.printLeftRight("Status", 'Belum Lunas', 1);
      } else {
        printer.printLeftRight("Karyawan", "${convertPrice(data.total)}", 1);
        printer.printLeftRight("Status", 'Belum Lunas', 1);
      }

      printer.printNewLine();

      // FOOTER INFO
      printer.printCustom("============================", 0, 1);
      if (box.read("PRINT_INFO") != null) {
        printer.printCustom(box.read("PRINT_INFO"), 0, 1);
      }
      printer.printCustom("============================", 0, 1);
      printer.printCustom("         Terima Kasih       ", 0, 1);
      printer.printCustom("============================", 0, 1);
      printer.printNewLine();
    } else {
      Snackbar.show("Opps", "Device Tidak Terkoneksi!", mtRed600, mtGrey50);
    }
  }

  convertPrice(int? price) {
    if (price != null) {
      final currencyFormatter = NumberFormat('#,##0', 'ID');
      return 'Rp ' + currencyFormatter.format(price);
    } else {
      return 'Rp -';
    }
  }

  converDateMillisToDate(int millis) {
    var dt = DateTime.fromMillisecondsSinceEpoch(millis);
    return DateFormat('dd MMMM yyyy').format(dt).toString();
  }

  converDateMillisToTime(int millis) {
    var dt = DateTime.fromMillisecondsSinceEpoch(millis);
    return DateFormat('HH:mm:ss').format(dt).toString();
  }

  Future<void> writeToFile(ByteData data, String path) {
    final buffer = data.buffer;
    return File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  initSavetoPath() async {
    //read and write
    //image max 300px X 300px
    var filename = 'sm_logo3.png';
    var bytes = await rootBundle.load("assets/images/sm_logo3.png");
    String dir = (await getApplicationDocumentsDirectory()).path;
    writeToFile(bytes, '$dir/$filename');
    pathImage = '$dir/$filename';
  }
}
