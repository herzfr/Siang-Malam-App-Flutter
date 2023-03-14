class StockItemOutDto {
  String? note;
  int? warehouseId;
  List<It>? it;

  StockItemOutDto({this.note, this.warehouseId, this.it});

  StockItemOutDto.fromJson(Map<String, dynamic> json) {
    note = json['note'];
    warehouseId = json['warehouseId'];
    if (json['items'] != null) {
      it = <It>[];
      json['items'].forEach((v) {
        it!.add(new It.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['note'] = this.note;
    data['warehouseId'] = this.warehouseId;
    if (this.it != null) {
      data['items'] = this.it!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class It {
  int? stockId;
  int? quantity;
  int? initalStock;
  int? itemStock;
  String? name;
  String? unit;

  It({this.stockId, this.quantity, this.name});

  It.fromJson(Map<String, dynamic> json) {
    stockId = json['stockId'];
    quantity = json['quantity'];
    initalStock = json['initalStock'];
    itemStock = json['itemStock'];
    name = json['name'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stockId'] = this.stockId;
    data['quantity'] = this.quantity;
    data['initalStock'] = this.initalStock;
    data['itemStock'] = this.itemStock;
    data['name'] = this.name;
    data['unit'] = this.unit;
    return data;
  }
}
