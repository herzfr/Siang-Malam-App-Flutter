import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:siangmalam/commons/dio_http.dart';
import 'package:siangmalam/commons/functions/dio_exception.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/url_values.dart';
import 'package:siangmalam/constans/values.dart';
import 'package:siangmalam/models/PaginationFilter.dart';
import 'package:siangmalam/models/customer/create_customer_dto.dart';
import 'package:siangmalam/models/customer/customer.dart';
import 'package:siangmalam/models/customer/update_customer_dto.dart';
import 'package:siangmalam/models/general_response.dart';
import 'package:siangmalam/widgets/snack_bar.dart';

class CustomerService {
  static Future<Customer> getCustomer(PaginationFilter filter) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.get(customerUrl, queryParameters: {
        "size": filter.size,
        "page": filter.page,
        "search": filter.search
      });
      if (response.statusCode == 200) {
        var generalResponse = GeneralResponse.fromJson(response.data);
        Customer customer = Customer.fromJson(generalResponse.data);
        // print("wowww--- ${stockProducts}");
        return customer;
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

  static Future<Customer> getCustomerAll() async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.get(customerUrl);
      if (response.statusCode == 200) {
        var generalResponse = GeneralResponse.fromJson(response.data);
        Customer customer = Customer.fromJson(generalResponse.data);
        // print("wowww--- ${stockProducts}");
        return customer;
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

  /* POST CUST  */
  static Future<void> createCustomer(CreateCustomerDto setData) async {
    Response response;
    Dio dio = await DioConfig.getDio();

    try {
      response = await dio.post(suplierUrl, data: setData);
      var generalResponse = GeneralResponse.fromJson(response.data);

      if (generalResponse.statusCode == 0) {
        Snackbar.showAndBackWithResult(
            "Sukses", "Penambahan pelanggan berhasil", primaryGreen, textColor);
      }
    } on DioError catch (error) {
      var message = DioExceptions().fromDioError(error);
      Snackbar.show("Gagal", message, mtRed600, mtGrey50);
    } catch (error) {
      Snackbar.show("Gagal", "Oops ada yang salah", mtRed600, mtGrey50);
    }
  }

  /* PUT CUST  */
  static Future<void> updateCustomer(UpdateCustomerDto setData) async {
    Response response;
    Dio dio = await DioConfig.getDio();

    try {
      response = await dio.put(suplierUrl, data: setData);
      var generalResponse = GeneralResponse.fromJson(response.data);

      if (generalResponse.statusCode == 0) {
        Snackbar.showAndBackWithResult(
            "Sukses", "Perubahan pelanggan berhasil", primaryGreen, textColor);
      }
    } on DioError catch (error) {
      var message = DioExceptions().fromDioError(error);
      Snackbar.show("Gagal", message, mtRed600, mtGrey50);
    } catch (error) {
      Snackbar.show("Gagal", "Oops ada yang salah", mtRed600, mtGrey50);
    }
  }
}
