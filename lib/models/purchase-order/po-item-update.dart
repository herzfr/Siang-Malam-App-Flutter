class PoUpdateDto {
  String? orderNo;
  String? note;
  int? suplierId;
  List<ItemsUpdateDto>? items;

  PoUpdateDto({this.orderNo, this.note, this.suplierId, this.items});

  PoUpdateDto.fromJson(Map<String, dynamic> json) {
    orderNo = json['orderNo'];
    note = json['note'];
    suplierId = json['suplierId'];
    if (json['items'] != null) {
      items = <ItemsUpdateDto>[];
      json['items'].forEach((v) {
        items!.add(new ItemsUpdateDto.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderNo'] = this.orderNo;
    data['note'] = this.note;
    data['suplierId'] = this.suplierId;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ItemsUpdateDto {
  int? id;
  int? itemId;
  int? quantity;
  int? cost;

  ItemsUpdateDto({this.id, this.itemId, this.quantity, this.cost});

  ItemsUpdateDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemId = json['itemId'];
    quantity = json['quantity'];
    cost = json['cost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['itemId'] = this.itemId;
    data['quantity'] = this.quantity;
    data['cost'] = this.cost;
    return data;
  }
}
