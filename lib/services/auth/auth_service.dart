import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/route_manager.dart';
import 'package:siangmalam/models/user.dart';
import 'package:siangmalam/commons/dio_http.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/values.dart';
import 'package:siangmalam/constans/url_values.dart';
import 'package:siangmalam/services/app_static.dart';
import 'package:siangmalam/models/general_response.dart';
import 'package:siangmalam/commons/routes/routes_name.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siangmalam/models/attendance/presence_status.dart';

/* Created By Dwi Sutrisno */

class AuthService {
  /* Send Request Login */
  static Future<void> sendLogin(String username, String password) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.post(loginUrl, data: {"username": username, "password": password});

      var generalResponse = GeneralResponse.fromJson(response.data);
      var userData = UserDto.fromJson(generalResponse.data);
      //set user data ke dalam shared preferences
      AppStatic.userData = userData;
      setUserData(userData);

      //tampilkan halaman home
      Get.offAllNamed(RouteName.dashboardScreen);
    } on DioError catch (error) {
      // EasyLoading.dismiss();
      var generalResponse = GeneralResponse.fromJson(error.response?.data);
      String? errMessage = generalResponse.message ?? errorHappen;
      Get.snackbar(
        "Login Failed",
        errMessage,
        backgroundColor: mtRed600,
        colorText: mtGrey50,
        animationDuration: const Duration(milliseconds: 500),
        duration: const Duration(seconds: 2),
      );
    } catch (error) {
      Get.snackbar(
        "Login Failed",
        error.toString(),
        backgroundColor: mtRed600,
        colorText: mtGrey50,
        animationDuration: const Duration(milliseconds: 500),
        duration: const Duration(seconds: 2),
      );
    }
  }

  /* Send Refresh Auth Request  */
  static Future sendRefresh() async {
    Response response;
    // var cookieJar = CookieJar();
    Dio dio = await DioConfig.getDio();
    DioConfig.cookiejar.loadForRequest(Uri.parse(serverHost));

    try {
      response = await dio.post(refreshUrl, data: {});

      if (response.statusCode == 200) {
        var generalResponse = GeneralResponse.fromJson(response.data);
        var userData = UserDto.fromJson(generalResponse.data);
        //set user data ke dalam shared preferences
        setUserData(userData);
        // print("userData ${userData.toJson().toString()}");
        return true;
      } else {
        throw Error();
      }
    } on DioError catch (error) {
      var generalResponse = GeneralResponse.fromJson(error.response?.data);
      String? errMessage = generalResponse.message ?? errorHappen;
      Get.snackbar("Error", errMessage, backgroundColor: mtRed600, colorText: textColor);
      return false;
    } catch (error) {
      Get.snackbar("Error", error.toString(), backgroundColor: mtRed600, colorText: textColor);
      return false;
    }
  }

  /* Send Refresh Auth Request  */
  static Future sendApiTest() async {
    Response response;
    // var cookieJar = CookieJar();
    Dio dio = await DioConfig.getDio();
    DioConfig.cookiejar.loadForRequest(Uri.parse(serverHost));
    Get.snackbar("Test", "Koneksi Internet: $refreshUrl", backgroundColor: mtBlue300, colorText: textColor);

    try {
      response = await dio.post(refreshUrl, data: {});

      if (response.statusCode == 200) {
        var generalResponse = GeneralResponse.fromJson(response.data);
        var userData = UserDto.fromJson(generalResponse.data);
        //set user data ke dalam shared preferences
        setUserData(userData);
        // print("userData ${userData.toJson().toString()}");

        Get.snackbar("Hasil", "Koneksi Internet: $generalResponse", backgroundColor: mtBlue300, colorText: textColor);
        return true;
      } else {
        throw Error();
      }
    } on DioError catch (error) {
      var generalResponse = GeneralResponse.fromJson(error.response?.data);
      String? errMessage = generalResponse.message ?? errorHappen;
      Get.snackbar("Error", errMessage, backgroundColor: mtRed600, colorText: textColor);
      return false;
    } catch (error) {
      Get.snackbar("Error", error.toString(), backgroundColor: mtRed600, colorText: textColor);
      return false;
    }
  }

  /* Set User To SharedPreferences */
  static Future setUserData(UserDto userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', jsonEncode(userData));
    await prefs.setBool('isHasCheckIn', userData.isHasCheckIn ?? false);
    await prefs.setBool('isHasCheckOut', userData.isHasCheckOut ?? false);

    AppStatic.userData = userData;
    AppStatic.userPresenceStatus = PresenceStatusDto(
        presenceId: 0, isHashCheckIn: userData.isHasCheckIn ?? false, isHasCheckout: userData.isHasCheckOut ?? false, date: '', checkInTime: 0);
  }

  /* Get User Data From Shared Preferences */
  static Future<UserDto?> getUserData() async {
    //initialize preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //get pref from key 'user'
    String? userData = prefs.getString('user');
    //if userData is not empty return UserDto value
    if (userData != null) {
      //initialize userDto properties
      UserDto user = UserDto.fromJson(jsonDecode(userData));
      AppStatic.userData = user;
      return user;
    } else {
      return null;
    }
  }
}
