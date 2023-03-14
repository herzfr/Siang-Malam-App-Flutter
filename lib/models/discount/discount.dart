class Discount {
  ListDiscount? data;

  Discount({this.data});

  Discount.fromJson(Map<String, dynamic> json) {
    data =
        json['data'] != null ? new ListDiscount.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ListDiscount {
  int? id;
  String? name;
  String? description;
  String? type;
  double? value;
  String? createdAt;
  String? updatedAt;
  String? createdby;
  String? updatedBy;
  int? branchId;
  int? subBranchId;

  ListDiscount(
      {this.id,
      this.name,
      this.description,
      this.type,
      this.value,
      this.createdAt,
      this.updatedAt,
      this.createdby,
      this.updatedBy,
      this.branchId,
      this.subBranchId});

  ListDiscount.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    type = json['type'];
    value = json['value'] is int
        ? (json['value'] as int).toDouble()
        : json['value'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    createdby = json['createdby'];
    updatedBy = json['updatedBy'];
    branchId = json['branchId'];
    subBranchId = json['subBranchId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['type'] = this.type;
    data['value'] = this.value;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['createdby'] = this.createdby;
    data['updatedBy'] = this.updatedBy;
    data['branchId'] = this.branchId;
    data['subBranchId'] = this.subBranchId;
    return data;
  }
}
