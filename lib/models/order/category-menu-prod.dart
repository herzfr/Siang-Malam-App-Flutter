import 'package:siangmalam/models/pageable.dart';
import 'package:siangmalam/models/product/category_product.dart';

class CategoryMenuProduct {
  List<CategoryProduct>? categoryprodlist;
  Pageable? pageable;

  CategoryMenuProduct({this.categoryprodlist, this.pageable});

  CategoryMenuProduct.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      categoryprodlist = <CategoryProduct>[];
      json['content'].forEach((v) {
        categoryprodlist!.add(new CategoryProduct.fromJson(v));
      });
    }
    pageable = json['pageable'] != null
        ? new Pageable.fromJson(json['pageable'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categoryprodlist != null) {
      data['content'] = this.categoryprodlist!.map((v) => v.toJson()).toList();
    }
    if (this.pageable != null) {
      data['pageable'] = this.pageable!.toJson();
    }
    return data;
  }
}
