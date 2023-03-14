import 'package:siangmalam/models/cashier/payment.dart';

class ResProductAdjustment {
  List<ProductAdjustment>? content;
  Pageable? pageable;

  ResProductAdjustment({this.content, this.pageable});

  ResProductAdjustment.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = <ProductAdjustment>[];
      json['content'].forEach((v) {
        content!.add(ProductAdjustment.fromJson(v));
      });
    }
    pageable =
        json['pageable'] != null ? Pageable.fromJson(json['pageable']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.content != null) {
      data['content'] = this.content!.map((v) => v.toJson()).toList();
    }
    if (this.pageable != null) {
      data['pageable'] = this.pageable!.toJson();
    }
    return data;
  }
}

class ProductAdjustment {
  int? id;
  String? name;
  String? note;
  int? warehouseId;
  int? createdAt;
  int? updatedAt;
  String? createdBy;
  String? updatedBy;
  List<ProdAdjs>? items;

  ProductAdjustment(
      {this.id,
      this.name,
      this.note,
      this.warehouseId,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy,
      this.items});

  ProductAdjustment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    note = json['note'];
    warehouseId = json['warehouseId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    if (json['items'] != null) {
      items = <ProdAdjs>[];
      json['items'].forEach((v) {
        items!.add(new ProdAdjs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['note'] = this.note;
    data['warehouseId'] = this.warehouseId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProdAdjs {
  int? id;
  int? adjustQuantity;
  int? stockQuantity;
  int? productStockId;
  String? productName;
  String? unit;

  ProdAdjs(
      {this.id,
      this.adjustQuantity,
      this.stockQuantity,
      this.productStockId,
      this.productName,
      this.unit});

  ProdAdjs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    adjustQuantity = json['adjustQuantity'];
    stockQuantity = json['stockQuantity'];
    productStockId = json['productStockId'];
    productName = json['productName'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['adjustQuantity'] = this.adjustQuantity;
    data['stockQuantity'] = this.stockQuantity;
    data['productStockId'] = this.productStockId;
    data['productName'] = this.productName;
    data['unit'] = this.unit;
    return data;
  }
}

class GetProdAdjst {
  int? size;
  int? page;
  String? search;
  int? startDate;
  int? endDate;

  GetProdAdjst(
      {this.size, this.page, this.search, this.startDate, this.endDate});

  GetProdAdjst.fromJson(Map<String, dynamic> json) {
    size = json['size'];
    page = json['page'];
    search = json['search'];
    startDate = json['startDate'];
    endDate = json['endDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['size'] = this.size;
    data['page'] = this.page;
    data['search'] = this.search;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    return data;
  }
}

class CreateProdAdjst {
  int? warehouseId;
  String? note;
  String? name;
  List<AdjstItems>? items;

  CreateProdAdjst({this.warehouseId, this.note, this.name, this.items});

  CreateProdAdjst.fromJson(Map<String, dynamic> json) {
    warehouseId = json['warehouseId'];
    note = json['note'];
    name = json['name'];
    if (json['items'] != null) {
      items = <AdjstItems>[];
      json['items'].forEach((v) {
        items!.add(new AdjstItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['warehouseId'] = this.warehouseId;
    data['note'] = this.note;
    data['name'] = this.name;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AdjstItems {
  int? stockId;
  String? prodName;
  String? unit;
  int? quantity;

  AdjstItems({this.stockId, this.prodName, this.unit, this.quantity});

  AdjstItems.fromJson(Map<String, dynamic> json) {
    stockId = json['stockId'];
    prodName = json['prodName'];
    unit = json['unit'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stockId'] = this.stockId;
    data['prodName'] = this.prodName;
    data['unit'] = this.unit;
    data['quantity'] = this.quantity;
    return data;
  }
}
