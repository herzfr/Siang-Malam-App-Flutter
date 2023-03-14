import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siangmalam/commons/functions/dio_exception.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/commons/dio_http.dart';
import 'package:siangmalam/constans/url_values.dart';
import 'package:siangmalam/models/general_response.dart';
import 'package:siangmalam/models/user.dart';
import 'package:siangmalam/models/user/image_profile_request.dart';
import 'package:siangmalam/models/user/image_profile_response.dart';
import 'package:siangmalam/models/user/user_profile.dart';
import 'package:siangmalam/services/app_static.dart';
import 'package:siangmalam/widgets/snack_bar.dart';

/* Created By Dwi Sutrisno */

class UserService {
  //change profile request function
  Future<bool> changeUserImage(ImageProfileRequestDto file) async {
    Response response;
    Dio dio = await DioConfig.getDio();

    Map<String, String> headers = <String, String>{};
    headers.putIfAbsent("Content-Type", () => "multipart/form-data");

    FormData formData = FormData.fromMap(
      {
        "file": await MultipartFile.fromFile(
          file.filePath,
          filename: file.fileName,
          contentType: MediaType("image", "jpeg"),
        ),
      },
    );

    try {
      response = await dio.post(
        changeProfileImgUrl,
        data: formData,
        options: Options(headers: headers),
      );
      var generalResponse = ImageProfileResponseDto.fromJson(response.data);

      if (generalResponse.statusCode == 0) {
        Snackbar.show(
            "Sukses", "Ubah foto profil berhasil", primaryGreen, textColor);
        var data = generalResponse.data;

        if (data != null) {
          AppStatic.userData.picture = generalResponse.data;
        }

        return true;
      } else {
        return false;
      }
    } on DioError catch (error) {
      var message = DioExceptions().fromDioError(error);
      Snackbar.show("Ganti Profil Gagal", message, mtRed600, mtGrey50);
      return false;
    } catch (error) {
      Snackbar.show("Ganti Profil Gagal", "Oops something went wrong", mtRed600,
          mtGrey50);
      return false;
    }
  }

  //change password request function
  Future<void> changeUserPassword(String password, String rePassword) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.post(changePassUrl,
          data: {"password": password, "rePassword": rePassword});
      var generalResponse = GeneralResponse.fromJson(response.data);

      if (generalResponse.statusCode == 0) {
        Snackbar.showAndBack(
            "Sukses", "Ganti Sandi Berhasil", primaryGreen, textColor);
      }
    } on DioError catch (error) {
      var message = DioExceptions().fromDioError(error);
      Snackbar.show("Ganti Sandi Gagal", message, mtRed600, mtGrey50);
    } catch (error) {
      Snackbar.show(
          "Ganti Sandi Gagal", "Oops something went wrong", mtRed600, mtGrey50);
    }
  }

  /* Get User Profile Data Request Function */
  getUserProfile(String userId) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.get(getUserProfileUrl + userId);
      var generalResponse = GeneralResponse.fromJson(response.data);
      if (generalResponse.statusCode == 0) {
        var userProfile = UserProfileDto.fromJson(generalResponse.data);
        AppStatic.userProfile = userProfile;
      } else {
        throw Error();
      }
    } on DioError catch (error) {
      var message = DioExceptions().fromDioError(error);
      Snackbar.show("Error", message, mtRed600, mtGrey50);
    } catch (error) {
      Snackbar.show(
          "Error", "Gagal mendapatkan data profile", mtRed600, mtGrey50);
    }
  }

  /* Update UserProfile Data Request Function */
  Future<bool> updateUserProfile(UserProfileDto userProfile) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response =
          await dio.put(updateUserProfileUrl, data: userProfile.toJson());
      var generalResponse = GeneralResponse.fromJson(response.data);
      if (generalResponse.statusCode == 0) {
        setUserProfile(userProfile);
        Snackbar.showAndBack(
            "Sukses", "Update profile berhasil", primaryGreen, textColor);
        return true;
      } else {
        throw Error();
      }
    } on DioError catch (error) {
      var message = DioExceptions().fromDioError(error);
      Snackbar.show("Error", message, mtRed600, mtGrey50);
      return false;
    } catch (error) {
      Snackbar.show("Error", "Gagal update profile", mtRed600, mtGrey50);
      return false;
    }
  }

  /* Update UserProfile Data Request Function */
  static Future<UserDto> getUserById(String id) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.get(getUserByIdUrl + id);

      if (response.statusCode == 200) {
        var generalResponse = GeneralResponse.fromJson(response.data);
        UserDto user = UserDto.fromJson(generalResponse.data);
        return user;
      } else if (response.statusCode == 404) {
        Snackbar.show("ID Tidak Ada", "Id yang dicari tidak terdaftar",
            mtRed600, mtGrey50);
        return UserDto();
      } else {
        throw Error();
      }
    } on DioError catch (error) {
      // print(error);
      var message = DioExceptions().fromDioError(error);
      Snackbar.show("Error", "User Not Found", mtRed600, mtGrey50);
      return UserDto();
    } catch (error) {
      Snackbar.show("Error", "Gagal mengambil user", mtRed600, mtGrey50);
      return UserDto();
    }
  }

  /* Set User Profile To SharedPreferences */
  static Future setUserProfile(UserProfileDto userProfile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userProfile', jsonEncode(userProfile));
    AppStatic.userProfile = userProfile;
  }
}
