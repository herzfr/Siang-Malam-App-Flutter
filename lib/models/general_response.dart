// import 'package:logger/logger.dart';

class GeneralResponse {
  int? statusCode;
  String? message;
  dynamic data;
  String? error;

  GeneralResponse({this.statusCode, this.message, this.data, this.error});

  GeneralResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    // var log = Logger();
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['message'] = message;
    data['error'] = error;
    // log.d(data);
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }

    return data;
  }

  @override
  String toString() {
    return 'GeneralResponse{statusCode: $statusCode, message: $message, data: ${data.toString()}}';
  }
}
