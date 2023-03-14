import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response hide FormData hide MultipartFile;
// import 'package:logger/logger.dart';
import 'package:siangmalam/commons/dio_http.dart';
import 'package:siangmalam/commons/functions/dio_exception.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/url_values.dart';
import 'package:siangmalam/constans/values.dart';
import 'package:siangmalam/models/cashier/mergenill.dart';
import 'package:siangmalam/models/cashier/shift.dart';
import 'package:siangmalam/models/cashier/splitbill.dart';
import 'package:siangmalam/models/general_response.dart';
import 'package:siangmalam/widgets/snack_bar.dart';

class CashierService {
  static Future<void> splitBillService(SplitBill split) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.post(orderTempSales + 'bill/split', data: split);
      var generalResponse = GeneralResponse.fromJson(response.data);

      if (generalResponse.statusCode == 0) {
        Snackbar.showAndBackWithResult(
            "Sukses", "Pemisahan pesanan berhasil", primaryGreen, textColor);
      }
    } on DioError catch (error) {
      var message = DioExceptions().fromDioError(error);
      Snackbar.show("Gagal", message, mtRed600, mtGrey50);
    } catch (error) {
      Snackbar.show("Gagal", "Oops ada yang salah", mtRed600, mtGrey50);
    }
  }

  static Future<bool> mergeBillService(MergeBill merge) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.post(orderTempSales + 'bill/merge', data: merge);
      var generalResponse = GeneralResponse.fromJson(response.data);

      if (generalResponse.statusCode == 0) {
        return true;
      } else {
        return false;
      }
    } on DioError catch (error) {
      var message = DioExceptions().fromDioError(error);
      return false;
    } catch (error) {
      return false;
    }
  }

  static Future<ShiftObj> checkShift(CheckShift checkSgit) async {
    // var log = Logger();
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.post(shiftUrl + 'check', data: checkSgit);
      if (response.statusCode == 201) {
        var generalResponse = GeneralResponse.fromJson(response.data);
        ShiftObj shift = ShiftObj.fromJson(generalResponse.data);
        return shift;
      } else {
        throw Error();
      }
    } on DioError catch (error) {
      return ShiftObj();
      // log.d(error.response!.statusCode);
      // var generalResponse = GeneralResponse.fromJson(error.response?.data);
      // String? errMessage = generalResponse.message ?? errorHappen;
      // Get.snackbar("Errors", errMessage,
      //     backgroundColor: mtRed600, colorText: textColor);
      // return Future.error("Error");
    } catch (error) {
      return ShiftObj();
      // log.d(error);
      // Get.snackbar("Error", error.toString(),
      //     backgroundColor: mtRed600, colorText: textColor);
      // return Future.error("Error");
    }
  }

  static Future<ShifList> getShift(GetShift getShift) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.post(shiftUrl + 'get', data: getShift);
      if (response.statusCode == 201) {
        var generalResponse = GeneralResponse.fromJson(response.data);
        ShifList allshift = ShifList.fromJson(generalResponse.data);
        return allshift;
      } else {
        throw Error();
      }
    } on DioError catch (error) {
      // log.d(error);
      var generalResponse = GeneralResponse.fromJson(error.response?.data);
      String? errMessage = generalResponse.message ?? errorHappen;
      Get.snackbar("Error", errMessage,
          backgroundColor: mtRed600, colorText: textColor);
      return Future.error("Error");
    } catch (error) {
      // log.d(error);
      Get.snackbar("Error", error.toString(),
          backgroundColor: mtRed600, colorText: textColor);
      return Future.error("Error");
    }
  }

  static Future<bool> updateCashShift(UpdateCashShift updateCash) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.post(shiftUrl + 'addcash', data: updateCash);
      if (response.statusCode == 201) {
        return true;
      } else {
        throw Error();
      }
    } on DioError catch (error) {
      // log.d(error);
      var generalResponse = GeneralResponse.fromJson(error.response?.data);
      String? errMessage = generalResponse.message ?? errorHappen;
      Get.snackbar("Error", errMessage,
          backgroundColor: mtRed600, colorText: textColor);
      return false;
    } catch (error) {
      // log.d(error);
      Get.snackbar("Error", error.toString(),
          backgroundColor: mtRed600, colorText: textColor);
      return false;
    }
  }

  static Future<ShiftObj> startShift(StartShift start) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.post(shiftUrl + 'start', data: start);
      if (response.statusCode == 201) {
        var generalResponse = GeneralResponse.fromJson(response.data);
        ShiftObj shift = ShiftObj.fromJson(generalResponse.data);
        return shift;
      } else {
        throw Error();
      }
    } on DioError catch (error) {
      // log.d(error);
      var generalResponse = GeneralResponse.fromJson(error.response?.data);
      String? errMessage = generalResponse.message ?? errorHappen;
      Get.snackbar("Error", errMessage,
          backgroundColor: mtRed600, colorText: textColor);
      return Future.error("Error");
    } catch (error) {
      // log.d(error);
      Get.snackbar("Error", error.toString(),
          backgroundColor: mtRed600, colorText: textColor);
      return Future.error("Error");
    }
  }

  static Future<bool> stopShift(StopShift stop) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.post(shiftUrl + 'stop', data: stop);
      var generalResponse = GeneralResponse.fromJson(response.data);
      if (generalResponse.statusCode == 0) {
        return true;
      } else {
        return false;
      }
    } on DioError catch (error) {
      var message = DioExceptions().fromDioError(error);
      Get.snackbar("Error", message.toString(),
          backgroundColor: mtRed600, colorText: textColor);
      return false;
    } catch (error) {
      Get.snackbar("Error", error.toString(),
          backgroundColor: mtRed600, colorText: textColor);
      return false;
    }
  }
}
