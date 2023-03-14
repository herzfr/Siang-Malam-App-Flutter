class GeneralResponse2 {
  int? statusCode;
  String? message;
  dynamic data;
  String? error;

  GeneralResponse2({this.statusCode, this.message, this.data, this.error});

  GeneralResponse2.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['resultData'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['message'] = message;
    data['error'] = error;
    if (this.data != null) {
      data['resultData'] = this.data!.toJson();
    }

    return data;
  }

  @override
  String toString() {
    return 'GeneralResponse{statusCode: $statusCode, message: $message, data: ${data.toString()}}';
  }
}
