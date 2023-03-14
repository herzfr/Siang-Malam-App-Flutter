class TableFilter {
  String? search;
  int? size;
  int? page;
  int? branchId;
  int? subBranchId;

  TableFilter(
      {this.search, this.size, this.page, this.branchId, this.subBranchId});

  TableFilter.fromJson(Map<String, dynamic> json) {
    search = json['search'];
    size = json['size'];
    page = json['page'];
    branchId = json['branchId'];
    subBranchId = json['subBranchId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['search'] = this.search;
    data['size'] = this.size;
    data['page'] = this.page;
    data['branchId'] = this.branchId;
    data['subBranchId'] = this.subBranchId;
    return data;
  }
}
