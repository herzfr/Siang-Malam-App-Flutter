import 'package:siangmalam/models/pageable.dart';
import 'package:siangmalam/models/product/items.dart';
import 'package:siangmalam/models/warehouse/warehouse.dart';

class StockItem {
  List<ListStockItem>? listStockItem;
  Pageable? pageable;

  StockItem({this.listStockItem, this.pageable});

  StockItem.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      listStockItem = <ListStockItem>[];
      json['content'].forEach((v) {
        listStockItem!.add(new ListStockItem.fromJson(v));
      });
    }
    pageable = json['pageable'] != null
        ? new Pageable.fromJson(json['pageable'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listStockItem != null) {
      data['content'] = this.listStockItem!.map((v) => v.toJson()).toList();
    }
    if (this.pageable != null) {
      data['pageable'] = this.pageable!.toJson();
    }
    return data;
  }
}

class ListStockItem {
  int? id;
  int? itemId;
  int? quantity;
  int? warehouseId;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;
  DataItem? items;
  ListWarehouse? warehouse;

  ListStockItem(
      {this.id,
      this.itemId,
      this.quantity,
      this.warehouseId,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy,
      this.items,
      this.warehouse});

  ListStockItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemId = json['itemId'];
    quantity = json['quantity'];
    warehouseId = json['warehouseId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    items = json['items'] != null ? new DataItem.fromJson(json['items']) : null;
    warehouse = json['warehouse'] != null
        ? new ListWarehouse.fromJson(json['warehouse'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['itemId'] = this.itemId;
    data['quantity'] = this.quantity;
    data['warehouseId'] = this.warehouseId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    if (this.items != null) {
      data['items'] = this.items!.toJson();
    }
    if (this.warehouse != null) {
      data['warehouse'] = this.warehouse!.toJson();
    }
    return data;
  }
}

// class Items {
//   String? name;

//   Items({this.name});

//   Items.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     return data;
//   }
// }
