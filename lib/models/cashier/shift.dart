import 'package:siangmalam/models/pageable.dart';

class ShifList {
  List<ShiftObj>? allShiftList;
  Pageable? pageable;

  ShifList({this.allShiftList, this.pageable});

  ShifList.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      allShiftList = <ShiftObj>[];
      json['content'].forEach((v) {
        allShiftList!.add(new ShiftObj.fromJson(v));
      });
    }
    pageable = json['pageable'] != null
        ? new Pageable.fromJson(json['pageable'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.allShiftList != null) {
      data['content'] = this.allShiftList!.map((v) => v.toJson()).toList();
    }
    if (this.pageable != null) {
      data['pageable'] = this.pageable!.toJson();
    }
    return data;
  }
}

class ShiftObj {
  int? id;
  String? username;
  String? name;
  int? startCash;
  int? salesCash;
  int? startOperationalCash;
  String? startTime;
  String? endTime;
  String? status;
  int? totalOrder;
  int? branchid;
  int? subBranchId;
  String? deviceId;
  int? endCash;
  int? endOperationalCash;

  ShiftObj(
      {this.id,
      this.username,
      this.name,
      this.startCash,
      this.salesCash,
      this.startOperationalCash,
      this.startTime,
      this.endTime,
      this.status,
      this.totalOrder,
      this.branchid,
      this.subBranchId,
      this.deviceId,
      this.endCash,
      this.endOperationalCash});

  ShiftObj.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    name = json['name'];
    startCash = json['startCash'];
    salesCash = json['salesCash'];
    startOperationalCash = json['startOperationalCash'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    status = json['status'];
    totalOrder = json['totalOrder'];
    branchid = json['branchid'];
    subBranchId = json['subBranchId'];
    deviceId = json['deviceId'];
    endCash = json['endCash'];
    endOperationalCash = json['endOperationalCash'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['name'] = this.name;
    data['startCash'] = this.startCash;
    data['salesCash'] = this.salesCash;
    data['startOperationalCash'] = this.startOperationalCash;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['status'] = this.status;
    data['totalOrder'] = this.totalOrder;
    data['branchid'] = this.branchid;
    data['subBranchId'] = this.subBranchId;
    data['deviceId'] = this.deviceId;
    data['endCash'] = this.endCash;
    data['endOperationalCash'] = this.endOperationalCash;
    return data;
  }
}

class StartShift {
  int? startCash;
  int? startOperationalCash;
  int? subBranchId;
  String? deviceId;

  StartShift(
      {this.startCash,
      this.startOperationalCash,
      this.subBranchId,
      this.deviceId});

  StartShift.fromJson(Map<String, dynamic> json) {
    startCash = json['startCash'];
    startOperationalCash = json['startOperationalCash'];
    subBranchId = json['subBranchId'];
    deviceId = json['deviceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['startCash'] = this.startCash;
    data['startOperationalCash'] = this.startOperationalCash;
    data['subBranchId'] = this.subBranchId;
    data['deviceId'] = this.deviceId;
    return data;
  }
}

class CheckShift {
  int? branchId;
  int? subBranchId;

  CheckShift({this.branchId, this.subBranchId});

  CheckShift.fromJson(Map<String, dynamic> json) {
    branchId = json['branchId'];
    subBranchId = json['subBranchId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['branchId'] = this.branchId;
    data['subBranchId'] = this.subBranchId;
    return data;
  }
}

class StopShift {
  int? id;

  StopShift({this.id});

  StopShift.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}

class GetShift {
  int? size;
  int? page;
  int? branchId;
  int? subBranchId;
  String? status;
  int? startDate;
  int? endDate;

  GetShift(
      {this.size,
      this.page,
      this.branchId,
      this.subBranchId,
      this.status,
      this.startDate,
      this.endDate});

  GetShift.fromJson(Map<String, dynamic> json) {
    size = json['size'];
    page = json['page'];
    branchId = json['branchId'];
    subBranchId = json['subBranchId'];
    status = json['status'];
    startDate = json['startDate'];
    endDate = json['endDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['size'] = this.size;
    data['page'] = this.page;
    data['branchId'] = this.branchId;
    data['subBranchId'] = this.subBranchId;
    data['status'] = this.status;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    return data;
  }
}

class UpdateCashShift {
  int? id;
  int? amount;
  String? deviceId;

  UpdateCashShift({this.id, this.amount, this.deviceId});

  UpdateCashShift.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    deviceId = json['deviceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['amount'] = this.amount;
    data['deviceId'] = this.deviceId;
    return data;
  }
}
