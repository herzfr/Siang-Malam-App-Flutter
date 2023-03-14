import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:siangmalam/commons/dio_http.dart';
import 'package:siangmalam/commons/functions/dio_exception.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/url_values.dart';
import 'package:siangmalam/constans/values.dart';
import 'package:siangmalam/models/PaginationFilter.dart';
import 'package:siangmalam/models/general_response.dart';
import 'package:siangmalam/models/general_response2.dart';
// import 'package:siangmalam/models/product/items.dart';
import 'package:siangmalam/models/product/stock_item.dart';
import 'package:siangmalam/models/product/stock_item_transfer.dart';
import 'package:siangmalam/models/product/stock_product.dart';
import 'package:siangmalam/models/product/stock_transfer.dart';
import 'package:siangmalam/models/purchase-order/po-item-list.dart';
import 'package:siangmalam/models/transfer/transfer.dart';
import 'package:siangmalam/models/transfer/upsert_transfer.dart';
import 'package:siangmalam/widgets/snack_bar.dart';

class ProductService {
  /* Get Data List Stock Product  */
  static Future<StockProducts> getStockProduct(PaginationFilter filter) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.get(stockProductUrl, queryParameters: {
        "size": filter.size,
        "page": filter.page,
        "search": filter.search
      });
      if (response.statusCode == 200) {
        var generalResponse = GeneralResponse.fromJson(response.data);
        StockProducts stockProducts =
            StockProducts.fromJson(generalResponse.data);
        // print("wowww--- ${stockProducts}");
        return stockProducts;
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

  static Future<RespStockProd> getStockProductByBranch(
      GetStockProd filter) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.post(stockProductUrl + '/get', data: filter);
      if (response.statusCode == 201) {
        RespStockProd stockProducts = RespStockProd.fromJson(response.data);
        return stockProducts;
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

  /* POST Data Stock Product  */
  static Future<void> transferProduct(StockTransferDto setData) async {
    Response response;
    Dio dio = await DioConfig.getDio();

    try {
      response = await dio.post(tranferprodUrl, data: setData);
      var generalResponse = GeneralResponse.fromJson(response.data);

      if (generalResponse.statusCode == 0) {
        Snackbar.showAndBackWithResult(
            "Sukses", "Transfer stok produk berhasil", primaryGreen, textColor);
      }
    } on DioError catch (error) {
      var message = DioExceptions().fromDioError(error);
      Snackbar.show("Gagal", message, mtRed600, mtGrey50);
    } catch (error) {
      Snackbar.show("Gagal", "Oops ada yang salah", mtRed600, mtGrey50);
    }
  }

/* Get Data List Stock Items  */
  static Future<StockItem> getStockItems(PaginationFilter filter) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.get(stockItemUrl, queryParameters: {
        "size": filter.size,
        "page": filter.page,
        "search": filter.search
      });
      if (response.statusCode == 200) {
        var generalResponse = GeneralResponse.fromJson(response.data);
        StockItem stockItems = StockItem.fromJson(generalResponse.data);
        // print("wowww--- ${stockProducts}");
        return stockItems;
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

/* Get Data List Stock Items  */
  static Future<StockItem> getStockItemsBySubBranch(
      PaginationFilter filter, String id) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.get(stockItemUrl + '/getbysubbranch/' + id,
          queryParameters: {
            "size": filter.size,
            "page": filter.page,
            "search": filter.search
          });
      if (response.statusCode == 200) {
        var generalResponse = GeneralResponse.fromJson(response.data);
        StockItem stockItems = StockItem.fromJson(generalResponse.data);
        // print("wowww--- ${stockProducts}");
        return stockItems;
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

  /* POST Data Stock Items  */
  static Future<void> transferItems(StockTransferItemDto setData) async {
    Response response;
    Dio dio = await DioConfig.getDio();

    try {
      response = await dio.post(tranferitemUrl, data: setData);
      var generalResponse = GeneralResponse.fromJson(response.data);

      if (generalResponse.statusCode == 0) {
        Snackbar.showAndBackWithResult(
            "Sukses", "Transfer stok produk berhasil", primaryGreen, textColor);
      }
    } on DioError catch (error) {
      var message = DioExceptions().fromDioError(error);
      Snackbar.show("Gagal", message, mtRed600, mtGrey50);
    } catch (error) {
      Snackbar.show("Gagal", "Oops ada yang salah", mtRed600, mtGrey50);
    }
  }

  /* Get Data List Stock Items  */
  static Future<PoItemData> getItems(PaginationFilter filter) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.get(itemUrl, queryParameters: {
        "size": filter.size,
        "page": filter.page,
        "search": filter.search
      });
      if (response.statusCode == 200) {
        var generalResponse = GeneralResponse.fromJson(response.data);
        PoItemData items = PoItemData.fromJson(generalResponse.data);
        // print("wowww--- ${stockProducts}");
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

  /* Get Data List Stock Items  */
  static Future<StockItem> getStockItemByWarehouseId(
      PaginationFilter filter, String id) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.get(stockItemUrl + '/getbywarehouse/' + id,
          queryParameters: {
            "size": filter.size,
            "page": filter.page,
            "search": filter.search
          });
      if (response.statusCode == 200) {
        var generalResponse = GeneralResponse.fromJson(response.data);
        StockItem stockItems = StockItem.fromJson(generalResponse.data);
        // print("wowww--- ${stockProducts}");
        return stockItems;
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

  static Future<Transfer> getTransferList(
      FilterTransferList filter, String as) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.post(transferProductUrl + as, data: filter);
      if (response.statusCode == 201) {
        var generalResponse = GeneralResponse2.fromJson(response.data);
        Transfer transfer = Transfer.fromJson(generalResponse.data);
        return transfer;
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

  static Future<void> createTransferList(UpsertTransfer filter) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.post(transferProductUrl + 'create', data: filter);
      if (response.statusCode == 201) {
        Snackbar.showAndBackWithResult(
            "Sukses", "Transfer stok produk berhasil", primaryGreen, textColor);
      } else {
        throw Error();
      }
    } on DioError catch (error) {
      // log.d(error);
      var message = DioExceptions().fromDioError(error);
      Snackbar.show("Gagal", message, mtRed600, mtGrey50);
    } catch (error) {
      // log.d(error);
      Snackbar.show("Gagal", "Oops ada yang salah", mtRed600, mtGrey50);
    }
  }

  static Future<void> updateTransferList(UpsertTransfer filter) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.put(transferProductUrl + 'updatestat', data: filter);
      if (response.statusCode == 200) {
        Snackbar.showAndBackWithResult(
            "Sukses", "Transfer stok produk diterima", primaryGreen, textColor);
      } else {
        throw Error();
      }
    } on DioError catch (error) {
      // log.d(error);
      var message = DioExceptions().fromDioError(error);
      Snackbar.show("Gagal", message, mtRed600, mtGrey50);
    } catch (error) {
      // log.d(error);
      Snackbar.show("Gagal", "Oops ada yang salah", mtRed600, mtGrey50);
    }
  }

  static Future<bool> cancelTransfer(CancelTransfer filter) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.post(transferProductUrl + 'cancel', data: filter);
      if (response.statusCode == 201) {
        return true;
      } else {
        throw Error();
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
