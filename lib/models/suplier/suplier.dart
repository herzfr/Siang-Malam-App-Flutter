import 'package:siangmalam/models/pageable.dart';

class Suplier {
  List<ListSuplier>? listSuplier;
  Pageable? pageable;

  Suplier({this.listSuplier, this.pageable});

  Suplier.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      listSuplier = <ListSuplier>[];
      json['content'].forEach((v) {
        listSuplier!.add(new ListSuplier.fromJson(v));
      });
    }
    pageable = json['pageable'] != null
        ? new Pageable.fromJson(json['pageable'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listSuplier != null) {
      data['content'] = this.listSuplier!.map((v) => v.toJson()).toList();
    }
    if (this.pageable != null) {
      data['pageable'] = this.pageable!.toJson();
    }
    return data;
  }
}

class ListSuplier {
  int? id;
  String? name;
  String? address1;
  String? address2;
  String? address3;
  String? phone;
  String? email;
  String? description;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;

  ListSuplier(
      {this.id,
      this.name,
      this.address1,
      this.address2,
      this.address3,
      this.phone,
      this.email,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy});

  ListSuplier.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address1 = json['address1'];
    address2 = json['address2'];
    address3 = json['address3'];
    phone = json['phone'];
    email = json['email'];
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
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['address3'] = this.address3;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['description'] = this.description;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    return data;
  }
}
