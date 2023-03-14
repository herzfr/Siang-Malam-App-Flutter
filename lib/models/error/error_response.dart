import 'package:siangmalam/models/general_response.dart';

/* Created By Dwi Sutrisno */

class ErrorResponse extends GeneralResponse {
  ErrorResponse({statusCode, message});

  ErrorResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
  }

}
