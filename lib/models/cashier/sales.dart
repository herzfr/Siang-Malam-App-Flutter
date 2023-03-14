import 'package:siangmalam/models/cashier/payment.dart';

class SalesList {
  List<Sales>? listSalesAll;
  Pageable? pageable;

  SalesList({this.listSalesAll, this.pageable});

  SalesList.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      listSalesAll = <Sales>[];
      json['content'].forEach((v) {
        listSalesAll!.add(new Sales.fromJson(v));
      });
    }
    pageable = json['pageable'] != null
        ? new Pageable.fromJson(json['pageable'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listSalesAll != null) {
      data['content'] = this.listSalesAll!.map((v) => v.toJson()).toList();
    }
    if (this.pageable != null) {
      data['pageable'] = this.pageable!.toJson();
    }
    return data;
  }
}

class Sales {
  int? id;
  String? name;
  int? branchId;
  int? subBranchId;
  String? note;
  int? customerId;
  String? customerName;
  String? waiterName;
  String? waiterUserName;
  String? cashierName;
  String? cashierUserName;
  int? subTotal;
  int? discount;
  int? tax;
  int? service;
  int? refund;
  int? total;
  bool? isDineIn;
  String? status;
  String? paymentMethod;
  int? paymentTypeId;
  int? cash;
  int? change;
  int? createdAt;
  int? updatedAt;
  String? createdBy;
  String? updatedBy;
  int? tempSalesId;
  int? shiftId;
  String? imageProof;
  String? cardNo;
  String? merchantId;
  String? transactionNo;
  String? cardName;
  String? batchNo;
  double? adminFee;
  List<SalesItems>? items;

  Sales(
      {this.id,
      this.name,
      this.branchId,
      this.subBranchId,
      this.note,
      this.customerId,
      this.customerName,
      this.waiterName,
      this.waiterUserName,
      this.cashierName,
      this.cashierUserName,
      this.subTotal,
      this.discount,
      this.tax,
      this.service,
      this.refund,
      this.total,
      this.isDineIn,
      this.status,
      this.paymentMethod,
      this.paymentTypeId,
      this.cash,
      this.change,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy,
      this.tempSalesId,
      this.shiftId,
      this.imageProof,
      this.cardNo,
      this.merchantId,
      this.transactionNo,
      this.cardName,
      this.batchNo,
      this.adminFee,
      this.items});

  Sales.fromJson(Map<String, dynamic> json) {
    double dataFee = checkDouble(json['adminFee']);

    id = json['id'];
    name = json['name'];
    branchId = json['branchId'];
    subBranchId = json['subBranchId'];
    note = json['note'];
    customerId = json['customerId'];
    customerName = json['customerName'];
    waiterName = json['waiterName'];
    waiterUserName = json['waiterUserName'];
    cashierName = json['cashierName'];
    cashierUserName = json['cashierUserName'];
    subTotal = json['subTotal'];
    discount = json['discount'];
    tax = json['tax'];
    service = json['service'];
    refund = json['refund'];
    total = json['total'];
    isDineIn = json['isDineIn'];
    status = json['status'];
    paymentMethod = json['paymentMethod'];
    paymentTypeId = json['paymentTypeId'];
    cash = json['cash'];
    change = json['change'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    tempSalesId = json['tempSalesId'];
    shiftId = json['shiftId'];
    imageProof = json['imageProof'];
    cardNo = json['cardNo'];
    merchantId = json['merchantId'];
    transactionNo = json['transactionNo'];
    cardName = json['cardName'];
    batchNo = json['batchNo'];
    adminFee = dataFee;
    if (json['items'] != null) {
      items = <SalesItems>[];
      json['items'].forEach((v) {
        items!.add(SalesItems.fromJson(v));
      });
    }
  }

  double checkDouble(dynamic value) {
    if (value is int) {
      return double.parse(value.toString());
    } else {
      return value;
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
    data['waiterName'] = this.waiterName;
    data['waiterUserName'] = this.waiterUserName;
    data['cashierName'] = this.cashierName;
    data['cashierUserName'] = this.cashierUserName;
    data['subTotal'] = this.subTotal;
    data['discount'] = this.discount;
    data['tax'] = this.tax;
    data['service'] = this.service;
    data['refund'] = this.refund;
    data['total'] = this.total;
    data['isDineIn'] = this.isDineIn;
    data['status'] = this.status;
    data['paymentMethod'] = this.paymentMethod;
    data['paymentTypeId'] = this.paymentTypeId;
    data['cash'] = this.cash;
    data['change'] = this.change;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    data['tempSalesId'] = this.tempSalesId;
    data['shiftId'] = this.shiftId;
    data['imageProof'] = this.imageProof;
    data['cardNo'] = this.cardNo;
    data['merchantId'] = this.merchantId;
    data['transactionNo'] = this.transactionNo;
    data['cardName'] = this.cardName;
    data['batchNo'] = this.batchNo;
    data['adminFee'] = this.adminFee;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SalesItems {
  String? menuId;
  String? name;
  int? amount;
  int? unitPrice;
  String? unit;
  bool? isPackage;
  int? totalPrice;
  String? pic;
  String? priceCat;

  SalesItems(
      {this.menuId,
      this.name,
      this.amount,
      this.unitPrice,
      this.unit,
      this.isPackage,
      this.totalPrice,
      this.pic,
      this.priceCat});

  SalesItems.fromJson(Map<String, dynamic> json) {
    menuId = json['menuId'];
    name = json['name'];
    amount = json['amount'];
    unitPrice = json['unitPrice'];
    unit = json['unit'];
    isPackage = json['isPackage'];
    totalPrice = json['totalPrice'];
    pic = json['pic'];
    priceCat = json['priceCat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menuId'] = this.menuId;
    data['name'] = this.name;
    data['amount'] = this.amount;
    data['unitPrice'] = this.unitPrice;
    data['unit'] = this.unit;
    data['isPackage'] = this.isPackage;
    data['totalPrice'] = this.totalPrice;
    data['pic'] = this.pic;
    data['priceCat'] = this.priceCat;
    return data;
  }
}

class FilterGetListSales {
  int? size;
  int? page;
  int? branchId;
  int? subBranchId;
  String? search;
  String? status;
  String? option;
  int? startDate;
  int? endDate;

  FilterGetListSales(
      {this.size,
      this.page,
      this.branchId,
      this.subBranchId,
      this.search,
      this.status,
      this.option,
      this.startDate,
      this.endDate});

  FilterGetListSales.fromJson(Map<String, dynamic> json) {
    size = json['size'];
    page = json['page'];
    branchId = json['branchId'];
    subBranchId = json['subBranchId'];
    search = json['search'];
    status = json['status'];
    option = json['option'];
    startDate = json['startDate'];
    endDate = json['endDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['size'] = this.size;
    data['page'] = this.page;
    data['branchId'] = this.branchId;
    data['subBranchId'] = this.subBranchId;
    data['search'] = this.search;
    data['status'] = this.status;
    data['option'] = this.option;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    return data;
  }
}
