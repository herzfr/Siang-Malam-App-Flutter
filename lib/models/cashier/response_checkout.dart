// import 'dart:convert';

class ResponseCheckout {
  int? id;
  String? name;
  int? branchId;
  int? subBranchId;
  String? note;
  int? customerId;
  String? customerName;
  String? cashierName;
  String? cashierUserName;
  String? waiterName;
  String? waiterUserName;
  int? subTotal;
  int? total;
  int? discount;
  int? service;
  int? tax;
  bool? isDineIn;
  String? status;
  int? change;
  int? cash;
  List<SalesCart>? itemsCheckout;

  ResponseCheckout(
      {this.id,
      this.name,
      this.branchId,
      this.subBranchId,
      this.note,
      this.customerId,
      this.customerName,
      this.cashierName,
      this.cashierUserName,
      this.waiterName,
      this.waiterUserName,
      this.subTotal,
      this.total,
      this.discount,
      this.service,
      this.tax,
      this.isDineIn,
      this.status,
      this.change,
      this.cash,
      this.itemsCheckout});

  ResponseCheckout.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    branchId = json['branchId'];
    subBranchId = json['subBranchId'];
    note = json['note'];
    customerId = json['customerId'];
    customerName = json['customerName'];
    cashierName = json['cashierName'];
    cashierUserName = json['cashierUserName'];
    waiterName = json['waiterName'];
    waiterUserName = json['waiterUserName'];
    subTotal = json['subTotal'];
    total = json['total'];
    discount = json['discount'];
    service = json['service'];
    tax = json['tax'];
    isDineIn = json['isDineIn'];
    status = json['status'];
    change = json['change'];
    cash = json['cash'];
    if (json['items'] != null) {
      itemsCheckout = <SalesCart>[];
      json['items'].forEach((v) {
        itemsCheckout!.add(new SalesCart.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['branchId'] = this.branchId;
    data['subBranchId'] = this.subBranchId;
    data['note'] = this.note;
    data['customerId'] = this.customerId;
    data['customerName'] = this.customerName;
    data['cashierName'] = this.cashierName;
    data['cashierUserName'] = this.cashierUserName;
    data['waiterName'] = this.waiterName;
    data['waiterUserName'] = this.waiterUserName;
    data['subTotal'] = this.subTotal;
    data['total'] = this.total;
    data['discount'] = this.discount;
    data['service'] = this.service;
    data['tax'] = this.tax;
    data['isDineIn'] = this.isDineIn;
    data['status'] = this.status;
    data['change'] = this.change;
    data['cash'] = this.cash;
    if (this.itemsCheckout != null) {
      data['items'] = this.itemsCheckout!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SalesCart {
  int? id;
  int? salesId;
  String? menuId;
  String? name;
  int? amount;
  int? unitPrice;
  String? unit;
  int? totalPrice;
  bool? isPackage;
  String? createdBy;
  String? stockId;
  String? pic;
  String? priceCat;
  int? priceCatId;

  SalesCart(
      {this.id,
      this.salesId,
      this.menuId,
      this.name,
      this.amount,
      this.unitPrice,
      this.unit,
      this.totalPrice,
      this.isPackage,
      this.createdBy,
      this.stockId,
      this.pic,
      this.priceCat,
      this.priceCatId});

  SalesCart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    salesId = json['salesId'];
    menuId = json['menuId'];
    name = json['name'];
    amount = json['amount'];
    unitPrice = json['unitPrice'];
    unit = json['unit'];
    totalPrice = json['totalPrice'];
    isPackage = json['isPackage'];
    createdBy = json['createdBy'];
    stockId = json['stockId'];
    pic = json['pic'];
    priceCat = json['priceCat'];
    priceCatId = json['priceCatId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['salesId'] = this.salesId;
    data['menuId'] = this.menuId;
    data['name'] = this.name;
    data['amount'] = this.amount;
    data['unitPrice'] = this.unitPrice;
    data['unit'] = this.unit;
    data['totalPrice'] = this.totalPrice;
    data['isPackage'] = this.isPackage;
    data['createdBy'] = this.createdBy;
    data['stockId'] = this.stockId;
    data['pic'] = this.pic;
    data['priceCat'] = this.priceCat;
    data['priceCatId'] = this.priceCatId;
    return data;
  }
}
