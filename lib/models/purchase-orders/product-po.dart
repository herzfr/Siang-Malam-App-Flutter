// import 'package:logger/logger.dart';

class SeedProductForPo {
  List<SeedProductList>? listProduct;
  Pageable? pageable;

  SeedProductForPo({this.listProduct, this.pageable});

  SeedProductForPo.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      listProduct = <SeedProductList>[];
      json['content'].forEach((v) {
        listProduct!.add(new SeedProductList.fromJson(v));
      });
    }
    pageable = json['pageable'] != null
        ? new Pageable.fromJson(json['pageable'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listProduct != null) {
      data['content'] = this.listProduct!.map((v) => v.toJson()).toList();
    }
    if (this.pageable != null) {
      data['pageable'] = this.pageable!.toJson();
    }
    return data;
  }
}

class SeedProductList {
  int? id;
  String? name;
  String? description;
  String? size;
  String? unit;
  String? picPath;
  String? pic;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;
  int? categoryId;
  ProductCategory? productCategory;

  SeedProductList(
      {this.id,
      this.name,
      this.description,
      this.size,
      this.unit,
      this.picPath,
      this.pic,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy,
      this.categoryId,
      this.productCategory});

  SeedProductList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    size = json['size'];
    unit = json['unit'];
    picPath = json['picPath'];
    pic = json['pic'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    categoryId = json['categoryId'];
    productCategory = json['product_category'] != null
        ? new ProductCategory.fromJson(json['product_category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['size'] = this.size;
    data['unit'] = this.unit;
    data['picPath'] = this.picPath;
    data['pic'] = this.pic;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    data['categoryId'] = this.categoryId;
    if (this.productCategory != null) {
      data['product_category'] = this.productCategory!.toJson();
    }
    return data;
  }
}

class ProductCategory {
  String? name;

  ProductCategory({this.name});

  ProductCategory.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class SeedItemForPo {
  List<SeedItemList>? listProduct;
  Pageable? pageable;

  SeedItemForPo({this.listProduct, this.pageable});

  SeedItemForPo.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      listProduct = <SeedItemList>[];
      json['content'].forEach((v) {
        listProduct!.add(new SeedItemList.fromJson(v));
      });
    }
    pageable = json['pageable'] != null
        ? new Pageable.fromJson(json['pageable'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listProduct != null) {
      data['content'] = this.listProduct!.map((v) => v.toJson()).toList();
    }
    if (this.pageable != null) {
      data['pageable'] = this.pageable!.toJson();
    }
    return data;
  }
}

class SeedItemList {
  int? id;
  String? name;
  String? description;
  String? size;
  String? unit;
  String? picPath;
  String? pic;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;
  int? categoryId;
  ItemCategory? itemCategory;

  SeedItemList(
      {this.id,
      this.name,
      this.description,
      this.size,
      this.unit,
      this.picPath,
      this.pic,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy,
      this.categoryId,
      this.itemCategory});

  SeedItemList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    size = json['size'];
    unit = json['unit'];
    picPath = json['picPath'];
    pic = json['pic'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    categoryId = json['categoryId'];
    itemCategory = json['product_category'] != null
        ? new ItemCategory.fromJson(json['item_category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['size'] = this.size;
    data['unit'] = this.unit;
    data['picPath'] = this.picPath;
    data['pic'] = this.pic;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    data['categoryId'] = this.categoryId;
    if (this.itemCategory != null) {
      data['item_category'] = this.itemCategory!.toJson();
    }
    return data;
  }
}

class ItemCategory {
  String? name;

  ItemCategory({this.name});

  ItemCategory.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class Pageable {
  int? totalElements;
  int? totalPage;
  int? pageNumber;
  int? pageSize;

  Pageable(
      {this.totalElements, this.totalPage, this.pageNumber, this.pageSize});

  Pageable.fromJson(Map<String, dynamic> json) {
    totalElements = json['totalElements'];
    totalPage = json['totalPage'];
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalElements'] = this.totalElements;
    data['totalPage'] = this.totalPage;
    data['pageNumber'] = this.pageNumber;
    data['pageSize'] = this.pageSize;
    return data;
  }
}
