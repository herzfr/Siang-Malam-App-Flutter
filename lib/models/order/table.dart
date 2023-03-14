import 'package:siangmalam/models/pageable.dart';

class TableModel {
  List<ListTable>? listTable;
  Pageable? pageable;

  TableModel({this.listTable, this.pageable});

  TableModel.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      listTable = <ListTable>[];
      json['content'].forEach((v) {
        listTable!.add(new ListTable.fromJson(v));
      });
    }
    pageable = json['pageable'] != null
        ? new Pageable.fromJson(json['pageable'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listTable != null) {
      data['content'] = this.listTable!.map((v) => v.toJson()).toList();
    }
    if (this.pageable != null) {
      data['pageable'] = this.pageable!.toJson();
    }
    return data;
  }
}

class ListTable {
  int? id;
  int? branchId;
  int? subBranchId;
  String? name;
  String? description;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;
  int? salesId;
  bool? isOccupied;
  int? capacity;

  ListTable(
      {this.id,
      this.branchId,
      this.subBranchId,
      this.name,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy,
      this.salesId,
      this.isOccupied,
      this.capacity});

  ListTable.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    branchId = json['branchId'];
    subBranchId = json['subBranchId'];
    name = json['name'];
    description = json['description'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    salesId = json['salesId'];
    isOccupied = json['isOccupied'];
    capacity = json['capacity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['branchId'] = this.branchId;
    data['subBranchId'] = this.subBranchId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    data['salesId'] = this.salesId;
    data['isOccupied'] = this.isOccupied;
    data['capacity'] = this.capacity;
    return data;
  }
}
