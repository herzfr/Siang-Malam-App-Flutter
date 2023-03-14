import 'package:siangmalam/models/pageable.dart';

class ResPoItem {
  List<ListPoItem>? listpoitem;
  Pageable? pageable;

  ResPoItem({this.listpoitem, this.pageable});

  ResPoItem.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      listpoitem = <ListPoItem>[];
      json['content'].forEach((v) {
        listpoitem!.add(new ListPoItem.fromJson(v));
      });
    }
    pageable = json['pageable'] != null
        ? new Pageable.fromJson(json['pageable'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listpoitem != null) {
      data['content'] = this.listpoitem!.map((v) => v.toJson()).toList();
    }
    if (this.pageable != null) {
      data['pageable'] = this.pageable!.toJson();
    }
    return data;
  }
}

class ListPoItem {
  int? id;
  String? note;
  String? orderNo;
  String? paidStatus;
  String? status;
  String? receiptPath;
  String? receiptPic;
  String? proofPath;
  String? proofPic;
  int? suplierId;
  int? warehouseId;
  int? expensesId;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;
  int? paid;
  int? remaining;
  int? totalCost;
  WarehousePoItem? warehouse;
  SuplierPoItem? suplier;
  List<ItemsPo>? items;

  ListPoItem(
      {this.id,
      this.note,
      this.orderNo,
      this.paidStatus,
      this.status,
      this.receiptPath,
      this.receiptPic,
      this.proofPath,
      this.proofPic,
      this.suplierId,
      this.warehouseId,
      this.expensesId,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy,
      this.paid,
      this.remaining,
      this.totalCost,
      this.warehouse,
      this.suplier,
      this.items});

  ListPoItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    note = json['note'];
    orderNo = json['orderNo'];
    paidStatus = json['paidStatus'];
    status = json['status'];
    receiptPath = json['receiptPath'];
    receiptPic = json['receiptPic'];
    proofPath = json['proofPath'];
    proofPic = json['proofPic'];
    suplierId = json['suplierId'];
    warehouseId = json['warehouseId'];
    expensesId = json['expensesId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    paid = json['paid'];
    remaining = json['remaining'];
    totalCost = json['totalCost'];
    warehouse = json['warehouse'] != null
        ? WarehousePoItem.fromJson(json['warehouse'])
        : null;
    suplier = json['suplier'] != null
        ? SuplierPoItem.fromJson(json['suplier'])
        : null;
    if (json['items'] != null) {
      items = <ItemsPo>[];
      json['items'].forEach((v) {
        items!.add(ItemsPo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['note'] = this.note;
    data['orderNo'] = this.orderNo;
    data['paidStatus'] = this.paidStatus;
    data['status'] = this.status;
    data['receiptPath'] = this.receiptPath;
    data['receiptPic'] = this.receiptPic;
    data['proofPath'] = this.proofPath;
    data['proofPic'] = this.proofPic;
    data['suplierId'] = this.suplierId;
    data['warehouseId'] = this.warehouseId;
    data['expensesId'] = this.expensesId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    data['paid'] = this.paid;
    data['remaining'] = this.remaining;
    data['totalCost'] = this.totalCost;
    if (this.warehouse != null) {
      data['warehouse'] = this.warehouse!.toJson();
    }
    if (this.suplier != null) {
      data['suplier'] = this.suplier!.toJson();
    }
    if (this.items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WarehousePoItem {
  String? name;

  WarehousePoItem({this.name});

  WarehousePoItem.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class SuplierPoItem {
  String? name;

  SuplierPoItem({this.name});

  SuplierPoItem.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class ItemsPo {
  int? id;
  int? itemId;
  String? name;
  int? quantity;
  String? unit;
  int? cost;
  String? status;

  ItemsPo(
      {this.id,
      this.itemId,
      this.name,
      this.quantity,
      this.unit,
      this.cost,
      this.status});

  ItemsPo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemId = json['itemId'];
    name = json['name'];
    quantity = json['quantity'];
    unit = json['unit'];
    cost = json['cost'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['itemId'] = this.itemId;
    data['name'] = this.name;
    data['quantity'] = this.quantity;
    data['unit'] = this.unit;
    data['cost'] = this.cost;
    data['status'] = this.status;
    return data;
  }
}

class ApprovPoItem {
  String? orderNo;
  String? status;
  String? note;
  List<ItemsPo>? items;

  ApprovPoItem({this.orderNo, this.status, this.note, this.items});

  ApprovPoItem.fromJson(Map<String, dynamic> json) {
    orderNo = json['orderNo'];
    status = json['status'];
    note = json['note'];
    if (json['items'] != null) {
      items = <ItemsPo>[];
      json['items'].forEach((v) {
        items!.add(new ItemsPo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderNo'] = this.orderNo;
    data['status'] = this.status;
    data['note'] = this.note;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UpsertPoItem {
  String? orderNo;
  String? note;
  int? warehouseId;
  int? suplierId;
  List<ItemsPo>? items;

  UpsertPoItem({this.note, this.warehouseId, this.suplierId, this.items});

  UpsertPoItem.fromJson(Map<String, dynamic> json) {
    orderNo = json['orderNo'];
    note = json['note'];
    warehouseId = json['warehouseId'];
    suplierId = json['suplierId'];
    if (json['items'] != null) {
      items = <ItemsPo>[];
      json['items'].forEach((v) {
        items!.add(new ItemsPo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderNo'] = this.orderNo;
    data['note'] = this.note;
    data['warehouseId'] = this.warehouseId;
    data['suplierId'] = this.suplierId;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
