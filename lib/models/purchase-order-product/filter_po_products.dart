class FilterPoProduct {
  int? size;
  int? page;
  String? search;
  String? startDate;
  String? endDate;
  String? status;
  int? branchId;
  int? subBranchId;
  String? option;
  String? sortBy;
  String? orderBy;

  FilterPoProduct(
      {this.size,
      this.page,
      this.search,
      this.startDate,
      this.endDate,
      this.status,
      this.branchId,
      this.subBranchId,
      this.option,
      this.sortBy,
      this.orderBy});

  FilterPoProduct.fromJson(Map<String, dynamic> json) {
    size = json['size'];
    page = json['page'];
    search = json['search'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    status = json['status'];
    branchId = json['branchId'];
    subBranchId = json['subBranchId'];
    option = json['option'];
    sortBy = json['sortBy'];
    orderBy = json['orderBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['size'] = this.size;
    data['page'] = this.page;
    data['search'] = this.search;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['status'] = this.status;
    data['branchId'] = this.branchId;
    data['subBranchId'] = this.subBranchId;
    data['option'] = this.option;
    data['sortBy'] = this.sortBy;
    data['orderBy'] = this.orderBy;
    return data;
  }

  @override
  String toString() {
    return 'FilterPoProduct{size: $size, page: $page, search: $search, startDate: $startDate, endDate: $endDate, status: $status, branchId: $branchId, subBranchId: $subBranchId, option: $option, sortBy: $sortBy, orderBy: $orderBy}';
  }
}
