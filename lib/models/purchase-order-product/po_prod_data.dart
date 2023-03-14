import 'package:siangmalam/models/pageable.dart';

class ProductData {
  List<ProductListData>? listproduct;
  Pageable? pageable;

  ProductData({this.listproduct, this.pageable});

  ProductData.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      listproduct = <ProductListData>[];
      json['content'].forEach((v) {
        listproduct!.add(new ProductListData.fromJson(v));
      });
    }
    pageable = json['pageable'] != null
        ? new Pageable.fromJson(json['pageable'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listproduct != null) {
      data['content'] = this.listproduct!.map((v) => v.toJson()).toList();
    }
    if (this.pageable != null) {
      data['pageable'] = this.pageable!.toJson();
    }
    return data;
  }
}

class ProductListData {
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

  ProductListData(
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

  ProductListData.fromJson(Map<String, dynamic> json) {
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
