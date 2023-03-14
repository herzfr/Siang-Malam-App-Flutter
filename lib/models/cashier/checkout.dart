class Checkout {
  int? tempSalesId;
  String? name;
  List<int>? tableIds;
  String? note;
  int? customerId;
  String? customerName;
  String? cashierUserName;
  String? cashierName;
  String? waiterName;
  String? waiterUserName;
  int? subTotal;
  int? discount;
  int? tax;
  int? service;
  int? total;
  String? paymentMethod;
  int? paymentTypeId;
  int? cash;
  int? change;
  bool? isDineIn;
  String? status;
  int? shiftId;
  String? transactionNo;
  String? merchantId;
  String? cardNo;
  String? cardName;
  String? batchNo;
  String? employeeUserName;
  String? image;
  double? adminFee;

  Checkout(
      {this.tempSalesId,
      this.name,
      this.tableIds,
      this.note,
      this.customerId,
      this.customerName,
      this.cashierUserName,
      this.cashierName,
      this.waiterName,
      this.waiterUserName,
      this.subTotal,
      this.discount,
      this.tax,
      this.service,
      this.total,
      this.paymentMethod,
      this.paymentTypeId,
      this.cash,
      this.change,
      this.isDineIn,
      this.status,
      this.shiftId,
      this.transactionNo,
      this.merchantId,
      this.cardNo,
      this.cardName,
      this.batchNo,
      this.employeeUserName,
      this.adminFee,
      this.image});

  Checkout.fromJson(Map<String, dynamic> json) {
    tempSalesId = json['tempSalesId'];
    name = json['name'];
    tableIds = json['tableIds'].cast<int>();
    note = json['note'];
    customerId = json['customerId'];
    customerName = json['customerName'];
    cashierUserName = json['cashierUserName'];
    cashierName = json['cashierName'];
    waiterName = json['waiterName'];
    waiterUserName = json['waiterUserName'];
    subTotal = json['subTotal'];
    discount = json['discount'];
    tax = json['tax'];
    service = json['service'];
    total = json['total'];
    paymentMethod = json['paymentMethod'];
    paymentTypeId = json['paymentTypeId'];
    cash = json['cash'];
    change = json['change'];
    isDineIn = json['isDineIn'];
    status = json['status'];
    shiftId = json['shiftId'];
    transactionNo = json['transactionNo'];
    merchantId = json['merchantId'];
    cardNo = json['cardNo'];
    cardName = json['cardName'];
    batchNo = json['batchNo'];
    employeeUserName = json['employeeUserName'];
    adminFee = json['adminFee'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tempSalesId'] = this.tempSalesId;
    data['name'] = this.name;
    data['tableIds'] = this.tableIds;
    data['note'] = this.note;
    data['customerId'] = this.customerId;
    data['customerName'] = this.customerName;
    data['cashierUserName'] = this.cashierUserName;
    data['cashierName'] = this.cashierName;
    data['waiterName'] = this.waiterName;
    data['waiterUserName'] = this.waiterUserName;
    data['subTotal'] = this.subTotal;
    data['discount'] = this.discount;
    data['tax'] = this.tax;
    data['service'] = this.service;
    data['total'] = this.total;
    data['paymentMethod'] = this.paymentMethod;
    data['paymentTypeId'] = this.paymentTypeId;
    data['cash'] = this.cash;
    data['change'] = this.change;
    data['isDineIn'] = this.isDineIn;
    data['status'] = this.status;
    data['shiftId'] = this.shiftId;
    data['transactionNo'] = this.transactionNo;
    data['merchantId'] = this.merchantId;
    data['cardNo'] = this.cardNo;
    data['cardName'] = this.cardName;
    data['batchNo'] = this.batchNo;
    data['employeeUserName'] = this.employeeUserName;
    data['adminFee'] = this.adminFee;
    data['image'] = this.image;
    return data;
  }
}
