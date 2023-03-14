import 'package:siangmalam/models/pageable.dart';

class GeneralBranch {
  List<ListBranch>? listbranch;
  Pageable? pageable;

  GeneralBranch({this.listbranch, this.pageable});

  GeneralBranch.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      listbranch = <ListBranch>[];
      json['content'].forEach((v) {
        listbranch!.add(ListBranch.fromJson(v));
      });
    }
    pageable = json['pageable'] != null
        ? Pageable.fromJson(json['pageable'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listbranch != null) {
      data['content'] = this.listbranch!.map((v) => v.toJson()).toList();
    }
    if (this.pageable != null) {
      data['pageable'] = this.pageable!.toJson();
    }
    return data;
  }
}

class ListBranch {
  int? id;
  String? branchCode;
  String? name;
  String? description;
  String? createdAt;
  String? updatedAt;
  String? createdBy;

  ListBranch(
      {this.id,
      this.branchCode,
      this.name,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.createdBy});

  ListBranch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    branchCode = json['branchCode'];
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
    data['name'] = this.name;
    data['description'] = this.description;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['createdBy'] = this.createdBy;
    return data;
  }
}
