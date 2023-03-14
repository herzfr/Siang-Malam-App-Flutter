import 'package:siangmalam/models/branch.dart';
import 'package:siangmalam/models/sub_branch.dart';

class UserDto {
  String? id;
  String? username;
  String? firstName;
  String? lastName;
  String? lastLogin;
  String? picture;
  String? role;
  int? branchId;
  String? branch;
  Branch? branchData;
  List<SubBranch>? subBranch;
  String? level;
  int? subBranchId;
  bool? isHasCheckIn;
  bool? isHasCheckOut;

  UserDto(
      {this.id,
      this.username,
      this.firstName,
      this.lastName,
      this.lastLogin,
      this.picture,
      this.role,
      this.branchId,
      this.branch,
      this.branchData,
      this.subBranch,
      this.level,
      this.subBranchId,
      this.isHasCheckIn,
      this.isHasCheckOut});

  UserDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    lastLogin = json['lastLogin'];
    picture = json['picture'];
    role = json['role'];
    branchId = json['branchId'];
    branch = json['branch'];

    if (json['branchData'] != null) {
      branchData = Branch.fromJson(json['branchData']);
    }

    if (json['subBranch'] != null) {
      subBranch = <SubBranch>[];
      json['subBranch'].forEach((v) {
        subBranch!.add(SubBranch.fromJson(v));
      });
    }
    level = json['level'];
    subBranchId = json['subBranchId'];
    isHasCheckIn = json['isHasCheckIn'];
    isHasCheckOut = json['isHasCheckOut'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['lastLogin'] = lastLogin;
    data['picture'] = picture;
    data['role'] = role;
    data['branchId'] = branchId;
    data['branch'] = branch;
    data['branchData'] = branchData;
    if (subBranch != null) {
      data['subBranch'] = subBranch!.map((v) => v.toJson()).toList();
    }
    data['level'] = level;
    data['subBranchId'] = subBranchId;
    data['isHasCheckIn'] = isHasCheckIn;
    data['isHasCheckOut'] = isHasCheckOut;
    return data;
  }


  @override
  String toString() {
    return 'UserDto{id: $id, username: $username, firstName: $firstName, lastName: $lastName, lastLogin: $lastLogin, picture: $picture, role: $role, branchId: $branchId, branch: $branch, branchData: $branchData, subBranch: $subBranch, level: $level, subBranchId: $subBranchId, isHasCheckIn: $isHasCheckIn, isHasCheckOut: $isHasCheckOut}';
  }

  get getId => id;
  set setId(id) => id = id;
  get getUsername => username;
  set setUsername(username) => username = username;
  get getFirstName => firstName;
  set setFirstName(firstName) => firstName = firstName;
  get getLastName => lastName;
  set setLastName(lastName) => lastName = lastName;
  get getLastLogin => lastLogin;
  set setLastLogin(lastLogin) => lastLogin = lastLogin;
  get getPicture => picture;
  set setPicture(picture) => picture = picture;
  get getRole => role;
  set setRole(role) => role = role;
  get getBranchId => branchId;
  set setBranchId(branchId) => branchId = branchId;
  get getBranch => branch;
  set setBranch(branch) => branch = branch;
  get getSubBranch => subBranch;
  set setSubBranch(subBranch) => subBranch = subBranch;
  get getLevel => level;
  set setLevel(level) => level = level;
  get getSubBranchId => subBranchId;
  set setSubBranchId(subBranchId) => subBranchId = subBranchId;
}
