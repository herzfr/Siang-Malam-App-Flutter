class SubBranchDto {
  int? id;
  String? branchCode;
  int? parentId;
  String? name;
  String? description;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? latitude;
  String? longitude;
  int? tolerance;
  int? workingHour;

  SubBranchDto(
      {this.id,
      this.branchCode,
      this.parentId,
      this.name,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.latitude,
      this.longitude,
      this.tolerance,
      this.workingHour});

  SubBranchDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    branchCode = json['branchCode'];
    parentId = json['parentId'];
    name = json['name'];
    description = json['description'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    createdBy = json['createdBy'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    tolerance = json['tolerance'];
    workingHour = json['workingHour'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['branchCode'] = branchCode;
    data['parentId'] = parentId;
    data['name'] = name;
    data['description'] = description;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['createdBy'] = createdBy;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['tolerance'] = tolerance;
    data['workingHour'] = workingHour;
    return data;
  }
}
