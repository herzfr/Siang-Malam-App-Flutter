class StockTransferItemDto {
  int? frmWarehouseId;
  int? destWarehouseId;
  List<Items>? items;

  StockTransferItemDto({this.frmWarehouseId, this.destWarehouseId, this.items});

  StockTransferItemDto.fromJson(Map<String, dynamic> json) {
    frmWarehouseId = json['frmWarehouseId'];
    destWarehouseId = json['destWarehouseId'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['frmWarehouseId'] = this.frmWarehouseId;
    data['destWarehouseId'] = this.destWarehouseId;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  int? itemId;
  int? quantity;

  Items({this.itemId, this.quantity});

  Items.fromJson(Map<String, dynamic> json) {
    itemId = json['itemId'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemId'] = this.itemId;
    data['quantity'] = this.quantity;
    return data;
  }
}
