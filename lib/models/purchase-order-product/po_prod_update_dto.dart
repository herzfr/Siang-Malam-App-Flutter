class PoProductUpdateDto {
  String? orderNo;
  String? note;
  int? suplierId;
  List<PoProductUpdate>? products;

  PoProductUpdateDto({this.note, this.orderNo, this.suplierId, this.products});

  PoProductUpdateDto.fromJson(Map<String, dynamic> json) {
    note = json['note'];
    orderNo = json['orderNo'];
    suplierId = json['suplierId'];
    if (json['products'] != null) {
      products = <PoProductUpdate>[];
      json['products'].forEach((v) {
        products!.add(new PoProductUpdate.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['note'] = this.note;
    data['warehouseId'] = this.orderNo;
    data['suplierId'] = this.suplierId;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PoProductUpdate {
  int? id;
  int? productId;
  int? quantity;
  int? cost;

  PoProductUpdate({this.id, this.productId, this.quantity, this.cost});

  PoProductUpdate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['productId'];
    quantity = json['quantity'];
    cost = json['cost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['productId'] = this.productId;
    data['quantity'] = this.quantity;
    data['cost'] = this.cost;
    return data;
  }
}
