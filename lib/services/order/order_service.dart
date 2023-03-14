import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response hide FormData hide MultipartFile;
// import 'package:logger/logger.dart';
import 'package:siangmalam/commons/dio_http.dart';
import 'package:siangmalam/commons/functions/dio_exception.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/url_values.dart';
import 'package:siangmalam/constans/values.dart';
import 'package:siangmalam/models/general_response.dart';
import 'package:siangmalam/models/order/all-order-response.dart';
import 'package:siangmalam/models/order/category-menu-prod.dart';
import 'package:siangmalam/models/order/create-order-response.dart';
import 'package:siangmalam/models/order/get-order.dart';
import 'package:siangmalam/models/order/menu-filter.dart';
import 'package:siangmalam/models/order/menu.dart';
import 'package:siangmalam/models/order/package.dart';
import 'package:siangmalam/models/order/price-categories.dart';
import 'package:siangmalam/models/order/table-filter.dart';
import 'package:siangmalam/models/order/table.dart';
import 'package:siangmalam/models/order/upsert-table.dart';
// import 'package:siangmalam/models/stok-item-out/response/stock_item_out.dart';
import 'package:siangmalam/widgets/snack_bar.dart';

class OrderService {
  static Future<TableModel> getTable(TableFilter tableFilter) async {
    Response response;
    // var log = Logger();
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.post(tableUrl + 'get', data: tableFilter);
      if (response.statusCode == 201) {
        var generalResponse = GeneralResponse.fromJson(response.data);
        TableModel tbl = TableModel.fromJson(generalResponse.data);
        return tbl;
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

  /* CREATE TABLE  */
  static Future<void> createTable(CreateTable table) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.post(tableUrl + 'create', data: table);
      var generalResponse = GeneralResponse.fromJson(response.data);

      if (generalResponse.statusCode == 0) {
        Snackbar.showAndBackWithResult(
            "Sukses", "Penambahan meja berhasil", primaryGreen, textColor);
      }
    } on DioError catch (error) {
      var message = DioExceptions().fromDioError(error);
      Snackbar.show("Gagal", message, mtRed600, mtGrey50);
    } catch (error) {
      Snackbar.show("Gagal", "Oops ada yang salah", mtRed600, mtGrey50);
    }
  }

  /* UPDATE TABLE  */
  static Future<void> updateTable(UpdateTable table) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.put(tableUrl + 'update', data: table);
      var generalResponse = GeneralResponse.fromJson(response.data);

      if (generalResponse.statusCode == 0) {
        Snackbar.showAndBackWithResult(
            "Sukses", "Penambahan meja berhasil", primaryGreen, textColor);
      }
    } on DioError catch (error) {
      var message = DioExceptions().fromDioError(error);
      Snackbar.show("Gagal", message, mtRed600, mtGrey50);
    } catch (error) {
      Snackbar.show("Gagal", "Oops ada yang salah", mtRed600, mtGrey50);
    }
  }

  /* UPDATE TABLE OCCUPATION  */
  static Future<bool> updateTableOcc(UpdateTableO table) async {
    // var log = Logger();
    // log.d(table.toJson());
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.put(tableUrl + 'occupation', data: table);
      var generalResponse = GeneralResponse.fromJson(response.data);

      if (generalResponse.statusCode == 0) {
        return true;
      } else {
        return false;
      }
    } on DioError catch (error) {
      var message = DioExceptions().fromDioError(error);
      // Snackbar.show("Gagal", message, mtRed600, mtGrey50);
      return false;
    } catch (error) {
      // Snackbar.show("Gagal", "Oops ada yang salah", mtRed600, mtGrey50);
      return false;
    }
  }

  /* DISCOUNT UPDATE  */
  static Future<bool> deleteTable(String id) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.delete(tableUrl + id);
      var generalResponse = GeneralResponse.fromJson(response.data);

      if (generalResponse.statusCode == 0) {
        Snackbar.showAndBackWithResult(
            "Sukses", "Meja telah dihapus", primaryGreen, textColor);
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

  static Future<CategoryMenuProduct> getCategoryMenu(int size, int page) async {
    Response response;
    // var log = Logger();
    Dio dio = await DioConfig.getDio();
    try {
      response =
          await dio.get(categoryProductUrl + '?size=${size}&page=${page}');
      if (response.statusCode == 200) {
        var generalResponse = GeneralResponse.fromJson(response.data);
        CategoryMenuProduct cMprod =
            CategoryMenuProduct.fromJson(generalResponse.data);
        return cMprod;
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

  static Future<PriceCategories> getCategoryPrice(int size, int page) async {
    Response response;
    // var log = Logger();
    Dio dio = await DioConfig.getDio();
    try {
      response =
          await dio.get(priceCategoriesUrl + '?size=${size}&page=${page}');
      if (response.statusCode == 200) {
        var generalResponse = GeneralResponse.fromJson(response.data);
        PriceCategories priceCategories =
            PriceCategories.fromJson(generalResponse.data);
        return priceCategories;
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

  static Future<MenuProduct> getMenu(
      MenuFilter menuFilter, int? subBranch) async {
    Response response;
    // var log = Logger();
    Dio dio = await DioConfig.getDio();
    try {
      var url = subBranch == null
          ? urlMenu + 'branch/single'
          : urlMenu + 'subbranch/single/' + subBranch.toString();
      response = await dio.post(url, data: menuFilter);
      if (response.statusCode == 201) {
        var generalResponse = GeneralResponse.fromJson(response.data);
        MenuProduct menu = MenuProduct.fromJson(generalResponse.data);
        return menu;
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

  static Future<MenuPackage> getPackage(
      MenuFilter menuFilter, int? subBranch) async {
    Response response;
    // var log = Logger();
    Dio dio = await DioConfig.getDio();
    try {
      var url = subBranch == null
          ? urlMenu + 'branch/package'
          : urlMenu + 'subbranch/package/' + subBranch.toString();
      response = await dio.post(url, data: menuFilter);
      if (response.statusCode == 201) {
        var generalResponse = GeneralResponse.fromJson(response.data);
        MenuPackage package = MenuPackage.fromJson(generalResponse.data);
        return package;
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

  static Future<CreateOrderResponse> createOrderRequest(
      CreateOrderResponse createTempSales) async {
    Response response;
    // var log = Logger();
    Dio dio = await DioConfig.getDio();
    try {
      response =
          await dio.post(orderTempSales + 'create', data: createTempSales);
      if (response.statusCode == 201) {
        var generalResponse = GeneralResponse.fromJson(response.data);
        CreateOrderResponse createORes =
            CreateOrderResponse.fromJson(generalResponse.data);
        return createORes;
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

  static Future<CreateOrderResponse> updateOrderRequest(
      CreateOrderResponse createTempSales) async {
    Response response;
    // var log = Logger();
    Dio dio = await DioConfig.getDio();
    try {
      response =
          await dio.post(orderTempSales + 'update', data: createTempSales);
      if (response.statusCode == 201) {
        var generalResponse = GeneralResponse.fromJson(response.data);
        CreateOrderResponse createORes =
            CreateOrderResponse.fromJson(generalResponse.data);
        return createORes;
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

  static Future<AllOrderRes> getAllOrder(GetOrder filterOrder) async {
    Response response;
    // var log = Logger();
    Dio dio = await DioConfig.getDio();
    // log.d(filterOrder.toJson());
    try {
      response = await dio.post(orderTempSales + 'get', data: filterOrder);

      if (response.statusCode == 201) {
        var generalResponse = GeneralResponse.fromJson(response.data);
        AllOrderRes allOrderList = AllOrderRes.fromJson(generalResponse.data);
        return allOrderList;
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

  static Future<CreateOrderResponse> getOrderRequestJustSalesId(
      String id) async {
    Response response;
    // var log = Logger();
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.get(orderTempSales + 'get/' + id);
      if (response.statusCode == 200) {
        var generalResponse = GeneralResponse.fromJson(response.data);
        CreateOrderResponse createORes =
            CreateOrderResponse.fromJson(generalResponse.data);
        return createORes;
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

  static Future<bool> cancelOrderTemps(int id, String note) async {
    Response response;
    // var log = Logger();
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio
          .post(orderTempSales + 'cancel', data: {"salesId": id, "note": note});
      var generalResponse = GeneralResponse.fromJson(response.data);
      if (generalResponse.statusCode == 0) {
        Snackbar.show(
            "Sukses", "Pembatalan pesanan berhasil", primaryGreen, textColor);
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

  static Future<bool> sendTrigger(int branchId, int subBranchId) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.post(triggerUrl,
          data: {"branchId": branchId, "subBranchId": subBranchId});
      var generalResponse = GeneralResponse.fromJson(response.data);
      if (generalResponse.statusCode == 0) {
        return true;
      } else {
        return false;
      }
    } on DioError {
      return false;
    } catch (error) {
      return false;
    }
  }
}
