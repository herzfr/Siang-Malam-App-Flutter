import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:siangmalam/commons/dio_http.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/url_values.dart';
import 'package:siangmalam/constans/values.dart';
import 'package:siangmalam/models/PaginationFilter.dart';
import 'package:siangmalam/models/general_response.dart';
import 'package:siangmalam/models/warehouse/warehouse.dart';

class WarehouseService {
  static Future<Warehouse> getWarehouseWithParams(
      PaginationFilter filter) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.get(warehouseUrl, queryParameters: {
        "size": filter.size,
        "page": filter.page,
        "search": filter.search
      });
      if (response.statusCode == 200) {
        var generalResponse = GeneralResponse.fromJson(response.data);
        Warehouse warehouse = Warehouse.fromJson(generalResponse.data);
        // print("wowww--- ${stockProducts}");
        return warehouse;
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

  static Future<Warehouse> getWarehouse() async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.get(warehouseUrl);
      if (response.statusCode == 200) {
        var generalResponse = GeneralResponse.fromJson(response.data);
        Warehouse warehouse = Warehouse.fromJson(generalResponse.data);
        // print("wowww--- ${stockProducts}");
        return warehouse;
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

  static Future<WarehouseTransfer> getWarehouseList(String search) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response =
          await dio.post(warehouseUrl + '/get', data: {"search": search});
      if (response.statusCode == 201) {
        // var generalResponse = GeneralResponse.fromJson(response.data);
        WarehouseTransfer warehouse = WarehouseTransfer.fromJson(response.data);
        return warehouse;
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
}
