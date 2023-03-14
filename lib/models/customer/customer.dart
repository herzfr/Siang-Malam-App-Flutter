import 'package:siangmalam/models/pageable.dart';

class Customer {
  List<ListCustomer>? listcustomer;
  Pageable? pageable;

  Customer({this.listcustomer, this.pageable});

  Customer.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      listcustomer = <ListCustomer>[];
      json['content'].forEach((v) {
        listcustomer!.add(new ListCustomer.fromJson(v));
      });
    }
    pageable = json['pageable'] != null
        ? new Pageable.fromJson(json['pageable'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listcustomer != null) {
      data['content'] = this.listcustomer!.map((v) => v.toJson()).toList();
    }
    if (this.pageable != null) {
      data['pageable'] = this.pageable!.toJson();
    }
    return data;
  }
}

class ListCustomer {
  int? id;
  String? name;
  String? address1;
  String? address2;
  String? address3;
  String? phone;
  String? email;
  String? pic;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;

  ListCustomer(
      {this.id,
      this.name,
      this.address1,
      this.address2,
      this.address3,
      this.phone,
      this.email,
      this.pic,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt});

  ListCustomer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address1 = json['address1'];
    address2 = json['address2'];
    address3 = json['address3'];
    phone = json['phone'];
    email = json['email'];
    pic = json['pic'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
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
    data['pic'] = this.pic;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
