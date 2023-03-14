import 'package:dio/dio.dart';
import 'package:siangmalam/models/error/error_response.dart';

class DioExceptions implements Exception {
  String message = '';

  fromDioError(DioError dioError) {
    // print("error type : ${dioError.type}");
    switch (dioError.type) {
      case DioErrorType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioErrorType.connectTimeout:
        message = "Connection timeout with API server";
        break;
      case DioErrorType.other:
        message = "Connection to API server failed due to internet connection";
        break;
      case DioErrorType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioErrorType.response:
        if (dioError.response!.data != null) {
          var httpStatusCode = dioError.response!.statusCode ?? 200;
          if (httpStatusCode > 500) {
            message = "Ooops something went wrong";
          } else {
            var data = ErrorResponse.fromJson(dioError.response!.data);
            message = data.message!;
          }
        } else {
          message = 'Oops something went wrong';
        }
        break;
      case DioErrorType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      default:
        message = "Something went wrong";
        break;
    }

    return message;
  }
}
