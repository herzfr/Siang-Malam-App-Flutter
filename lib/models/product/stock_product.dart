import 'package:siangmalam/models/pageable.dart';
import 'package:siangmalam/models/warehouse/warehouse.dart';

class StockProducts {
  List<ListProducts>? listProduct;
  Pageable? pageable;

  StockProducts({this.listProduct, this.pageable});

  StockProducts.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      listProduct = <ListProducts>[];
      json['content'].forEach((v) {
        listProduct!.add(ListProducts.fromJson(v));
      });
    }
    pageable =
        json['pageable'] != null ? Pageable.fromJson(json['pageable']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (listProduct != null) {
      data['content'] = listProduct!.map((v) => v.toJson()).toList();
    }
    if (pageable != null) {
      data['pageable'] = pageable!.toJson();
    }
    return data;
  }
}

class RespStockProd {
  List<ListProducts>? listProd;

  RespStockProd({this.listProd});

  RespStockProd.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      listProd = <ListProducts>[];
      json['data'].forEach((v) {
        listProd!.add(new ListProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listProd != null) {
      data['data'] = this.listProd!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListProducts {
  int? id;
  int? productId;
  int? warehouseId;
  int? quantity;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;
  Product? product;
  ListWarehouse? warehouse;

  ListProducts(
      {this.id,
      this.productId,
      this.warehouseId,
      this.quantity,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy,
      this.product,
      this.warehouse});

  ListProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['productId'];
    warehouseId = json['warehouseId'];
    quantity = json['quantity'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
    warehouse = json['warehouse'] != null
        ? ListWarehouse.fromJson(json['warehouse'])
        : null;
  }

  // String get length => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['productId'] = productId;
    data['warehouseId'] = warehouseId;
    data['quantity'] = quantity;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['createdBy'] = createdBy;
    data['updatedBy'] = updatedBy;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    if (warehouse != null) {
      data['warehouse'] = warehouse!.toJson();
    }
    return data;
  }
}

class Product {
  int? id;
  String? name;
  String? unit;

  Product({this.name});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['unit'] = unit;
    return data;
  }
}

class GetStockProd {
  int? branchId;
  int? subBranchId;
  String? search;

  GetStockProd({this.branchId, this.subBranchId, this.search});

  GetStockProd.fromJson(Map<String, dynamic> json) {
    branchId = json['branchId'];
    subBranchId = json['subBranchId'];
    search = json['search'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['branchId'] = this.branchId;
    data['subBranchId'] = this.subBranchId;
    data['search'] = this.search;
    return data;
  }
}
