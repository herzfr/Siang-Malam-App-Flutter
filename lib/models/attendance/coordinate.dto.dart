/* Created By Dwi Sutrisno */
class CoordinateDto {
  double? latitude;
  double? longitude;
  int? distanceTolerance;

  CoordinateDto({this.latitude, this.longitude, this.distanceTolerance});

  CoordinateDto.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    distanceTolerance = json['distanceTolerance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['distanceTolerance'] = distanceTolerance;
    return data;
  }
}
