class GetDiscountsAll {
  String? search;
  int? size;
  int? page;
  String? sortBy;

  GetDiscountsAll({this.search, this.size, this.page, this.sortBy});

  GetDiscountsAll.fromJson(Map<String, dynamic> json) {
    search = json['search'];
    size = json['size'];
    page = json['page'];
    sortBy = json['sortBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['search'] = this.search;
    data['size'] = this.size;
    data['page'] = this.page;
    data['sortBy'] = this.sortBy;
    return data;
  }
}

class GetDiscountByManager {
  String? search;
  int? size;
  int? page;
  int? subBranchId;
  String? sortBy;

  GetDiscountByManager(
      {this.search, this.size, this.page, this.subBranchId, this.sortBy});

  GetDiscountByManager.fromJson(Map<String, dynamic> json) {
    search = json['search'];
    size = json['size'];
    page = json['page'];
    subBranchId = json['subBranchId'];
    sortBy = json['sortBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['search'] = this.search;
    data['size'] = this.size;
    data['page'] = this.page;
    data['subBranchId'] = this.subBranchId;
    data['sortBy'] = this.sortBy;
    return data;
  }
}

class GetDiscountByAdmin {
  String? search;
  int? size;
  int? page;
  int? branchId;
  int? subBranchId;
  String? sortBy;

  GetDiscountByAdmin(
      {this.search,
      this.size,
      this.page,
      this.branchId,
      this.subBranchId,
      this.sortBy});

  GetDiscountByAdmin.fromJson(Map<String, dynamic> json) {
    search = json['search'];
    size = json['size'];
    page = json['page'];
    branchId = json['branchId'];
    subBranchId = json['subBranchId'];
    sortBy = json['sortBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['search'] = this.search;
    data['size'] = this.size;
    data['page'] = this.page;
    data['branchId'] = this.branchId;
    data['subBranchId'] = this.subBranchId;
    data['sortBy'] = this.sortBy;
    return data;
  }
}

class GetDiscountJustBranch {
  String? search;
  int? size;
  int? page;
  int? branchId;
  String? sortBy;

  GetDiscountJustBranch(
      {this.search, this.size, this.page, this.branchId, this.sortBy});

  GetDiscountJustBranch.fromJson(Map<String, dynamic> json) {
    search = json['search'];
    size = json['size'];
    page = json['page'];
    branchId = json['branchId'];
    sortBy = json['sortBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['search'] = this.search;
    data['size'] = this.size;
    data['page'] = this.page;
    data['branchId'] = this.branchId;
    data['sortBy'] = this.sortBy;
    return data;
  }
}
