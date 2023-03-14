import 'package:siangmalam/models/pageable.dart';

class PoProducts {
  List<PoProductList>? poroductlist;
  Pageable? pageable;

  PoProducts({this.poroductlist, this.pageable});

  PoProducts.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      poroductlist = <PoProductList>[];
      json['content'].forEach((v) {
        poroductlist!.add(new PoProductList.fromJson(v));
      });
    }
    pageable = json['pageable'] != null
        ? new Pageable.fromJson(json['pageable'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.poroductlist != null) {
      data['content'] = this.poroductlist!.map((v) => v.toJson()).toList();
    }
    if (this.pageable != null) {
      data['pageable'] = this.pageable!.toJson();
    }
    return data;
  }
}

class PoProductList {
  int? id;
  String? note;
  String? orderNo;
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
  String? paidStatus;
  int? paid;
  int? remaining;
  int? totalCost;
  WarehousePoProduct? warehouse;
  WarehousePoProduct? suplier;
  ExpensesPoProduct? expenses;
  List<ProductsList>? products;

  PoProductList(
      {this.id,
      this.note,
      this.orderNo,
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
      this.paidStatus,
      this.paid,
      this.remaining,
      this.totalCost,
      this.warehouse,
      this.suplier,
      this.expenses,
      this.products});

  PoProductList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    note = json['note'];
    orderNo = json['orderNo'];
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
    paidStatus = json['paidStatus'];
    paid = json['paid'];
    remaining = json['remaining'];
    totalCost = json['totalCost'];
    warehouse = json['warehouse'] != null
        ? new WarehousePoProduct.fromJson(json['warehouse'])
        : null;
    suplier = json['suplier'] != null
        ? new WarehousePoProduct.fromJson(json['suplier'])
        : null;
    expenses = json['expenses'] != null
        ? new ExpensesPoProduct.fromJson(json['expenses'])
        : null;
    if (json['products'] != null) {
      products = <ProductsList>[];
      json['products'].forEach((v) {
        products!.add(new ProductsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['note'] = this.note;
    data['orderNo'] = this.orderNo;
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
    data['paidStatus'] = this.paidStatus;
    data['paid'] = this.paid;
    data['remaining'] = this.remaining;
    data['totalCost'] = this.totalCost;
    if (this.warehouse != null) {
      data['warehouse'] = this.warehouse!.toJson();
    }
    if (this.suplier != null) {
      data['suplier'] = this.suplier!.toJson();
    }
    if (this.expenses != null) {
      data['expenses'] = this.expenses!.toJson();
    }
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WarehousePoProduct {
  String? name;

  WarehousePoProduct({this.name});

  WarehousePoProduct.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class ExpensesPoProduct {
  String? status;
  String? type;

  ExpensesPoProduct({this.status, this.type});

  ExpensesPoProduct.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['type'] = this.type;
    return data;
  }
}

class ProductsList {
  int? id;
  int? productId;
  String? name;
  int? quantity;
  String? unit;
  int? cost;
  String? status;

  ProductsList(
      {this.id,
      this.productId,
      this.name,
      this.quantity,
      this.unit,
      this.cost,
      this.status});

  ProductsList.fromJson(Map<String, dynamic> json) {
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
