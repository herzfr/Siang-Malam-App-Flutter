class CurrentDeviceLocation {
  double? lat;
  double? long;

  CurrentDeviceLocation({
    this.lat,
    this.long,
  });

  CurrentDeviceLocation.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    long = json['long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['long'] = long;
    return data;
  }
}
