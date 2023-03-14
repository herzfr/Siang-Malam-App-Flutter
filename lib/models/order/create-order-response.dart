import 'dart:convert';

// import 'package:logger/logger.dart';
import 'package:siangmalam/models/pageable.dart';

class ResponseOrderList {
  List<CreateOrderResponse>? orderList;
  Pageable? pageable;

  ResponseOrderList({this.orderList, this.pageable});

  ResponseOrderList.fromJson(Map<String, dynamic> json) {
    // var log = Logger();

    if (json['data'] != null) {
      orderList = <CreateOrderResponse>[];
      json['data'].forEach((v) {
        // log.d(v);
        orderList!.add(CreateOrderResponse.fromJson(v));
        // log.d(orderList);
      });
    }
    pageable =
        json['pageable'] != null ? Pageable.fromJson(json['pageable']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (orderList != null) {
      data['data'] = orderList!.map((v) => v.toJson()).toList();
    }
    if (pageable != null) {
      data['pageable'] = this.pageable!.toJson();
    }
    return data;
  }
}

class CreateOrderResponse {
  int? id;
  String? name;
  int? branchId;
  int? subBranchId;
  List<int>? tableIds;
  String? waiter;
  String? isDone;
  String? note;
  int? createdAt;
  int? shiftId;
  List<Cart>? items;

  CreateOrderResponse(
      {this.id,
      this.name,
      this.branchId,
      this.subBranchId,
      this.tableIds,
      this.waiter,
      this.isDone,
      this.note,
      this.shiftId,
      this.createdAt,
      this.items});

  CreateOrderResponse.fromJson(Map<String, dynamic> json) {
    // var log = Logger();
    var genreIdsFromJson = json['tableIds'];
    List<int> genreIdsList;
    if (genreIdsFromJson == null) {
      genreIdsList = [];
    } else {
      genreIdsList = List<int>.from(genreIdsFromJson);
    }

    id = json['id'];
    name = json['name'];
    branchId = json['branchId'];
    subBranchId = json['subBranchId'];
    tableIds = genreIdsList;
    waiter = json['waiter'];
    isDone = json['isDone'];
    note = json['note'];
    createdAt = json['createdAt'];
    shiftId = json['shiftId'];
    if (json['items'] != null) {
      items = <Cart>[];
      for (var item in json['items']) {
        items!.add(Cart.fromJson(item));
      }
    }
  }

  Map<String, dynamic> toJson() {
    // var log = Logger();
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['name'] = this.name;
    data['branchId'] = this.branchId;
    data['subBranchId'] = this.subBranchId;
    data['tableIds'] = this.tableIds == null ? [] : this.tableIds;
    data['waiter'] = this.waiter;
    data['isDone'] = this.isDone;
    data['note'] = this.note;
    data['shiftId'] = this.shiftId;
    data['createdAt'] = this.createdAt;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cart {
  int? id;
  int? tempSalesId;
  String? menuId;
  String? name;
  int? amount;
  int? unitPrice;
  String? unit;
  int? totalPrice;
  bool? isPackage;
  String? createdBy;
  int? stockId;
  List<int>? stockIds;
  String? pic;
  String? priceCat;
  int? priceCatId;

  Cart(
      {this.id,
      this.tempSalesId,
      this.menuId,
      this.name,
      this.amount,
      this.unitPrice,
      this.unit,
      this.totalPrice,
      this.isPackage,
      this.createdBy,
      this.stockId,
      this.stockIds,
      this.pic,
      this.priceCat,
      this.priceCatId});

  Cart.fromJson(Map<String, dynamic> json) {
    // var log = Logger();
    // log.d(json);
    var stock = jsonDecode(json['stockId']);
    List<int>? arr = (stock as List).map((item) => item as int).toList();

    // log.d(arr);

    id = json['id'];
    tempSalesId = json['tempSalesId'];
    menuId = json['menuId'];
    name = json['name'];
    amount = json['amount'];
    unitPrice = json['unitPrice'];
    unit = json['unit'];
    totalPrice = json['totalPrice'];
    isPackage = json['isPackage'];
    createdBy = json['createdBy'];
    stockId = !json['isPackage'] ? arr.elementAt(0) : null;
    stockIds = json['isPackage'] ? arr : [];
    pic = json['pic'];
    priceCat = json['priceCat'];
    priceCatId = json['priceCatId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tempSalesId'] = this.tempSalesId;
    data['menuId'] = this.menuId;
    data['name'] = this.name;
    data['amount'] = this.amount;
    data['unitPrice'] = this.unitPrice;
    data['unit'] = this.unit;
    data['totalPrice'] = this.totalPrice;
    data['isPackage'] = this.isPackage;
    data['createdBy'] = this.createdBy;
    data['stockId'] = this.stockId;
    data['stockIds'] = this.stockIds;
    data['pic'] = this.pic;
    data['priceCat'] = this.priceCat;
    data['priceCatId'] = this.priceCatId;
    return data;
  }
}
