class GetOrder {
  int? size;
  int? page;
  String? search;
  int? branchId;
  int? subBranchId;
  String? option;
  int? startDate;
  int? endDate;

  GetOrder(
      {this.size,
      this.page,
      this.search,
      this.branchId,
      this.subBranchId,
      this.option,
      this.startDate,
      this.endDate});

  GetOrder.fromJson(Map<String, dynamic> json) {
    size = json['size'];
    page = json['page'];
    search = json['search'];
    branchId = json['branchId'];
    subBranchId = json['subBranchId'];
    option = json['option'];
    startDate = json['startDate'];
    endDate = json['endDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['size'] = this.size;
    data['page'] = this.page;
    data['search'] = this.search;
    data['branchId'] = this.branchId;
    data['subBranchId'] = this.subBranchId;
    data['option'] = this.option;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    return data;
  }
}
