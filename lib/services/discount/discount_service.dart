import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response hide FormData hide MultipartFile;
// import 'package:logger/logger.dart';
import 'package:siangmalam/commons/dio_http.dart';
import 'package:siangmalam/commons/functions/dio_exception.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/url_values.dart';
import 'package:siangmalam/constans/values.dart';
import 'package:siangmalam/models/discount/discount.dart';
import 'package:siangmalam/models/discount/discounts.dart';
import 'package:siangmalam/models/discount/request/request_discount.dart';
import 'package:siangmalam/models/discount/request/request_discount_dto.dart';
import 'package:siangmalam/models/general_response.dart';
import 'package:siangmalam/widgets/snack_bar.dart';

class DiscountService {
  // GET ALL DISCOUNT
  static Future<Discounts> getAllDiscount(GetDiscountsAll filter) async {
    Response response;
    // var log = Logger();
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.post(dicountUrl, data: filter);
      if (response.statusCode == 201) {
        var generalResponse = GeneralResponse.fromJson(response.data);
        Discounts discountList = Discounts.fromJson(generalResponse.data);
        return discountList;
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

  // GET ALL DISCOUNT JUST BRANC
  static Future<Discounts> getAllDiscountJustBranch(
      GetDiscountJustBranch filter) async {
    Response response;
    // var log = Logger();
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.post(dicountUrl, data: filter);
      if (response.statusCode == 201) {
        var generalResponse = GeneralResponse.fromJson(response.data);
        Discounts discountList = Discounts.fromJson(generalResponse.data);
        return discountList;
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

  // GET ALL DISCOUNT BY MANAGER
  static Future<Discounts> getAllDiscountByManager(
      GetDiscountByManager filter) async {
    Response response;
    // var log = Logger();
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.post(dicountUrl, data: filter);
      if (response.statusCode == 201) {
        var generalResponse = GeneralResponse.fromJson(response.data);
        Discounts discountList = Discounts.fromJson(generalResponse.data);
        return discountList;
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

  // GET ALL DISCOUNT BY ADMIN
  static Future<Discounts> getAllDiscountByAdmin(
      GetDiscountByAdmin filter) async {
    Response response;
    // var log = Logger();
    Dio dio = await DioConfig.getDio();

    // log.d(filter.toJson());
    try {
      response = await dio.post(dicountUrl, data: filter);
      // log.d(response);
      if (response.statusCode == 201) {
        var generalResponse = GeneralResponse.fromJson(response.data);
        Discounts discountList = Discounts.fromJson(generalResponse.data);
        return discountList;
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

  // GET ALL DISCOUNT BY ADMIN
  static Future<Discount> getAllDiscountById(String id) async {
    Response response;
    // var log = Logger();
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.get(dicountUrl + id);
      if (response.statusCode == 200) {
        var generalResponse = GeneralResponse.fromJson(response.data);
        Discount discount = Discount.fromJson(generalResponse.data);
        return discount;
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

  /* DISCOUNT CREATE  */
  static Future<bool> createDiscount(DiscountCreateDto setData) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.post(dicountCreateUrl, data: setData);
      var generalResponse = GeneralResponse.fromJson(response.data);

      if (generalResponse.statusCode == 0) {
        Snackbar.showAndBackWithResult(
            "Sukses", "Discount telah dibuat", primaryGreen, textColor);
        return true;
      } else {
        return false;
      }
    } on DioError catch (error) {
      var message = DioExceptions().fromDioError(error);
      Snackbar.show("Gagal", message, mtRed600, mtGrey50);
      return false;
    } catch (error) {
      Snackbar.show("Gagal", "Oops ada yang salah", mtRed600, mtGrey50);
      return false;
    }
  }

  /* DISCOUNT UPDATE  */
  static Future<bool> updateDiscount(DiscountUpdateDto setData) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.put(dicountUpdateUrl, data: setData);
      var generalResponse = GeneralResponse.fromJson(response.data);

      if (generalResponse.statusCode == 0) {
        Snackbar.showAndBackWithResult(
            "Sukses", "Discount telah ubah", primaryGreen, textColor);
        return true;
      } else {
        return false;
      }
    } on DioError catch (error) {
      var message = DioExceptions().fromDioError(error);
      Snackbar.show("Gagal", message, mtRed600, mtGrey50);
      return false;
    } catch (error) {
      Snackbar.show("Gagal", "Oops ada yang salah", mtRed600, mtGrey50);
      return false;
    }
  }

  /* DISCOUNT UPDATE  */
  static Future<bool> deleteDiscount(String id) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.delete(dicountDeleteUrl + id);
      var generalResponse = GeneralResponse.fromJson(response.data);

      if (generalResponse.statusCode == 0) {
        Snackbar.showAndBackWithResult(
            "Sukses", "Discount telah dihapus", primaryGreen, textColor);
        return true;
      } else {
        return false;
      }
    } on DioError catch (error) {
      var message = DioExceptions().fromDioError(error);
      Snackbar.show("Gagal", message, mtRed600, mtGrey50);
      return false;
    } catch (error) {
      Snackbar.show("Gagal", "Oops ada yang salah", mtRed600, mtGrey50);
      return false;
    }
  }
}
