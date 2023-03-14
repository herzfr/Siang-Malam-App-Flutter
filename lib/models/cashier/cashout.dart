class CashOutEmpl {
  String? username;
  int? amount;
  int? branchId;
  int? subBranchId;
  int? shiftId;

  CashOutEmpl(
      {this.username,
      this.amount,
      this.branchId,
      this.subBranchId,
      this.shiftId});

  CashOutEmpl.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    amount = json['amount'];
    branchId = json['branchId'];
    subBranchId = json['subBranchId'];
    shiftId = json['shiftId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['amount'] = this.amount;
    data['branchId'] = this.branchId;
    data['subBranchId'] = this.subBranchId;
    data['shiftId'] = this.shiftId;
    return data;
  }
}
