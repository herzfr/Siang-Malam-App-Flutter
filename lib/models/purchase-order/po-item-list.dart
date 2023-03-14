import 'package:siangmalam/models/pageable.dart';

class PoItemData {
  List<PoItemListData>? listdataitems;
  Pageable? pageable;

  PoItemData({this.listdataitems, this.pageable});

  PoItemData.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      listdataitems = <PoItemListData>[];
      json['content'].forEach((v) {
        listdataitems!.add(new PoItemListData.fromJson(v));
      });
    }
    pageable = json['pageable'] != null
        ? new Pageable.fromJson(json['pageable'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listdataitems != null) {
      data['content'] = this.listdataitems!.map((v) => v.toJson()).toList();
    }
    if (this.pageable != null) {
      data['pageable'] = this.pageable!.toJson();
    }
    return data;
  }
}

class PoItemListData {
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
  String? category;

  PoItemListData(
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

  PoItemListData.fromJson(Map<String, dynamic> json) {
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
