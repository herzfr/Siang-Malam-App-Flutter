import 'dart:convert';

import 'package:siangmalam/models/pageable.dart';

const JsonDecoder decoder = JsonDecoder();
const JsonEncoder encoder = JsonEncoder();

// ignore: non_constant_identifier_names
List<ListWarehouse> WarehouseFromMap(String str) => List<ListWarehouse>.from(
    decoder.convert(str).map((x) => ListWarehouse.fromJson(x)));

// ignore: non_constant_identifier_names
String WarehouseToMap(List<ListWarehouse> data) =>
    encoder.convert(List<dynamic>.from(data.map((x) => x.toJson())));

class Warehouse {
  List<ListWarehouse>? listwarehouse;
  Pageable? pageable;

  Warehouse({this.listwarehouse, this.pageable});

  Warehouse.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      listwarehouse = <ListWarehouse>[];
      json['content'].forEach((v) {
        listwarehouse!.add(ListWarehouse.fromJson(v));
      });
    }
    pageable =
        json['pageable'] != null ? Pageable.fromJson(json['pageable']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (listwarehouse != null) {
      data['content'] = listwarehouse!.map((v) => v.toJson()).toList();
    }
    if (pageable != null) {
      data['pageable'] = pageable!.toJson();
    }
    return data;
  }
}

class WarehouseTransfer {
  int? statusCode;
  String? message;
  List<ListWarehouse>? listWarehouse;

  WarehouseTransfer({this.statusCode, this.message, this.listWarehouse});

  WarehouseTransfer.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      listWarehouse = <ListWarehouse>[];
      json['data'].forEach((v) {
        listWarehouse!.add(new ListWarehouse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.listWarehouse != null) {
      data['data'] = this.listWarehouse!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListWarehouse {
  int? id;
  String? name;
  String? description;
  int? branchId;
  int? subBranchId;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;

  ListWarehouse(
      {this.id,
      this.name,
      this.description,
      this.branchId,
      this.subBranchId,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy});

  ListWarehouse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    branchId = json['branchId'];
    subBranchId = json['subBranchId'];
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
    data['branchId'] = this.branchId;
    data['subBranchId'] = this.subBranchId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    return data;
  }
}
