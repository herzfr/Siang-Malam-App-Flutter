class PoItemCreateDto {
  String? note;
  int? warehouseId;
  int? suplierId;
  List<PoItemsCreate>? items;

  PoItemCreateDto({this.note, this.warehouseId, this.suplierId, this.items});

  PoItemCreateDto.fromJson(Map<String, dynamic> json) {
    note = json['note'];
    warehouseId = json['warehouseId'];
    suplierId = json['suplierId'];
    if (json['items'] != null) {
      items = <PoItemsCreate>[];
      json['items'].forEach((v) {
        items!.add(new PoItemsCreate.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['note'] = this.note;
    data['warehouseId'] = this.warehouseId;
    data['suplierId'] = this.suplierId;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PoItemsCreate {
  String? name;
  int? itemId;
  int? quantity;
  int? cost;
  String? unit;

  PoItemsCreate({this.itemId, this.quantity, this.cost});

  PoItemsCreate.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    itemId = json['itemId'];
    quantity = json['quantity'];
    cost = json['cost'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['itemId'] = this.itemId;
    data['quantity'] = this.quantity;
    data['cost'] = this.cost;
    data['unit'] = this.unit;
    return data;
  }
}
