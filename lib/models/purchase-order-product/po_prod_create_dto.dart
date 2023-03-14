class PoProductCreateDto {
  String? note;
  int? warehouseId;
  int? suplierId;
  List<PoProductCreate>? products;

  PoProductCreateDto(
      {this.note, this.warehouseId, this.suplierId, this.products});

  PoProductCreateDto.fromJson(Map<String, dynamic> json) {
    note = json['note'];
    warehouseId = json['warehouseId'];
    suplierId = json['suplierId'];
    if (json['products'] != null) {
      products = <PoProductCreate>[];
      json['products'].forEach((v) {
        products!.add(new PoProductCreate.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['note'] = this.note;
    data['warehouseId'] = this.warehouseId;
    data['suplierId'] = this.suplierId;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PoProductCreate {
  String? name;
  int? productId;
  int? quantity;
  int? cost;
  String? unit;

  PoProductCreate({this.productId, this.quantity, this.cost});

  PoProductCreate.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    productId = json['productId'];
    quantity = json['quantity'];
    cost = json['cost'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['productId'] = this.productId;
    data['quantity'] = this.quantity;
    data['cost'] = this.cost;
    data['unit'] = this.unit;
    return data;
  }
}
