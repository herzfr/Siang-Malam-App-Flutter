import 'package:siangmalam/models/pageable.dart';
import 'package:siangmalam/models/product/category_items.dart';

class Item {
  List<DataItem>? listItem;
  Pageable? pageable;

  Item({this.listItem, this.pageable});

  Item.fromJson(Map<String, dynamic> json) {
    if (json['listItem'] != null) {
      listItem = <DataItem>[];
      json['listItem'].forEach((v) {
        listItem!.add(new DataItem.fromJson(v));
      });
    }
    pageable = json['pageable'] != null
        ? new Pageable.fromJson(json['pageable'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listItem != null) {
      data['listItem'] = this.listItem!.map((v) => v.toJson()).toList();
    }
    if (this.pageable != null) {
      data['pageable'] = this.pageable!.toJson();
    }
    return data;
  }
}

class DataItem {
  int? id;
  String? name;
  String? description;
  String? unit;
  int? categoryId;
  String? pic;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;
  CategoryItem? category;

  DataItem(
      {this.id,
      this.name,
      this.description,
      this.unit,
      this.categoryId,
      this.pic,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy,
      this.category});

  DataItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    unit = json['unit'];
    categoryId = json['categoryId'];
    pic = json['pic'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['unit'] = this.unit;
    data['categoryId'] = this.categoryId;
    data['pic'] = this.pic;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    data['category'] = this.category;
    return data;
  }
}
