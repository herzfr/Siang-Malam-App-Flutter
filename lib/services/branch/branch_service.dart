import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
// import 'package:logger/logger.dart';
import 'package:siangmalam/commons/dio_http.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/url_values.dart';
import 'package:siangmalam/constans/values.dart';
import 'package:siangmalam/models/branch/branch.dart';
import 'package:siangmalam/models/branch/general_branch.dart';
import 'package:siangmalam/models/branch/sub_branch.dart';
import 'package:siangmalam/models/general_response.dart';
// import 'package:siangmalam/models/sub_branch.dart';
import 'package:siangmalam/models/subbranch/general_sub_branch.dart';

/* Created By Dwi Sutrisno */

class BranchService {
  /* Get Branch Data Function */
  static Future getBranchData() async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.get(getBranchDataUrl);

      if (response.statusCode == 200) {
        var generalResponse = GeneralResponse.fromJson(response.data);
        BranchDto branchDto = BranchDto.fromJson(generalResponse.data);
        return branchDto;
      } else {
        throw Error();
      }
    } on DioError catch (error) {
      var generalResponse = GeneralResponse.fromJson(error.response?.data);
      String? errMessage = generalResponse.message ?? errorHappen;
      Get.snackbar(errorLabel, errMessage,
          backgroundColor: mtRed600, colorText: textColor);
      return Future.error(errMessage);
    } catch (error) {
      Get.snackbar(errorLabel, error.toString(),
          backgroundColor: mtRed600, colorText: textColor);
      return Future.error('Error');
    }
  }

  /* Get SubBranch Data Function */
  static Future getSubBranchData() async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.get(getSubBranchDataUrl);

      if (response.statusCode == 200) {
        var generalResponse = GeneralResponse.fromJson(response.data);
        List<SubBranchDto> subBranchData = [];

        for (var item in generalResponse.data) {
          SubBranchDto branchDto = SubBranchDto.fromJson(item);
          subBranchData.add(branchDto);
        }

        return subBranchData;
      } else {
        throw Error();
      }
    } on DioError catch (error) {
      var generalResponse = GeneralResponse.fromJson(error.response?.data);
      String? errMessage = generalResponse.message ?? errorHappen;
      Get.snackbar(errorLabel, errMessage,
          backgroundColor: mtRed600, colorText: textColor);
      return Future.error(errMessage);
    } catch (error) {
      Get.snackbar(errorLabel, error.toString(),
          backgroundColor: mtRed600, colorText: textColor);
      return Future.error('Error');
    }
  }

  /* Get SubBranch Data Function By Id */
  static Future<GeneralBranch> getAllDataBranch() async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.get(branchUrl);

      if (response.statusCode == 200) {
        var generalResponse = GeneralResponse.fromJson(response.data);
        GeneralBranch branch = GeneralBranch.fromJson(generalResponse.data);
        return branch;
      } else {
        throw Error();
      }
    } on DioError catch (error) {
      var generalResponse = GeneralResponse.fromJson(error.response?.data);
      String? errMessage = generalResponse.message ?? errorHappen;
      Get.snackbar(errorLabel, errMessage,
          backgroundColor: mtRed600, colorText: textColor);
      return Future.error(errMessage);
    } catch (error) {
      Get.snackbar(errorLabel, error.toString(),
          backgroundColor: mtRed600, colorText: textColor);
      return Future.error('Error');
    }
  }

  /* Get SubBranch Data Function By Id */
  static Future<GeneralSubBranch> getSubBranchDataByBranchId(int id) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.get(subbranchhUrl + '/byparent/' + id.toString());

      if (response.statusCode == 200) {
        var generalResponse = GeneralResponse.fromJson(response.data);
        GeneralSubBranch subbranch =
            GeneralSubBranch.fromJson(generalResponse.data);
        return subbranch;
      } else {
        throw Error();
      }
    } on DioError catch (error) {
      var generalResponse = GeneralResponse.fromJson(error.response?.data);
      String? errMessage = generalResponse.message ?? errorHappen;
      Get.snackbar(errorLabel, errMessage,
          backgroundColor: mtRed600, colorText: textColor);
      return Future.error(errMessage);
    } catch (error) {
      Get.snackbar(errorLabel, error.toString(),
          backgroundColor: mtRed600, colorText: textColor);
      return Future.error('Error');
    }
  }
}
