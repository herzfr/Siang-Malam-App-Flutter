import 'package:siangmalam/models/cashier/payment.dart';

class Transfer {
  List<TransferList>? transferlist;
  Pageable? pageable;

  Transfer({this.transferlist, this.pageable});

  Transfer.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      transferlist = <TransferList>[];
      json['content'].forEach((v) {
        transferlist!.add(new TransferList.fromJson(v));
      });
    }
    pageable = json['pageable'] != null
        ? new Pageable.fromJson(json['pageable'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.transferlist != null) {
      data['content'] = this.transferlist!.map((v) => v.toJson()).toList();
    }
    if (this.pageable != null) {
      data['pageable'] = this.pageable!.toJson();
    }
    return data;
  }
}

class TransferList {
  int? id;
  int? frmWarehouseId;
  int? destWarehouseId;
  String? note;
  bool? isSenderApproved;
  bool? isReceiverApproved;
  String? sendBy;
  String? receiveBy;
  String? sendApprover;
  String? receiveApprover;
  bool? isCanceled;
  bool? isDelivery;
  bool? isBack;
  bool? isDone;
  int? createdAt;
  int? updatedAt;
  String? createdBy;
  String? updatedBy;
  List<ProductsTransfer>? products;

  TransferList(
      {this.id,
      this.frmWarehouseId,
      this.destWarehouseId,
      this.note,
      this.isSenderApproved,
      this.isReceiverApproved,
      this.sendBy,
      this.receiveBy,
      this.sendApprover,
      this.receiveApprover,
      this.isDelivery,
      this.isCanceled,
      this.isBack,
      this.isDone,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy,
      this.products});

  TransferList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    frmWarehouseId = json['frmWarehouseId'];
    destWarehouseId = json['destWarehouseId'];
    note = json['note'];
    isSenderApproved = json['isSenderApproved'];
    isReceiverApproved = json['isReceiverApproved'];
    sendBy = json['sendBy'];
    receiveBy = json['receiveBy'];
    sendApprover = json['sendApprover'];
    receiveApprover = json['receiveApprover'] ?? '';
    isDelivery = json['isDelivery'];
    isCanceled = json['isCanceled'];
    isBack = json['isBack'];
    isDone = json['isDone'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    if (json['products'] != null) {
      products = <ProductsTransfer>[];
      json['products'].forEach((v) {
        products!.add(new ProductsTransfer.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['frmWarehouseId'] = this.frmWarehouseId;
    data['destWarehouseId'] = this.destWarehouseId;
    data['note'] = this.note;
    data['isSenderApproved'] = this.isSenderApproved;
    data['isReceiverApproved'] = this.isReceiverApproved;
    data['sendBy'] = this.sendBy;
    data['receiveBy'] = this.receiveBy;
    data['sendApprover'] = this.sendApprover;
    data['receiveApprover'] = this.receiveApprover;
    data['isDelivery'] = this.isDelivery;
    data['isCanceled'] = this.isCanceled;
    data['isBack'] = this.isBack;
    data['isDone'] = this.isDone;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductsTransfer {
  int? id;
  int? productId;
  int? quantity;
  String? name;

  ProductsTransfer({this.id, this.productId, this.quantity});

  ProductsTransfer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['productId'];
    quantity = json['quantity'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['productId'] = this.productId;
    data['quantity'] = this.quantity;
    data['name'] = this.name;
    return data;
  }
}

class FilterTransferList {
  int? page;
  int? size;
  int? branchId;
  String? search;
  int? subBranchId;
  int? startDate;
  int? endDate;

  FilterTransferList(
      {this.page,
      this.size,
      this.branchId,
      this.search,
      this.subBranchId,
      this.startDate,
      this.endDate});

  FilterTransferList.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    size = json['size'];
    branchId = json['branchId'];
    search = json['search'];
    subBranchId = json['subBranchId'];
    startDate = json['startDate'];
    endDate = json['endDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['size'] = this.size;
    data['branchId'] = this.branchId;
    data['search'] = this.search;
    data['subBranchId'] = this.subBranchId;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    return data;
  }
}
