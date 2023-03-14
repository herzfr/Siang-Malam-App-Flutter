import 'package:siangmalam/models/pageable.dart';

class GetCashbonFilter {
  int? size;
  int? page;
  String? search;
  int? startDate;
  int? endDate;
  String? option;
  int? branchId;
  int? subBranchId;

  GetCashbonFilter(
      {this.size,
      this.page,
      this.search,
      this.startDate,
      this.endDate,
      this.option,
      this.branchId,
      this.subBranchId});

  GetCashbonFilter.fromJson(Map<String, dynamic> json) {
    size = json['size'];
    page = json['page'];
    search = json['search'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    option = json['option'];
    branchId = json['branchId'];
    subBranchId = json['subBranchId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['size'] = this.size;
    data['page'] = this.page;
    data['search'] = this.search;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['option'] = this.option;
    data['branchId'] = this.branchId;
    data['subBranchId'] = this.subBranchId;
    return data;
  }
}

class CashbonList {
  List<Cashbon>? cashbonlist;
  Pageable? pageable;

  CashbonList({this.cashbonlist, this.pageable});

  CashbonList.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      cashbonlist = <Cashbon>[];
      json['content'].forEach((v) {
        cashbonlist!.add(new Cashbon.fromJson(v));
      });
    }
    pageable = json['pageable'] != null
        ? new Pageable.fromJson(json['pageable'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cashbonlist != null) {
      data['content'] = this.cashbonlist!.map((v) => v.toJson()).toList();
    }
    if (this.pageable != null) {
      data['pageable'] = this.pageable!.toJson();
    }
    return data;
  }
}

class Cashbon {
  int? id;
  String? username;
  String? name;
  String? type;
  int? amount;
  int? createdAt;
  int? updatedAt;
  int? salesId;
  int? branchId;
  int? subBranchId;
  String? status;

  Cashbon(
      {this.id,
      this.username,
      this.name,
      this.type,
      this.amount,
      this.createdAt,
      this.updatedAt,
      this.salesId,
      this.branchId,
      this.subBranchId,
      this.status});

  Cashbon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    name = json['name'];
    type = json['type'];
    amount = json['amount'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    salesId = json['salesId'];
    branchId = json['branchId'];
    subBranchId = json['subBranchId'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['name'] = this.name;
    data['type'] = this.type;
    data['amount'] = this.amount;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['salesId'] = this.salesId;
    data['branchId'] = this.branchId;
    data['subBranchId'] = this.subBranchId;
    data['status'] = this.status;
    return data;
  }
}

class DownloadReportCashbon {
  String? search;
  int? startDate;
  int? endDate;
  int? branchId;
  int? subBranchId;

  DownloadReportCashbon(
      {this.search,
      this.startDate,
      this.endDate,
      this.branchId,
      this.subBranchId});

  DownloadReportCashbon.fromJson(Map<String, dynamic> json) {
    search = json['search'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    branchId = json['branchId'];
    subBranchId = json['subBranchId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['search'] = this.search;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['branchId'] = this.branchId;
    data['subBranchId'] = this.subBranchId;
    return data;
  }
}
