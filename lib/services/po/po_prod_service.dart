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
import 'package:siangmalam/models/purchase-order-product/filter_po_products.dart';
import 'package:siangmalam/models/purchase-order-product/po_prod_approval_dto.dart';
import 'package:siangmalam/models/purchase-order-product/po_prod_create_dto.dart';
import 'package:siangmalam/models/purchase-order-product/po_prod_data.dart';
import 'package:siangmalam/models/purchase-order-product/po_prod_update_dto.dart';
import 'package:siangmalam/models/purchase-order-product/po_products.dart';
import 'package:siangmalam/models/purchase-orders/product-po.dart';
import 'package:siangmalam/models/user/image_profile_request.dart';
import 'package:siangmalam/models/user/image_profile_response.dart';
import 'package:siangmalam/widgets/snack_bar.dart';

class PoProductService {
  /* Get Data List Stock Product  */
  static Future<PoProducts> getPoProduct(FilterPoProduct filter) async {
    Response response;
    // var log = Logger();
    // log.d('filter data ${filter.toString()}');
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.post(purchaseproductUrl, data: filter);
      if (response.statusCode == 201) {
        var generalResponse = GeneralResponse.fromJson(response.data);
        PoProducts poProd = PoProducts.fromJson(generalResponse.data);
        // print("wowww--- ${stockProducts}");
        return poProd;
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

  /* POST Data PO CREATE  */
  static Future<bool> createPoProduct(PoProductCreateDto setData) async {
    Response response;
    Dio dio = await DioConfig.getDio();

    try {
      response = await dio.post(purchaseproductCreate, data: setData);
      var generalResponse = GeneralResponse.fromJson(response.data);

      if (generalResponse.statusCode == 0) {
        Snackbar.showAndBackWithResult(
            "Sukses", "Belanja produk telah dibuat", primaryGreen, textColor);
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
  static Future<bool> updatePoProduct(PoProductUpdateDto setData) async {
    Response response;
    Dio dio = await DioConfig.getDio();

    try {
      response = await dio.put(purchaseproductUpdate, data: setData);
      var generalResponse = GeneralResponse.fromJson(response.data);

      if (generalResponse.statusCode == 0) {
        Snackbar.show("Sukses", "Ubah hasil belanja produk berhasil",
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
  static Future<bool> proofPoProduct(PoProductApprovalDto setData) async {
    Response response;
    Dio dio = await DioConfig.getDio();

    try {
      response = await dio.post(purchaseproductApproval, data: setData);
      var generalResponse = GeneralResponse.fromJson(response.data);

      if (generalResponse.statusCode == 0) {
        Snackbar.showAndBackWithResult("Sukses",
            "hasil belanja produk disetujui", primaryGreen, textColor);
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
  static Future<bool> cancelPoProduct(String noOrder) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.post(purchaseproductCancel + noOrder);
      var generalResponse = GeneralResponse.fromJson(response.data);

      if (generalResponse.statusCode == 0) {
        Snackbar.show("Sukses", "Membatalkan pesanan produk berhasil",
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

  static Future<PoProductList> getProdwithNoOrder(String noorder) async {
    Response response;
    // var log = Logger();
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.get(purchaseproductWithNoOrder + noorder);
      if (response.statusCode == 200) {
        var generalResponse = GeneralResponse.fromJson(response.data);
        PoProductList poprod = PoProductList.fromJson(generalResponse.data);
        // print("wowww--- ${stockProducts}");
        return poprod;
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
        purchaseproductImageUrl,
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

  static Future<ProductData> getProduct(PaginationFilter filter) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.get(productUrl, queryParameters: {
        "size": filter.size,
        "page": filter.page,
        "search": filter.search,
        "option": "name"
      });
      if (response.statusCode == 200) {
        var generalResponse = GeneralResponse.fromJson(response.data);
        ProductData products = ProductData.fromJson(generalResponse.data);
        return products;
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

  static Future<SeedProductForPo> getProdV2(PaginationFilter filter) async {
    // var log = Logger();
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.get(productUrl, queryParameters: {
        "size": filter.size,
        "page": filter.page,
        "search": filter.search,
        "option": "name"
      });
      if (response.statusCode == 200) {
        var generalResponse = GeneralResponse.fromJson(response.data);
        SeedProductForPo listproduct =
            SeedProductForPo.fromJson(generalResponse.data);
        return listproduct;
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
