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
import 'package:siangmalam/models/purchase-orders/po-item.dart';
import 'package:siangmalam/models/purchase-orders/po-purchasing.dart';
import 'package:siangmalam/widgets/snack_bar.dart';

class PurchaseItemService {
  /* Get Data List Stock Product  */
  static Future<ResPoItem> getPoItemAll(FilterGetAllPO filter) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.post(purchaseItemUrlV2, data: filter);
      if (response.statusCode == 201) {
        var generalResponse = GeneralResponse.fromJson(response.data);
        ResPoItem listPoitem = ResPoItem.fromJson(generalResponse.data);
        return listPoitem;
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

  static Future<DetailPurchasing> getDetailPoItemsPayment(
      String noOrder) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.get(purchaseItemUrlDetailePayment + '/' + noOrder);
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

  static Future<ListPoItem> getPoItemById(String id) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.get(purchaseItemUrlById + id);
      if (response.statusCode == 200) {
        var generalResponse = GeneralResponse.fromJson(response.data);
        ListPoItem listPoItem = ListPoItem.fromJson(generalResponse.data);
        return listPoItem;
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

  static Future<ListPoItem> getPoItemByNoOrder(String order) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.get(purchaseItemUrlByOrderNo + order);
      if (response.statusCode == 200) {
        var generalResponse = GeneralResponse.fromJson(response.data);
        ListPoItem listPoItem = ListPoItem.fromJson(generalResponse.data);
        return listPoItem;
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

  static Future<bool> createPoItem(UpsertPoItem upsertItem) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response =
          await dio.post(purchaseItemUrlUpsert + 'create/v2', data: upsertItem);
      if (response.statusCode == 201) {
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

  static Future<bool> updatePoItem(UpsertPoItem upsertItem) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response =
          await dio.put(purchaseItemUrlUpsert + 'status/v2', data: upsertItem);
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

  static Future<bool> approvalPoItem(ApprovPoItem approveData) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.post(purchaseItemUrlApprove, data: approveData);
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

  static Future<bool> cancelPoItem(String orderId) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.post(purchaseItemUrlCancel + orderId);
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
        purchaseItemUrlImage,
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
        purchaseItemUrlPayment,
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
