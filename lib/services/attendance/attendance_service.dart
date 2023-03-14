import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:siangmalam/constans/values.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/commons/dio_http.dart';
import 'package:siangmalam/models/attendance/user_presence_list.dart';
import 'package:siangmalam/models/general/general_request.dart';
import 'package:siangmalam/widgets/snack_bar.dart';
import 'package:siangmalam/constans/url_values.dart';
import 'package:siangmalam/services/app_static.dart';
import 'package:siangmalam/constans/form_values.dart';
import 'package:siangmalam/models/general_response.dart';
import 'package:siangmalam/models/attendance/time_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siangmalam/models/attendance/presence_check.dart';
import 'package:siangmalam/commons/functions/dio_exception.dart';
import 'package:siangmalam/models/attendance/coordinate.dto.dart';
import 'package:siangmalam/models/attendance/presence_status.dart';
import 'package:siangmalam/models/attendance/presence_response.dart';

/* Created By Dwi Sutrisno */

class AttendanceService {
  /* Get Time From Api Function */
  Future<TimeApiDto> getTime(CoordinateDto location) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      var locationQuery = '?latitude=${location.latitude}&longitude=${location.longitude}';
      response = await dio.get(getCurrTimeByCoordinateUrl + locationQuery);
      var apiResponse = TimeApiDto.fromJson(response.data);
      return apiResponse;
    } on DioError catch (error) {
      var message = DioExceptions().fromDioError(error);
      Snackbar.show(errorLabel, message, mtRed600, mtGrey50);
      return Future.error("$message");
    } catch (error) {
      Snackbar.show(errorLabel, errorHappen, mtRed600, mtGrey50);
      return Future.error(error);
    }
  }

  /* Get Presences Status*/
  Future<PresenceStatusDto> getPresenceStatus() async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.get(getPresenceStatusUrl);
      var generalResponse = GeneralResponse.fromJson(response.data);
      var presenceStatus = PresenceStatusDto.fromJson(generalResponse.data);
      setUserPresenceStatus(presenceStatus);
      return presenceStatus;
    } on DioError catch (_) {
      // var message = DioExceptions().fromDioError(error);
      Snackbar.show(errorLabel, failedGetPresencesStatMessage, mtRed600, mtGrey50);
      // return getUserPresenceStatus();
      return Future.error("");
    } catch (error) {
      Snackbar.show(errorLabel, failedGetPresencesStatMessage, mtRed600, mtGrey50);
      return Future.error(error);
    }
  }

  /* Get Presences Status*/
  Future<PresenceResponse> checkInPresence(PresenceCheckDto checkInData) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.post(checkInUrl, data: checkInData);
      var generalResponse = GeneralResponse.fromJson(response.data);
      if (generalResponse.statusCode == 0) {
        var presenceResponse = PresenceResponse.fromJson(generalResponse.data);
        await setPresenceId(presenceResponse.id!);
        Snackbar.showAndBack("Berhasil", "Absensi anda sudah tercatat", mtBlue300, textColor);
        return presenceResponse;
      } else {
        Snackbar.show("Gagal", generalResponse.message ?? "Absensi anda gagal tercatat", mtRed600, textColor);
        return Future.error("error");
      }
    } on DioError catch (error) {
      var message = DioExceptions().fromDioError(error);
      Snackbar.show(errorLabel, message, mtRed600, mtGrey50);
      return Future.error("$message");
    } catch (error) {
      Snackbar.show(errorLabel, errorHappen, mtRed600, mtGrey50);
      return Future.error(error);
    }
  }

  /* Check Out Presence Function */
  Future checkOutPresence(PresenceCheckDto checkInData) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.post(checkOutUrl, data: checkInData);
      var generalResponse = GeneralResponse.fromJson(response.data);
      if (generalResponse.statusCode == 0) {
        return true;
      } else {
        Snackbar.show("Gagal", generalResponse.message ?? "Absensi anda gagal tercatat", mtRed600, textColor);
        return false;
      }
    } on DioError catch (error) {
      var message = DioExceptions().fromDioError(error);
      Snackbar.show(errorLabel, message, mtRed600, mtGrey50);
      return Future.error("$message");
    } catch (error) {
      Snackbar.show(errorLabel, errorHappen, mtRed600, mtGrey50);
      return Future.error(error);
    }
  }

  /* Get User Presences Data*/
  Future getUserPresenceData(GeneralRequest body) async {
    var requestBody = {
      'size': body.size,
      'page': body.page,
      'search': body.search,
      'type': body.type,
      'startDate': body.startDate,
      'endDate': body.endDate,
      'sortBy': body.sortBy
    };

    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.post(getUserPresenceDataUrl, data: requestBody);
      var generalResponse = GeneralResponse.fromJson(response.data);
      if (generalResponse.statusCode == 0) {
        var userPresenceResponse = UserPresenceResponse.fromJson(generalResponse.data);
        return userPresenceResponse;
      } else {
        Snackbar.show(errorLabel, failedGetPresencesStatMessage, mtRed600, mtGrey50);
        return Future.error('');
      }
    } on DioError catch (error) {
      var message = DioExceptions().fromDioError(error);
      Snackbar.show(errorLabel, failedGetPresencesStatMessage, mtRed600, mtGrey50);
      return Future.error("$message");
    } catch (error) {
      Snackbar.show(errorLabel, failedGetPresencesStatMessage, mtRed600, mtGrey50);
      return Future.error(error);
    }
  }

  /* Set User Presence Status Function */
  static Future setUserPresenceStatus(PresenceStatusDto presenceStatus) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userPresenceStatus', jsonEncode(presenceStatus));
    AppStatic.userPresenceStatus = presenceStatus;
  }

  /* Set User Presence Status Function */
  static Future<PresenceStatusDto> getUserPresenceStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Try reading data from the 'userpresencestatus' key. If it doesn't exist, returns null.
    String? presenceStatusVal = prefs.getString('userPresenceStatus');
    if (presenceStatusVal != null) {
      var presenceStatusDto = PresenceStatusDto.fromJson(jsonDecode(presenceStatusVal));
      return presenceStatusDto;
    } else {
      return PresenceStatusDto(presenceId: 0, isHashCheckIn: false, isHasCheckout: false, date: '', checkInTime: 0);
    }
  }

  /* Set Presence Id Function */
  setPresenceId(int presenceId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('presenceId', presenceId);
    AppStatic.presenceId = presenceId;
  }

  /* Get Presence Id Function */
  getPresenceId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? presenceId = prefs.getInt('presenceId');
    AppStatic.presenceId = presenceId ?? 0;
  }
}
