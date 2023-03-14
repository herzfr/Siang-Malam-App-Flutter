import 'package:siangmalam/models/pageable.dart';

class GeneralSubBranch {
  List<ListSubBranch>? listsubbranch;
  Pageable? pageable;

  GeneralSubBranch({this.listsubbranch, this.pageable});

  GeneralSubBranch.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      listsubbranch = <ListSubBranch>[];
      json['content'].forEach((v) {
        listsubbranch!.add(new ListSubBranch.fromJson(v));
      });
    }
    pageable = json['pageable'] != null
        ? new Pageable.fromJson(json['pageable'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listsubbranch != null) {
      data['content'] = this.listsubbranch!.map((v) => v.toJson()).toList();
    }
    if (this.pageable != null) {
      data['pageable'] = this.pageable!.toJson();
    }
    return data;
  }
}

class ListSubBranch {
  int? id;
  String? branchCode;
  int? parentId;
  String? name;
  String? description;
  String? createdAt;
  String? updatedAt;
  String? createdBy;

  ListSubBranch(
      {this.id,
      this.branchCode,
      this.parentId,
      this.name,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.createdBy});

  ListSubBranch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    branchCode = json['branchCode'];
    parentId = json['parentId'];
    name = json['name'];
    description = json['description'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    createdBy = json['createdBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['branchCode'] = this.branchCode;
    data['parentId'] = this.parentId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['createdBy'] = this.createdBy;
    return data;
  }
}
