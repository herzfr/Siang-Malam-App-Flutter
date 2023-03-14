class StockItemOutFilter {
  int? size;
  int? page;
  String? search;
  String? startDate;
  String? endDate;
  int? branchId;
  int? subBranchId;
  String? sortBy;

  StockItemOutFilter(
      {this.size,
      this.page,
      this.search,
      this.startDate,
      this.endDate,
      this.branchId,
      this.subBranchId,
      this.sortBy});

  StockItemOutFilter.fromJson(Map<String, dynamic> json) {
    size = json['size'];
    page = json['page'];
    search = json['search'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    branchId = json['branchId'];
    subBranchId = json['subBranchId'];
    sortBy = json['sortBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['size'] = this.size;
    data['page'] = this.page;
    data['search'] = this.search;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['branchId'] = this.branchId;
    data['subBranchId'] = this.subBranchId;
    data['sortBy'] = this.sortBy;
    return data;
  }
}
