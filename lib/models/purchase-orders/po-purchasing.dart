class DetailPurchasing {
  Purchase? purchaseProduct;
  Purchase? purchaseItem;
  List<ExpensesPurchasing>? expensespurchasing;

  DetailPurchasing(
      {this.purchaseProduct, this.expensespurchasing, this.purchaseItem});

  DetailPurchasing.fromJson(Map<String, dynamic> json) {
    purchaseProduct = json['purchaseProduct'] != null
        ? new Purchase.fromJson(json['purchaseProduct'])
        : null;
    purchaseItem = json['purchaseItem'] != null
        ? new Purchase.fromJson(json['purchaseItem'])
        : null;
    if (json['expenses'] != null) {
      expensespurchasing = <ExpensesPurchasing>[];
      json['expenses'].forEach((v) {
        expensespurchasing!.add(new ExpensesPurchasing.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.purchaseProduct != null) {
      data['purchaseProduct'] = this.purchaseProduct!.toJson();
    }
    if (this.purchaseItem != null) {
      data['purchaseItem'] = this.purchaseItem!.toJson();
    }
    if (this.expensespurchasing != null) {
      data['expenses'] =
          this.expensespurchasing!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Purchase {
  int? id;
  String? note;
  String? orderNo;
  String? paidStatus;
  String? status;
  String? receiptPath;
  String? receiptPic;
  String? proofPath;
  String? proofPic;
  int? suplierId;
  int? warehouseId;
  int? expensesId;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;
  int? paid;
  int? remaining;
  int? totalCost;

  Purchase(
      {this.id,
      this.note,
      this.orderNo,
      this.paidStatus,
      this.status,
      this.receiptPath,
      this.receiptPic,
      this.proofPath,
      this.proofPic,
      this.suplierId,
      this.warehouseId,
      this.expensesId,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy,
      this.paid,
      this.remaining,
      this.totalCost});

  Purchase.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    note = json['note'];
    orderNo = json['orderNo'];
    paidStatus = json['paidStatus'];
    status = json['status'];
    receiptPath = json['receiptPath'];
    receiptPic = json['receiptPic'];
    proofPath = json['proofPath'];
    proofPic = json['proofPic'];
    suplierId = json['suplierId'];
    warehouseId = json['warehouseId'];
    expensesId = json['expensesId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    paid = json['paid'];
    remaining = json['remaining'];
    totalCost = json['totalCost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['note'] = this.note;
    data['orderNo'] = this.orderNo;
    data['paidStatus'] = this.paidStatus;
    data['status'] = this.status;
    data['receiptPath'] = this.receiptPath;
    data['receiptPic'] = this.receiptPic;
    data['proofPath'] = this.proofPath;
    data['proofPic'] = this.proofPic;
    data['suplierId'] = this.suplierId;
    data['warehouseId'] = this.warehouseId;
    data['expensesId'] = this.expensesId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    data['paid'] = this.paid;
    data['remaining'] = this.remaining;
    data['totalCost'] = this.totalCost;
    return data;
  }
}

class ExpensesPurchasing {
  int? id;
  String? note;
  String? pic;
  String? picPath;
  int? branchId;
  int? subBranchId;
  int? cost;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;
  String? type;
  int? shiftId;
  int? poId;
  int? poItemsId;
  String? expenseType;
  int? paymentTypeId;

  ExpensesPurchasing(
      {this.id,
      this.note,
      this.pic,
      this.picPath,
      this.branchId,
      this.subBranchId,
      this.cost,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy,
      this.type,
      this.shiftId,
      this.poId,
      this.poItemsId,
      this.expenseType,
      this.paymentTypeId});

  ExpensesPurchasing.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    note = json['note'];
    pic = json['pic'];
    picPath = json['picPath'];
    branchId = json['branchId'];
    subBranchId = json['subBranchId'];
    cost = json['cost'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    type = json['type'];
    shiftId = json['shiftId'];
    poId = json['poId'];
    poItemsId = json['poItemsId'];
    expenseType = json['expenseType'];
    paymentTypeId = json['paymentTypeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['note'] = this.note;
    data['pic'] = this.pic;
    data['picPath'] = this.picPath;
    data['branchId'] = this.branchId;
    data['subBranchId'] = this.subBranchId;
    data['cost'] = this.cost;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    data['type'] = this.type;
    data['shiftId'] = this.shiftId;
    data['poId'] = this.poId;
    data['poItemsId'] = this.poItemsId;
    data['expenseType'] = this.expenseType;
    data['paymentTypeId'] = this.paymentTypeId;
    return data;
  }
}

class PaymentPo {
  int? orderNo;
  int? amount;
  String? expenseType;
  int? paymentTypeId;
  String? transactionNo;
  String? cardName;
  String? cardNo;
  String? batchNo;
  String? merchantId;

  PaymentPo(
      {this.orderNo,
      this.amount,
      this.expenseType,
      this.paymentTypeId,
      this.transactionNo,
      this.cardName,
      this.cardNo,
      this.batchNo,
      this.merchantId});

  PaymentPo.fromJson(Map<String, dynamic> json) {
    orderNo = json['orderNo'];
    amount = json['amount'];
    expenseType = json['expenseType'];
    paymentTypeId = json['paymentTypeId'];
    transactionNo = json['transactionNo'];
    cardName = json['cardName'];
    cardNo = json['cardNo'];
    batchNo = json['batchNo'];
    merchantId = json['merchantId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderNo'] = this.orderNo;
    data['amount'] = this.amount;
    data['expenseType'] = this.expenseType;
    data['paymentTypeId'] = this.paymentTypeId;
    data['transactionNo'] = this.transactionNo;
    data['cardName'] = this.cardName;
    data['cardNo'] = this.cardNo;
    data['batchNo'] = this.batchNo;
    data['merchantId'] = this.merchantId;
    return data;
  }
}
