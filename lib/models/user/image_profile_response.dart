import 'package:siangmalam/models/general_response.dart';

class ImageProfileResponseDto extends GeneralResponse {
 
  ImageProfileResponseDto.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'];
  }


}
