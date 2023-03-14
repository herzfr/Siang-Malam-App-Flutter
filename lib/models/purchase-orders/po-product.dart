import 'package:siangmalam/models/pageable.dart';

class ResPoProduct {
  List<ListPoProduct>? listpoproduct;
  Pageable? pageable;

  ResPoProduct({this.listpoproduct, this.pageable});

  ResPoProduct.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      listpoproduct = <ListPoProduct>[];
      json['content'].forEach((v) {
        listpoproduct!.add(new ListPoProduct.fromJson(v));
      });
    }
    pageable = json['pageable'] != null
        ? new Pageable.fromJson(json['pageable'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listpoproduct != null) {
      data['content'] = this.listpoproduct!.map((v) => v.toJson()).toList();
    }
    if (this.pageable != null) {
      data['pageable'] = this.pageable!.toJson();
    }
    return data;
  }
}

class ListPoProduct {
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
  WarehousePoProd? warehouse;
  SuplierPoProd? suplier;
  List<ProductsPo>? products;

  ListPoProduct(
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
      this.products});

  ListPoProduct.fromJson(Map<String, dynamic> json) {
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
        ? WarehousePoProd.fromJson(json['warehouse'])
        : null;
    suplier = json['suplier'] != null
        ? SuplierPoProd.fromJson(json['suplier'])
        : null;
    if (json['products'] != null) {
      products = <ProductsPo>[];
      json['products'].forEach((v) {
        products!.add(ProductsPo.fromJson(v));
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
    if (this.products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WarehousePoProd {
  String? name;

  WarehousePoProd({this.name});

  WarehousePoProd.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class SuplierPoProd {
  String? name;

  SuplierPoProd({this.name});

  SuplierPoProd.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class ProductsPo {
  int? id;
  int? productId;
  String? name;
  int? quantity;
  String? unit;
  int? cost;
  String? status;

  ProductsPo(
      {this.id,
      this.productId,
      this.name,
      this.quantity,
      this.unit,
      this.cost,
      this.status});

  ProductsPo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['productId'];
    name = json['name'];
    quantity = json['quantity'];
    unit = json['unit'];
    cost = json['cost'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['productId'] = this.productId;
    data['name'] = this.name;
    data['quantity'] = this.quantity;
    data['unit'] = this.unit;
    data['cost'] = this.cost;
    data['status'] = this.status;
    return data;
  }
}

class ApprovPoProduct {
  String? orderNo;
  String? status;
  String? note;
  List<ProductsPo>? products;

  ApprovPoProduct({this.orderNo, this.status, this.note, this.products});

  ApprovPoProduct.fromJson(Map<String, dynamic> json) {
    orderNo = json['orderNo'];
    status = json['status'];
    note = json['note'];
    if (json['products'] != null) {
      products = <ProductsPo>[];
      json['products'].forEach((v) {
        products!.add(new ProductsPo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderNo'] = this.orderNo;
    data['status'] = this.status;
    data['note'] = this.note;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UpsertPoProduct {
  String? orderNo;
  String? note;
  int? warehouseId;
  int? suplierId;
  List<ProductsPo>? products;

  UpsertPoProduct({this.note, this.warehouseId, this.suplierId, this.products});

  UpsertPoProduct.fromJson(Map<String, dynamic> json) {
    orderNo = json['orderNo'];
    note = json['note'];
    warehouseId = json['warehouseId'];
    suplierId = json['suplierId'];
    if (json['products'] != null) {
      products = <ProductsPo>[];
      json['products'].forEach((v) {
        products!.add(new ProductsPo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderNo'] = this.orderNo;
    data['note'] = this.note;
    data['warehouseId'] = this.warehouseId;
    data['suplierId'] = this.suplierId;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
