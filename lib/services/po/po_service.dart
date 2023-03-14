import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response hide FormData hide MultipartFile;
import 'package:http_parser/http_parser.dart';
// import 'package:logger/logger.dart';
import 'package:siangmalam/commons/dio_http.dart';
import 'package:siangmalam/commons/functions/dio_exception.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/url_values.dart';
import 'package:siangmalam/constans/values.dart';
import 'package:siangmalam/models/PaginationFilter.dart';
import 'package:siangmalam/models/general_response.dart';
import 'package:siangmalam/models/purchase-order/po-item-create-request.dart';
import 'package:siangmalam/models/purchase-order/po-item-filter.dart';
import 'package:siangmalam/models/purchase-order/po-item-proof.dart';
import 'package:siangmalam/models/purchase-order/po-item-update.dart';
import 'package:siangmalam/models/purchase-order/po-item.dart';
import 'package:siangmalam/models/purchase-orders/product-po.dart';
import 'package:siangmalam/models/user/image_profile_request.dart';
import 'package:siangmalam/models/user/image_profile_response.dart';
import 'package:siangmalam/widgets/snack_bar.dart';

class PoService {
  /* Get Data List Stock Product  */
  static Future<PoItem> getPoItem(PoItemFilter filter) async {
    Response response;
    // var log = Logger();
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.post(purchaseItemUrl, data: filter);
      if (response.statusCode == 201) {
        var generalResponse = GeneralResponse.fromJson(response.data);
        PoItem poItem = PoItem.fromJson(generalResponse.data);
        // print("wowww--- ${stockProducts}");
        return poItem;
      } else {
        // log.d(' ini error di getPoItem');
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

  static Future<PoItem> getPoItemWithoutSub(
      PoItemFilterWithoutSubbranch filter) async {
    Response response;
    // var log = Logger();
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.post(purchaseItemUrl, data: filter);
      if (response.statusCode == 201) {
        var generalResponse = GeneralResponse.fromJson(response.data);
        PoItem poItem = PoItem.fromJson(generalResponse.data);
        // print("wowww--- ${stockProducts}");
        return poItem;
      } else {
        // log.d(' ini error di getPoItemWithoutSub');
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

  static Future<SeedItemForPo> getItemV2(PaginationFilter filter) async {
    // var log = Logger();
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.get(itemUrl, queryParameters: {
        "size": filter.size,
        "page": filter.page,
        "search": filter.search,
        "option": "name"
      });
      if (response.statusCode == 200) {
        var generalResponse = GeneralResponse.fromJson(response.data);
        SeedItemForPo items = SeedItemForPo.fromJson(generalResponse.data);
        return items;
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

  /* POST Data PO CREATE  */
  static Future<bool> createPoItem(PoItemCreateDto setData) async {
    Response response;
    Dio dio = await DioConfig.getDio();

    try {
      response = await dio.post(purchaseItemCreate, data: setData);
      var generalResponse = GeneralResponse.fromJson(response.data);

      if (generalResponse.statusCode == 0) {
        Snackbar.showAndBackWithResult(
            "Sukses", "Belanja bahan telah dibuat", primaryGreen, textColor);
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

  /* POST Data PO UPDATE  */
  static Future<bool> updatePoItems(PoUpdateDto setData) async {
    Response response;
    Dio dio = await DioConfig.getDio();

    try {
      response = await dio.put(purchaseItemUpdate, data: setData);
      var generalResponse = GeneralResponse.fromJson(response.data);

      if (generalResponse.statusCode == 0) {
        Snackbar.show("Sukses", "Ubah hasil belanja bahan berhasil",
            primaryGreen, textColor);
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

  /* POST Data PO APPROV  */
  static Future<bool> proofPoItems(PoItemProofDto setData) async {
    Response response;
    Dio dio = await DioConfig.getDio();

    try {
      response = await dio.post(purchaseItemApproval, data: setData);
      var generalResponse = GeneralResponse.fromJson(response.data);

      if (generalResponse.statusCode == 0) {
        Snackbar.showAndBackWithResult(
            "Sukses", "hasil belanja bahan disetujui", primaryGreen, textColor);
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

  /* POST Data PO CANCEL  */
  static Future<bool> cancelPoItems(String noOrder) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.post(purchaseItemCancel + noOrder);
      var generalResponse = GeneralResponse.fromJson(response.data);

      if (generalResponse.statusCode == 0) {
        Snackbar.show("Sukses", "Ubah hasil belanja bahan berhasil",
            primaryGreen, textColor);
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

  static Future<PoItemList> getItemWithNoOrder(String noorder) async {
    Response response;
    // var log = Logger();
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.get(purchaseItemWithNoOrder + noorder);
      if (response.statusCode == 200) {
        var generalResponse = GeneralResponse.fromJson(response.data);
        PoItemList poItem = PoItemList.fromJson(generalResponse.data);
        // print("wowww--- ${stockProducts}");
        return poItem;
      } else {
        // log.d(' ini error di getPoItemWithoutSub');
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

  Future<bool> uploadProof(
      List<ImageProfileRequestDto> file, String orderNo) async {
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
        "receipt": await MultipartFile.fromFile(
          file[1].filePath,
          filename: file[1].fileName,
          contentType: MediaType("image", "jpeg"),
        ),
        "orderNo": orderNo
      },
    );

    try {
      response = await dio.post(
        purchaseItemImageUrl,
        data: formData,
        options: Options(headers: headers),
      );
      var generalResponse = ImageProfileResponseDto.fromJson(response.data);

      if (generalResponse.statusCode == 0) {
        Snackbar.show(
            "Sukses", "Ubah foto profil berhasil", primaryGreen, textColor);
        var data = generalResponse.data;

        // if (data != null) {
        //   AppStatic.userData.picture = generalResponse.data;
        // }

        return true;
      } else {
        return false;
      }
    } on DioError catch (error) {
      var message = DioExceptions().fromDioError(error);
      Snackbar.show("Upload Foto Bukti Gagal", message, mtRed600, mtGrey50);
      return false;
    } catch (error) {
      Snackbar.show("Upload Foto Bukti Gagal", "Oops something went wrong",
          mtRed600, mtGrey50);
      return false;
    }
  }
}
