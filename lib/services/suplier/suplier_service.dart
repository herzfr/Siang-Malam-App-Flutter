import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:siangmalam/commons/dio_http.dart';
import 'package:siangmalam/commons/functions/dio_exception.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/url_values.dart';
import 'package:siangmalam/constans/values.dart';
import 'package:siangmalam/models/PaginationFilter.dart';
import 'package:siangmalam/models/general_response.dart';
import 'package:siangmalam/models/suplier/suplier.dart';
import 'package:siangmalam/models/suplier/supliercreatedto.dart';
import 'package:siangmalam/models/suplier/suplierdto.dart';
import 'package:siangmalam/widgets/snack_bar.dart';

class SuplierService {
  static Future<Suplier> getSuplier(PaginationFilter filter) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.get(suplierUrl, queryParameters: {
        "size": filter.size,
        "page": filter.page,
        "search": filter.search
      });
      if (response.statusCode == 200) {
        var generalResponse = GeneralResponse.fromJson(response.data);
        Suplier suplier = Suplier.fromJson(generalResponse.data);
        // print("wowww--- ${stockProducts}");
        return suplier;
      } else {
        throw Error();
      }
    } on DioError catch (error) {
      var generalResponse = GeneralResponse.fromJson(error.response?.data);
      String? errMessage = generalResponse.message ?? errorHappen;
      Get.snackbar("Error", errMessage,
          backgroundColor: mtRed600, colorText: textColor);
      return Future.error("Error");
    } catch (error) {
      Get.snackbar("Error", error.toString(),
          backgroundColor: mtRed600, colorText: textColor);
      return Future.error("Error");
    }
  }

  static Future<Suplier> getSuplierWithoutParams() async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.get(suplierUrl);
      if (response.statusCode == 200) {
        var generalResponse = GeneralResponse.fromJson(response.data);
        Suplier suplier = Suplier.fromJson(generalResponse.data);
        return suplier;
      } else {
        throw Error();
      }
    } on DioError catch (error) {
      var generalResponse = GeneralResponse.fromJson(error.response?.data);
      String? errMessage = generalResponse.message ?? errorHappen;
      Get.snackbar("Error", errMessage,
          backgroundColor: mtRed600, colorText: textColor);
      return Future.error("Error");
    } catch (error) {
      Get.snackbar("Error", error.toString(),
          backgroundColor: mtRed600, colorText: textColor);
      return Future.error("Error");
    }
  }

  /* POST SUPLIER  */
  static Future<void> createSuplier(SuplierCreateDto setData) async {
    Response response;
    Dio dio = await DioConfig.getDio();

    try {
      response = await dio.post(suplierUrl, data: setData);
      var generalResponse = GeneralResponse.fromJson(response.data);

      if (generalResponse.statusCode == 0) {
        Snackbar.showAndBackWithResult(
            "Sukses", "Penambahan suplier berhasil", primaryGreen, textColor);
      }
    } on DioError catch (error) {
      var message = DioExceptions().fromDioError(error);
      Snackbar.show("Gagal", message, mtRed600, mtGrey50);
    } catch (error) {
      Snackbar.show("Gagal", "Oops ada yang salah", mtRed600, mtGrey50);
    }
  }

  /* PUT SUPLIER  */
  static Future<void> updateSuplier(SuplierDto setData) async {
    Response response;
    Dio dio = await DioConfig.getDio();

    try {
      response = await dio.put(suplierUrl, data: setData);
      var generalResponse = GeneralResponse.fromJson(response.data);

      if (generalResponse.statusCode == 0) {
        Snackbar.showAndBackWithResult(
            "Sukses", "Perubahan suplier berhasil", primaryGreen, textColor);
      }
    } on DioError catch (error) {
      var message = DioExceptions().fromDioError(error);
      Snackbar.show("Gagal", message, mtRed600, mtGrey50);
    } catch (error) {
      Snackbar.show("Gagal", "Oops ada yang salah", mtRed600, mtGrey50);
    }
  }
}
