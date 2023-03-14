import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response hide FormData hide MultipartFile;
import 'package:http_parser/http_parser.dart';
import 'package:siangmalam/commons/dio_http.dart';
import 'package:siangmalam/commons/functions/dio_exception.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/url_values.dart';
import 'package:siangmalam/constans/values.dart';
import 'package:siangmalam/models/general_response.dart';
import 'package:siangmalam/models/purchase-orders/filter-po.dart';
import 'package:siangmalam/models/purchase-orders/po-product.dart';
import 'package:siangmalam/models/purchase-orders/po-purchasing.dart';
import 'package:siangmalam/widgets/snack_bar.dart';

class PurchaseProductService {
  /* Get Data List Stock Product  */
  static Future<ResPoProduct> getPoProductAll(FilterGetAllPO filter) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.post(purchaseProdUrlV2, data: filter);
      if (response.statusCode == 201) {
        var generalResponse = GeneralResponse.fromJson(response.data);
        ResPoProduct listPoProduct =
            ResPoProduct.fromJson(generalResponse.data);
        return listPoProduct;
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

  static Future<DetailPurchasing> getDetailPoProductPayment(
      String noOrder) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.get(purchaseProdUrlDetailePayment + '/' + noOrder);
      if (response.statusCode == 200) {
        var generalResponse = GeneralResponse.fromJson(response.data);
        DetailPurchasing detailPurchasing =
            DetailPurchasing.fromJson(generalResponse.data);
        return detailPurchasing;
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

  static Future<ListPoProduct> getPoProductById(String id) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.get(purchaseProdUrlById + id);
      if (response.statusCode == 200) {
        var generalResponse = GeneralResponse.fromJson(response.data);
        ListPoProduct listPoProduct =
            ListPoProduct.fromJson(generalResponse.data);
        return listPoProduct;
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

  static Future<ListPoProduct> getPoProductByNoOrder(String order) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.get(purchaseProdUrlByOrderNo + order);
      if (response.statusCode == 200) {
        var generalResponse = GeneralResponse.fromJson(response.data);
        ListPoProduct listPoProduct =
            ListPoProduct.fromJson(generalResponse.data);
        return listPoProduct;
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

  static Future<bool> createPoProduct(UpsertPoProduct upsertProduct) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.post(purchaseProdUrlUpsert + 'create/v2',
          data: upsertProduct);
      if (response.statusCode == 201) {
        Snackbar.showAndBackWithResult(
            "Sukses", "Pembuatan PO Berhasil", primaryGreen, textColor);
        return true;
      } else {
        throw Error();
      }
    } on DioError catch (error) {
      var generalResponse = GeneralResponse.fromJson(error.response?.data);
      String? errMessage = generalResponse.message ?? errorHappen;
      Get.snackbar("Error", errMessage,
          backgroundColor: mtRed600, colorText: textColor);
      return false;
    } catch (error) {
      Get.snackbar("Error", error.toString(),
          backgroundColor: mtRed600, colorText: textColor);
      return false;
    }
  }

  static Future<bool> updatePoProduct(UpsertPoProduct upsertProduct) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.put(purchaseProdUrlUpsert + 'status/v2',
          data: upsertProduct);
      if (response.statusCode == 200) {
        Snackbar.showAndBackWithResult(
            "Sukses", "Pembaharuan PO Berhasil", primaryGreen, textColor);
        return true;
      } else {
        throw Error();
      }
    } on DioError catch (error) {
      var generalResponse = GeneralResponse.fromJson(error.response?.data);
      String? errMessage = generalResponse.message ?? errorHappen;
      Get.snackbar("Error", errMessage,
          backgroundColor: mtRed600, colorText: textColor);
      return false;
    } catch (error) {
      Get.snackbar("Error", error.toString(),
          backgroundColor: mtRed600, colorText: textColor);
      return false;
    }
  }

  static Future<bool> approvalPoProduct(ApprovPoProduct approveData) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.post(purchaseProdUrlApprove, data: approveData);
      if (response.statusCode == 201) {
        return true;
      } else {
        throw Error();
      }
    } on DioError catch (error) {
      var generalResponse = GeneralResponse.fromJson(error.response?.data);
      String? errMessage = generalResponse.message ?? errorHappen;
      Get.snackbar("Error", errMessage,
          backgroundColor: mtRed600, colorText: textColor);
      return false;
    } catch (error) {
      Get.snackbar("Error", error.toString(),
          backgroundColor: mtRed600, colorText: textColor);
      return false;
    }
  }

  static Future<bool> cancelPoProduct(String orderId) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.post(purchaseProdUrlCancel + orderId);
      if (response.statusCode == 201) {
        Snackbar.show(
            "Sukses", "Pembatalan PO Berhasil", primaryGreen, textColor);
        return true;
      } else {
        throw Error();
      }
    } on DioError catch (error) {
      var generalResponse = GeneralResponse.fromJson(error.response?.data);
      String? errMessage = generalResponse.message ?? errorHappen;
      Get.snackbar("Error", errMessage,
          backgroundColor: mtRed600, colorText: textColor);
      return false;
    } catch (error) {
      Get.snackbar("Error", error.toString(),
          backgroundColor: mtRed600, colorText: textColor);
      return false;
    }
  }

  static Future<bool> uploadProof(
      List<ImagePurchaseRequestDto> file, String orderNo) async {
    Response response;
    Dio dio = await DioConfig.getDio();

    Map<String, String> headers = <String, String>{};
    headers.putIfAbsent("Content-Type", () => "multipart/form-data");

    FormData formData = FormData.fromMap(
      {
        "proof": await MultipartFile.fromFile(
          file[0].filePath,
          filename: file[0].fileName,
          contentType: MediaType("image", "jpeg"),
        ),
        "orderNo": orderNo
      },
    );

    try {
      response = await dio.post(
        purchaseProdUrlImage,
        data: formData,
        options: Options(headers: headers),
      );
      var generalResponse =
          ImagePurchaseResponseUpdateDto.fromJson(response.data);

      if (generalResponse.statusCode == 0) {
        Snackbar.showAndBackWithResult(
            "Sukses", "Upload/Approve bukti berhasil", primaryGreen, textColor);
        return true;
      } else {
        return false;
      }
    } on DioError catch (error) {
      var message = DioExceptions().fromDioError(error);
      Snackbar.show("Upload Gagal", message, mtRed600, mtGrey50);
      return false;
    } catch (error) {
      Snackbar.show(
          "Upload Gagal", "Oops something went wrong", mtRed600, mtGrey50);
      return false;
    }
  }

  static Future<bool> approvePayment(
      ImagePurchaseRequestDto file, PaymentPo obj) async {
    Response response;
    Dio dio = await DioConfig.getDio();

    Map<String, String> headers = <String, String>{};
    headers.putIfAbsent("Content-Type", () => "multipart/form-data");

    FormData formData = FormData.fromMap(
      {
        "receipt": await MultipartFile.fromFile(
          file.filePath,
          filename: file.fileName,
          contentType: MediaType("image", "jpeg"),
        ),
        "orderNo": obj.orderNo ?? "null",
        "amount": obj.amount ?? "null",
        "expenseType": obj.expenseType ?? "null",
        "paymentTypeId": obj.paymentTypeId ?? "null",
        "transactionNo": obj.transactionNo ?? "null",
        "cardName": obj.cardName ?? "null",
        "cardNo": obj.cardNo ?? "null",
        "batchNo": obj.batchNo ?? "null",
        "merchantId": obj.merchantId ?? "null",
      },
    );

    try {
      response = await dio.post(
        purchaseProdUrlDetailePayment,
        data: formData,
        options: Options(headers: headers),
      );
      var generalResponse =
          ImagePurchaseResponseUpdateDto.fromJson(response.data);

      if (generalResponse.statusCode == 0) {
        Snackbar.show(
            "Sukses", "Upload pembayaran berhasil.", primaryGreen, textColor);
        return true;
      } else {
        return false;
      }
    } on DioError catch (error) {
      var message = DioExceptions().fromDioError(error);
      Snackbar.show("Upload pembayaran gagal!", message, mtRed600, mtGrey50);
      return false;
    } catch (error) {
      Snackbar.show("Upload pembayaran gagal!", "Oops something went wrong",
          mtRed600, mtGrey50);
      return false;
    }
  }
}
