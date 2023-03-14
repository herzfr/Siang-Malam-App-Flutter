import 'package:siangmalam/models/branch/sub_branch.dart';

/* Created By Dwi Sutrisno */

class BranchDto {
  int? id;
  String? branchCode;
  String? name;
  String? description;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? latitude;
  String? longitude;
  int? tolerance;
  int? workingHour;
  List<SubBranchDto>? subBranch;

  BranchDto(
      {this.id,
      this.branchCode,
      this.name,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.latitude,
      this.longitude,
      this.subBranch,
      this.tolerance,
      this.workingHour});

  BranchDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    branchCode = json['branchCode'];
    name = json['name'];
    description = json['description'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    createdBy = json['createdBy'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    tolerance = json['tolerance'];
    workingHour = json['workingHour'];

    if (json['subBranch'] != null) {
      subBranch = <SubBranchDto>[];
      json['subBranch'].forEach((v) {
        subBranch!.add(SubBranchDto.fromJson(v));
      });
    }
    // subBranch = json['subBranch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['branchCode'] = branchCode;
    data['name'] = name;
    data['description'] = description;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['createdBy'] = createdBy;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['sub_branch'] = subBranch;
    data['tolerance'] = tolerance;
    data['workingHour'] = workingHour;
    return data;
  }
}

class BranchData {
  int? id;
  String? name;
  String? description;
  double latitude;
  double longitude;
  int? tolerance;
  int? workingHour;
  bool? isBranch;

  BranchData.set(this.id, this.name, this.description, this.latitude,
      this.longitude, this.tolerance, this.workingHour, this.isBranch);

  @override
  String toString() {
    return 'BranchData{id: $id, name: $name, description: $description, latitude: $latitude, longitude: $longitude, tolerance: $tolerance, workingHour: $workingHour, isBranch: $isBranch}';
  }



}
