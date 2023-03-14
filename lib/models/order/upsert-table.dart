class CreateTable {
  String? name;
  String? description;
  int? branchId;
  int? subBranchId;

  CreateTable({this.name, this.description, this.branchId, this.subBranchId});

  CreateTable.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    branchId = json['branchId'];
    subBranchId = json['subBranchId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['branchId'] = this.branchId;
    data['subBranchId'] = this.subBranchId;
    return data;
  }
}

class UpdateTable {
  int? id;
  String? name;
  String? description;
  int? branchId;
  int? subBranchId;
  bool? isOccupied;

  UpdateTable(
      {this.id,
      this.name,
      this.description,
      this.branchId,
      this.subBranchId,
      this.isOccupied});

  UpdateTable.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    branchId = json['branchId'];
    subBranchId = json['subBranchId'];
    isOccupied = json['isOccupied'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['branchId'] = this.branchId;
    data['subBranchId'] = this.subBranchId;
    data['isOccupied'] = this.isOccupied;
    return data;
  }
}

class UpdateTableO {
  int? id;
  bool? isOccupied;
  int? salesId;
  int? capacity;

  UpdateTableO({this.id, this.isOccupied, this.salesId, this.capacity});

  UpdateTableO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isOccupied = json['isOccupied'];
    salesId = json['salesId'];
    capacity = json['capacity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['isOccupied'] = this.isOccupied;
    data['salesId'] = this.salesId;
    data['capacity'] = this.capacity;
    return data;
  }
}
