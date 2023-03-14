import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response hide FormData hide MultipartFile;
// import 'package:logger/logger.dart';
import 'package:siangmalam/commons/dio_http.dart';
// import 'package:siangmalam/commons/functions/dio_exception.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/url_values.dart';
import 'package:siangmalam/constans/values.dart';
import 'package:siangmalam/models/cashier/checkout.dart';
// import 'package:siangmalam/models/cashier/mergenill.dart';
import 'package:siangmalam/models/cashier/payment.dart';
import 'package:siangmalam/models/cashier/response_checkout.dart';
// import 'package:siangmalam/models/cashier/shift.dart';
// import 'package:siangmalam/models/cashier/splitbill.dart';
import 'package:siangmalam/models/general_response.dart';
// import 'package:siangmalam/widgets/snack_bar.dart';

class PaymentService {
  static Future<PaymentCustomList> getPaymenCust(
      GetPaymentCust getPayCust) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    // var log = Logger();
    try {
      response = await dio.post(paymentCustomUrl + "get", data: getPayCust);
      var generalResponse = GeneralResponse.fromJson(response.data);
      // log.d(generalResponse.data.toString());
      if (response.statusCode == 201) {
        var generalResponse = GeneralResponse.fromJson(response.data);
        PaymentCustomList payment =
            PaymentCustomList.fromJson(generalResponse.data);
        // log.d(payment.toJson());
        return payment;
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

  static Future<ResponseCheckout> payment(Checkout checkout) async {
    Response response;
    // var log = Logger();
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.post(paymentUrl, data: checkout);
      if (response.statusCode == 201) {
        var generalResponse = GeneralResponse.fromJson(response.data);
        ResponseCheckout resCheckOut =
            ResponseCheckout.fromJson(generalResponse.data);
        return resCheckOut;
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
