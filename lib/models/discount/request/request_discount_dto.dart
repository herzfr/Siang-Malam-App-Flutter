class DiscountCreateDto {
  String? name;
  String? description;
  String? type;
  double? value;
  int? branchId;
  int? subBranchId;

  DiscountCreateDto(
      {this.name,
      this.description,
      this.type,
      this.value,
      this.branchId,
      this.subBranchId});

  DiscountCreateDto.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    type = json['type'];
    value = json['value'];
    branchId = json['branchId'];
    subBranchId = json['subBranchId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['type'] = this.type;
    data['value'] = this.value;
    data['branchId'] = this.branchId;
    data['subBranchId'] = this.subBranchId;
    return data;
  }
}

class DiscountUpdateDto {
  int? id;
  String? name;
  String? description;
  String? type;
  double? value;
  int? branchId;
  int? subBranchId;

  DiscountUpdateDto(
      {this.id,
      this.name,
      this.description,
      this.type,
      this.value,
      this.branchId,
      this.subBranchId});

  DiscountUpdateDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    type = json['type'];
    value = json['value'];
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
    data['branchId'] = this.branchId;
    data['subBranchId'] = this.subBranchId;
    return data;
  }
}
