import 'package:siangmalam/models/pageable.dart';

class StockItemOut {
  List<StockItemOutList>? listSto;
  Pageable? pageable;

  StockItemOut({this.listSto, this.pageable});

  StockItemOut.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      listSto = <StockItemOutList>[];
      json['content'].forEach((v) {
        listSto!.add(new StockItemOutList.fromJson(v));
      });
    }
    pageable = json['pageable'] != null
        ? new Pageable.fromJson(json['pageable'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listSto != null) {
      data['content'] = this.listSto!.map((v) => v.toJson()).toList();
    }
    if (this.pageable != null) {
      data['pageable'] = this.pageable!.toJson();
    }
    return data;
  }
}

class StockItemOutList {
  int? id;
  String? note;
  String? type;
  String? costType;
  String? createdAt;
  String? createdBy;
  int? warehouseId;
  WarehouseName? warehouse;
  List<ItemOut>? items;

  StockItemOutList(
      {this.id,
      this.note,
      this.type,
      this.costType,
      this.createdAt,
      this.createdBy,
      this.warehouseId,
      this.items});

  StockItemOutList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    note = json['note'];
    type = json['type'];
    costType = json['costType'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    warehouseId = json['warehouseId'];
    warehouse = json['warehouse'] != null
        ? new WarehouseName.fromJson(json['warehouse'])
        : null;
    if (json['items'] != null) {
      items = <ItemOut>[];
      json['items'].forEach((v) {
        items!.add(new ItemOut.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['note'] = this.note;
    data['type'] = this.type;
    data['costType'] = this.costType;
    data['createdAt'] = this.createdAt;
    data['createdBy'] = this.createdBy;
    data['warehouseId'] = this.warehouseId;
    if (this.warehouse != null) {
      data['warehouse'] = this.warehouse!.toJson();
    }
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WarehouseName {
  String? name;

  WarehouseName({this.name});

  WarehouseName.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class ItemOut {
  int? quantity;
  int? initalStock;
  int? itemStock;
  String? name;

  ItemOut({this.quantity, this.initalStock, this.itemStock, this.name});

  ItemOut.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    initalStock = json['initalStock'];
    itemStock = json['itemStock'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quantity'] = this.quantity;
    data['initalStock'] = this.initalStock;
    data['itemStock'] = this.itemStock;
    data['name'] = this.name;
    return data;
  }
}
