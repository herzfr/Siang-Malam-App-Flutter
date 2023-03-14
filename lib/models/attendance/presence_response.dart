/* Created By Dwi Sutrisno */
class PresenceResponse {
  int? id;
  String? userId;
  String? type;
  String? note;
  String? inlocation;
  String? inlatitude;
  String? inlongitude;
  int? distance;
  String? checkIn;
  String? checkOut;
  String? outLatitude;
  String? outLongitude;
  String? outLocation;
  int? workingTimes;
  String? createdAt;
  String? updatedAt;
  String? updatedBy;
  String? createdBy;
  int? outDistance;

  PresenceResponse(
      {this.id,
      this.userId,
      this.type,
      this.note,
      this.inlocation,
      this.inlatitude,
      this.inlongitude,
      this.distance,
      this.checkIn,
      this.checkOut,
      this.outLatitude,
      this.outLongitude,
      this.outLocation,
      this.workingTimes,
      this.createdAt,
      this.updatedAt,
      this.updatedBy,
      this.createdBy,
      this.outDistance});

  PresenceResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    type = json['type'];
    note = json['note'];
    inlocation = json['inlocation'];
    inlatitude = json['inlatitude'];
    inlongitude = json['inlongitude'];
    distance = json['distance'];
    checkIn = json['checkIn'];
    checkOut = json['checkOut'];
    outLatitude = json['outLatitude'];
    outLongitude = json['outLongitude'];
    outLocation = json['outLocation'];
    workingTimes = json['workingTimes'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    updatedBy = json['updatedBy'];
    createdBy = json['createdBy'];
    outDistance = json['outDistance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['type'] = type;
    data['note'] = note;
    data['inlocation'] = inlocation;
    data['inlatitude'] = inlatitude;
    data['inlongitude'] = inlongitude;
    data['distance'] = distance;
    data['checkIn'] = checkIn;
    data['checkOut'] = checkOut;
    data['outLatitude'] = outLatitude;
    data['outLongitude'] = outLongitude;
    data['outLocation'] = outLocation;
    data['workingTimes'] = workingTimes;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['updatedBy'] = updatedBy;
    data['createdBy'] = createdBy;
    data['outDistance'] = outDistance;
    return data;
  }

  @override
  String toString() {
    return 'PresenceResponse{id: $id, userId: $userId, type: $type, note: $note, inlocation: $inlocation, inlatitude: $inlatitude, inlongitude: $inlongitude, distance: $distance, checkIn: $checkIn, checkOut: $checkOut, outLatitude: $outLatitude, outLongitude: $outLongitude, outLocation: $outLocation, workingTimes: $workingTimes, createdAt: $createdAt, updatedAt: $updatedAt, updatedBy: $updatedBy, createdBy: $createdBy, outDistance: $outDistance}';
  }
}
