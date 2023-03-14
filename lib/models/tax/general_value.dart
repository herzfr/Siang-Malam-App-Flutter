import 'package:siangmalam/models/pageable.dart';

class GeneralValue {
  List<GeneralValueList>? valueList;
  Pageable? pageable;

  GeneralValue({this.valueList, this.pageable});

  GeneralValue.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      valueList = <GeneralValueList>[];
      json['content'].forEach((v) {
        valueList!.add(new GeneralValueList.fromJson(v));
      });
    }
    pageable = json['pageable'] != null
        ? new Pageable.fromJson(json['pageable'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.valueList != null) {
      data['content'] = this.valueList!.map((v) => v.toJson()).toList();
    }
    if (this.pageable != null) {
      data['pageable'] = this.pageable!.toJson();
    }
    return data;
  }
}

class GeneralValueList {
  int? id;
  String? key;
  String? value;
  String? description;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;
  String? type;

  GeneralValueList(
      {this.id,
      this.key,
      this.value,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy,
      this.type});

  GeneralValueList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    value = json['value'];
    description = json['description'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['key'] = this.key;
    data['value'] = this.value;
    data['description'] = this.description;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    data['type'] = this.type;
    return data;
  }
}

class GeneralFilter {
  int? size;
  int? page;
  String? search;
  String? type;

  GeneralFilter({this.size, this.page, this.search});

  GeneralFilter.fromJson(Map<String, dynamic> json) {
    size = json['size'];
    page = json['page'];
    search = json['search'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['size'] = this.size;
    data['page'] = this.page;
    data['search'] = this.search;
    data['type'] = this.type;
    return data;
  }
}
