import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response hide FormData hide MultipartFile;
// import 'package:logger/logger.dart';
import 'package:siangmalam/commons/dio_http.dart';
// import 'package:siangmalam/commons/functions/dio_exception.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/url_values.dart';
import 'package:siangmalam/constans/values.dart';
// import 'package:siangmalam/models/cashier/mergenill.dart';
// import 'package:siangmalam/models/cashier/shift.dart';
// import 'package:siangmalam/models/cashier/splitbill.dart';
import 'package:siangmalam/models/general_response.dart';
import 'package:siangmalam/models/tax/general_value.dart';
// import 'package:siangmalam/widgets/snack_bar.dart';

class GeneralService {
  static Future<GeneralValue> getAllGeneralValue(GeneralFilter filter) async {
    Response response;
    // var log = Logger();
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.post(generalUrl + "get", data: filter);
      if (response.statusCode == 201) {
        var generalResponse = GeneralResponse.fromJson(response.data);
        GeneralValue general = GeneralValue.fromJson(generalResponse.data);
        return general;
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
}
