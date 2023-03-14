import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response hide FormData hide MultipartFile;
// import 'package:logger/logger.dart';
import 'package:siangmalam/commons/dio_http.dart';
import 'package:siangmalam/commons/functions/dio_exception.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/url_values.dart';
import 'package:siangmalam/constans/values.dart';
import 'package:siangmalam/models/general_response.dart';
import 'package:siangmalam/models/stok-item-out/request/stock_item_out_dto.dart';
import 'package:siangmalam/models/stok-item-out/request/stock_item_out_filter.dart';
import 'package:siangmalam/models/stok-item-out/response/stock_item_out.dart';
import 'package:siangmalam/widgets/snack_bar.dart';

class StoService {
  static Future<StockItemOut> getAllStockOut(StockItemOutFilter filter) async {
    Response response;
    // var log = Logger();
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.post(stoUrl, data: filter);
      if (response.statusCode == 201) {
        var generalResponse = GeneralResponse.fromJson(response.data);
        StockItemOut stoList = StockItemOut.fromJson(generalResponse.data);
        return stoList;
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
  static Future<bool> updateStockOutItems(StockItemOutDto setData) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.post(stoUrlCreate, data: setData);
      var generalResponse = GeneralResponse.fromJson(response.data);

      if (generalResponse.statusCode == 0) {
        Snackbar.showAndBackWithResult(
            "Sukses", "Bahan telah dikeluarkan", primaryGreen, textColor);
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
