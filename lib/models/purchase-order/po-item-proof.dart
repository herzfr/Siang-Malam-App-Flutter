class PoItemProofDto {
  String? orderNo;
  String? status;
  String? note;
  String? expenseStatus;
  List<ItemsProofDto>? items;

  PoItemProofDto(
      {this.orderNo, this.status, this.note, this.expenseStatus, this.items});

  PoItemProofDto.fromJson(Map<String, dynamic> json) {
    orderNo = json['orderNo'];
    status = json['status'];
    note = json['note'];
    expenseStatus = json['expenseStatus'];
    if (json['items'] != null) {
      items = <ItemsProofDto>[];
      json['items'].forEach((v) {
        items!.add(new ItemsProofDto.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderNo'] = this.orderNo;
    data['status'] = this.status;
    data['note'] = this.note;
    data['expenseStatus'] = this.expenseStatus;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ItemsProofDto {
  int? id;
  int? itemId;
  int? quantity;
  int? cost;
  String? status;

  ItemsProofDto({this.id, this.itemId, this.quantity, this.cost, this.status});

  ItemsProofDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemId = json['itemId'];
    quantity = json['quantity'];
    cost = json['cost'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['itemId'] = this.itemId;
    data['quantity'] = this.quantity;
    data['cost'] = this.cost;
    data['status'] = this.status;
    return data;
  }
}
