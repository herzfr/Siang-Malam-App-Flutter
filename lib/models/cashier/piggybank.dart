class AddFilterPiggy {
  int? branchId;
  int? subBranchId;
  int? shiftId;
  int? amount;

  AddFilterPiggy({this.branchId, this.subBranchId, this.shiftId, this.amount});

  AddFilterPiggy.fromJson(Map<String, dynamic> json) {
    branchId = json['branchId'];
    subBranchId = json['subBranchId'];
    shiftId = json['shiftId'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['branchId'] = this.branchId;
    data['subBranchId'] = this.subBranchId;
    data['shiftId'] = this.shiftId;
    data['amount'] = this.amount;
    return data;
  }
}

class ResponsePiggyBank {
  String? note;
  int? id;
  int? cost;
  int? shiftId;
  String? type;

  ResponsePiggyBank({this.note, this.id, this.cost, this.shiftId, this.type});

  ResponsePiggyBank.fromJson(Map<String, dynamic> json) {
    note = json['note'];
    id = json['id'];
    cost = json['cost'];
    shiftId = json['shiftId'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['note'] = this.note;
    data['id'] = this.id;
    data['cost'] = this.cost;
    data['shiftId'] = this.shiftId;
    data['type'] = this.type;
    return data;
  }
}

class PiggyBank {
  int? id;
  String? name;
  String? description;
  int? savingAmount;
  int? updatedAt;

  PiggyBank({this.id, this.name, this.description, this.savingAmount});

  PiggyBank.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    savingAmount = json['savingAmount'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['savingAmount'] = this.savingAmount;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class SubbranchSetSaving {
  int? subBranchId;
  int? amount;

  SubbranchSetSaving({this.subBranchId, this.amount});

  SubbranchSetSaving.fromJson(Map<String, dynamic> json) {
    subBranchId = json['subBranchId'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subBranchId'] = this.subBranchId;
    data['amount'] = this.amount;
    return data;
  }
}

class BranchSetSaving {
  int? branchId;
  int? amount;

  BranchSetSaving({this.branchId, this.amount});

  BranchSetSaving.fromJson(Map<String, dynamic> json) {
    branchId = json['branchId'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['branchId'] = this.branchId;
    data['amount'] = this.amount;
    return data;
  }
}
