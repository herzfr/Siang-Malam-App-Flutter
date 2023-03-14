class SubBranch {
  int? id;
  String? name;
  String? latitude;
  String? longitude; 

  SubBranch({this.id, this.name, this.latitude, this.longitude});

  SubBranch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }

  @override
  String toString() {
    return 'SubBranch{id: $id, name: $name, latitude: $latitude, longitude: $longitude}';
  }
}
