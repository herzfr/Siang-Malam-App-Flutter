import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response hide FormData hide MultipartFile;
// import 'package:logger/logger.dart';
import 'package:siangmalam/commons/dio_http.dart';
import 'package:siangmalam/commons/functions/dio_exception.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/url_values.dart';
import 'package:siangmalam/constans/values.dart';
import 'package:siangmalam/models/cashier/piggybank.dart';
import 'package:siangmalam/models/general_response.dart';
import 'package:siangmalam/widgets/snack_bar.dart';

class PiggyBankService {
  static Future<PiggyBank> getSavingMoneyInfo(
      int? subBranch, int? branch) async {
    Response response;
    // var log = Logger();

    Dio dio = await DioConfig.getDio();
    try {
      var url = subBranch == null
          ? savingUrl + 'branch/' + branch.toString()
          : savingUrl + 'subbranch/' + subBranch.toString();
      response = await dio.get(url);
      if (response.statusCode == 200) {
        var generalResponse = GeneralResponse.fromJson(response.data);
        PiggyBank pgy = PiggyBank.fromJson(generalResponse.data);
        return pgy;
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

  static Future<bool> addSavingMoney(AddFilterPiggy filterPiggy) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.post(savingUrl + 'add', data: filterPiggy);
      var generalResponse = GeneralResponse.fromJson(response.data);

      if (generalResponse.statusCode == 0) {
        ResponsePiggyBank rsp =
            ResponsePiggyBank.fromJson(generalResponse.data);
        Snackbar.show(rsp.type!, rsp.note!, primaryGreen, textColor);
        return true;
      }
      return false;
    } on DioError catch (error) {
      var message = DioExceptions().fromDioError(error);
      Snackbar.show("Gagal", message, mtRed600, mtGrey50);
      return false;
    } catch (error) {
      Snackbar.show("Gagal", "Oops ada yang salah", mtRed600, mtGrey50);
      return false;
    }
  }

  static Future<bool> setSaving(BranchSetSaving branch,
      SubbranchSetSaving subbranch, bool isBranch) async {
    // var log = Logger();
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = isBranch
          ? await dio.post(savingUrl + 'set/branch/', data: branch)
          : await dio.post(savingUrl + 'set/subbranch/', data: subbranch);
      var generalResponse = GeneralResponse.fromJson(response.data);
      if (generalResponse.statusCode == 0) {
        Snackbar.show(
            "Success", "Perubahan celengan berhasil", primaryGreen, textColor);
        return true;
      } else {
        return false;
      }
    } on DioError catch (error) {
      var message = DioExceptions().fromDioError(error);
      Snackbar.show("Gagal", message, mtRed600, mtGrey50);
      return false;
    } catch (error) {
      // log.d(error);
      Snackbar.show("Gagal", "Oops ada yang salah", mtRed600, mtGrey50);
      return false;
    }
  }
}
