import 'dart:io';

import 'package:dio/dio.dart';
// import 'package:get/get.dart' hide Response;
// import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:siangmalam/commons/dio_http.dart';
import 'package:siangmalam/commons/functions/dio_exception.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/url_values.dart';
// import 'package:siangmalam/constans/values.dart';
// import 'package:siangmalam/models/PaginationFilter.dart';
// import 'package:siangmalam/models/customer/create_customer_dto.dart';
// import 'package:siangmalam/models/customer/customer.dart';
// import 'package:siangmalam/models/customer/update_customer_dto.dart';
import 'package:siangmalam/models/general_response.dart';
import 'package:siangmalam/models/report/report.dart';
import 'package:siangmalam/widgets/snack_bar.dart';

class CashbonService {
  static Future<CashbonList> getCashbonList(GetCashbonFilter filter) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.post(emplCashbonUrl + 'kasbon/', data: filter);
      if (response.statusCode == 201) {
        var generalResponse = GeneralResponse.fromJson(response.data);
        CashbonList cashbonList = CashbonList.fromJson(generalResponse.data);
        return cashbonList;
      } else {
        throw Error();
      }
    } on DioError catch (error) {
      var message = DioExceptions().fromDioError(error);
      Snackbar.show("Gagal", message, mtRed600, mtGrey50);
      return Future.error("Error");
    } catch (error) {
      Snackbar.show("Gagal", "Oops ada yang salah", mtRed600, mtGrey50);
      return Future.error("Error");
    }
  }

  static Future<void> downloadCashbonReport(
      DownloadReportCashbon filter) async {
    // var log = Logger();
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.post(
        emplCashbonUrl + 'kasbon/download',
        data: filter,
        onReceiveProgress: showDownloadProgress,
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }),
      );

      // log.d(response.headers);
      Directory appDocDir = await getApplicationDocumentsDirectory();
      // log.d(appDocDir.path);
      File file = File(appDocDir.path);
      var raf = file.openSync(mode: FileMode.write);
      // response.data is List<int> type
      raf.writeFromSync(response.data);
      await raf.close();
      // if (response.statusCode == 201) {
      //   Snackbar.show("Sukses", "Download Berhasil", primaryGreen, textColor);
      // } else {
      //   throw Error();
      // }
    } on DioError catch (error) {
      var message = DioExceptions().fromDioError(error);
      Snackbar.show("Gagal", message, mtRed600, mtGrey50);
    } catch (error) {
      Snackbar.show("Gagal", "Oops ada yang salah", mtRed600, mtGrey50);
    }
  }

  static void showDownloadProgress(int received, int total) {
    if (total != -1) {
      // print((received / total * 100).toStringAsFixed(0) + "%");
    }
  }
}
