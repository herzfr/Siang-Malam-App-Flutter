import 'package:siangmalam/models/pageable.dart';

class CategoryItem {
  List<ListCategoryItem>? listCategoryItem;
  Pageable? pageable;

  CategoryItem({this.listCategoryItem, this.pageable});

  CategoryItem.fromJson(Map<String, dynamic> json) {
    if (json['listCategoryItem'] != null) {
      listCategoryItem = <ListCategoryItem>[];
      json['listCategoryItem'].forEach((v) {
        listCategoryItem!.add(new ListCategoryItem.fromJson(v));
      });
    }
    pageable = json['pageable'] != null
        ? new Pageable.fromJson(json['pageable'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listCategoryItem != null) {
      data['listCategoryItem'] =
          this.listCategoryItem!.map((v) => v.toJson()).toList();
    }
    if (this.pageable != null) {
      data['pageable'] = this.pageable!.toJson();
    }
    return data;
  }
}

class ListCategoryItem {
  int? id;
  String? name;
  String? description;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;

  ListCategoryItem(
      {this.id,
      this.name,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy});

  ListCategoryItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    return data;
  }
}
