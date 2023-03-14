import 'package:siangmalam/models/pageable.dart';

class Expense {
  List<ListExpense>? content;
  Pageable? pageable;

  Expense({this.content, this.pageable});

  Expense.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = <ListExpense>[];
      json['content'].forEach((v) {
        content!.add(new ListExpense.fromJson(v));
      });
    }
    pageable = json['pageable'] != null
        ? new Pageable.fromJson(json['pageable'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.content != null) {
      data['content'] = this.content!.map((v) => v.toJson()).toList();
    }
    if (this.pageable != null) {
      data['pageable'] = this.pageable!.toJson();
    }
    return data;
  }
}

class ListExpense {
  int? id;
  String? note;
  String? pic;
  int? branchId;
  int? subBranchId;
  int? cost;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;
  String? type;

  ListExpense(
      {this.id,
      this.note,
      this.pic,
      this.branchId,
      this.subBranchId,
      this.cost,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy,
      this.type});

  ListExpense.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    note = json['note'];
    pic = json['pic'];
    branchId = json['branchId'];
    subBranchId = json['subBranchId'];
    cost = json['cost'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['note'] = this.note;
    data['pic'] = this.pic;
    data['branchId'] = this.branchId;
    data['subBranchId'] = this.subBranchId;
    data['cost'] = this.cost;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    data['type'] = this.type;
    return data;
  }
}
