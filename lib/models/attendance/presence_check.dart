/* Created By Dwi Sutrisno */
class PresenceCheckDto {
  int presenceId = 0;
  String? location;
  String? latitude;
  String? longitude;
  int? distance;
  String? note;
  int? workingTimes;

  PresenceCheckDto({
    this.location,
    this.latitude,
    this.longitude,
    this.distance,
    this.note,
    this.workingTimes,
  });

  PresenceCheckDto.fromJson(Map<String, dynamic> json) {
    presenceId = json['presenceId'];
    location = json['location'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    distance = json['distance'];
    note = json['note'];
    workingTimes = json['workingTimes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['presenceId'] = presenceId;
    data['location'] = location;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['distance'] = distance;
    data['note'] = note;
    data['workingTimes'] = workingTimes;
    return data;
  }

  @override
  String toString() {
    return 'PresenceCheckDto{presenceId: $presenceId, location: $location, latitude: $latitude, longitude: $longitude, distance: $distance, note: $note, workingHours: $workingTimes}';
  }
}
