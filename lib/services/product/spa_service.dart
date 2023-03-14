import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:siangmalam/commons/dio_http.dart';
import 'package:siangmalam/commons/functions/dio_exception.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/url_values.dart';
import 'package:siangmalam/constans/values.dart';
import 'package:siangmalam/models/general_response.dart';
import 'package:siangmalam/models/product/stock_kitchen.dart';
import 'package:siangmalam/widgets/snack_bar.dart';

class SpaService {
  static Future<ResProductAdjustment> getSPA(GetProdAdjst filter) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.post(spaUrl + 'get', data: filter);
      if (response.statusCode == 201) {
        var generalResponse = GeneralResponse.fromJson(response.data);
        ResProductAdjustment transfer =
            ResProductAdjustment.fromJson(generalResponse.data);
        return transfer;
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

  static Future<void> createSPA(CreateProdAdjst prodAdjs) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.post(spaUrl + 'adjust', data: prodAdjs);
      if (response.statusCode == 201) {
        Snackbar.showAndBackWithResult("Sukses",
            "Penyesuaian stok produk berhasil", primaryGreen, textColor);
      } else {
        throw Error();
      }
    } on DioError catch (error) {
      // log.d(error);
      var message = DioExceptions().fromDioError(error);
      Snackbar.show("Gagal", message, mtRed600, mtGrey50);
    } catch (error) {
      // log.d(error);
      Snackbar.show("Gagal", "Oops ada yang salah", mtRed600, mtGrey50);
    }
  }
}
