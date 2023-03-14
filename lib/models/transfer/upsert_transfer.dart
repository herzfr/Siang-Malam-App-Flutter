class UpsertTransfer {
  int? id;
  int? frmWarehouseId;
  int? destWarehouseId;
  String? note;
  List<ProductsUpsertTransfer>? products;
  bool? isDelivery;
  bool? isSenderApproved;
  bool? isReceiverApproved;
  String? sendBy;
  String? sendApprover;
  String? receiveBy;
  String? receiveApprover;
  bool? isBack;

  UpsertTransfer(
      {this.id,
      this.frmWarehouseId,
      this.destWarehouseId,
      this.note,
      this.products,
      this.isDelivery,
      this.isSenderApproved,
      this.isReceiverApproved,
      this.sendBy,
      this.sendApprover,
      this.receiveBy,
      this.receiveApprover,
      this.isBack});

  UpsertTransfer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    frmWarehouseId = json['frmWarehouseId'];
    destWarehouseId = json['destWarehouseId'];
    note = json['note'];
    if (json['products'] != null) {
      products = <ProductsUpsertTransfer>[];
      json['products'].forEach((v) {
        products!.add(new ProductsUpsertTransfer.fromJson(v));
      });
    }
    isDelivery = json['isDelivery'];
    isSenderApproved = json['isSenderApproved'];
    isReceiverApproved = json['isReceiverApproved'];
    sendBy = json['sendBy'];
    sendApprover = json['sendApprover'];
    receiveBy = json['receiveBy'];
    receiveApprover = json['receiveApprover'];
    isBack = json['isBack'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['frmWarehouseId'] = this.frmWarehouseId;
    data['destWarehouseId'] = this.destWarehouseId;
    data['note'] = this.note;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    data['isDelivery'] = this.isDelivery;
    data['isSenderApproved'] = this.isSenderApproved;
    data['isReceiverApproved'] = this.isReceiverApproved;
    data['sendBy'] = this.sendBy;
    data['sendApprover'] = this.sendApprover;
    data['receiveBy'] = this.receiveBy;
    data['receiveApprover'] = this.receiveApprover;
    data['isBack'] = this.isBack;
    return data;
  }
}

class ProductsUpsertTransfer {
  int? id;
  int? productId;
  int? quantityFrom;
  int? quantity;
  String? name;
  String? unit;

  ProductsUpsertTransfer({this.id, this.productId, this.quantity});

  ProductsUpsertTransfer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['productId'];
    quantityFrom = json['quantityFrom'];
    quantity = json['quantity'];
    name = json['name'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['productId'] = this.productId;
    data['quantityFrom'] = this.quantityFrom;
    data['quantity'] = this.quantity;
    data['name'] = this.name;
    data['unit'] = this.unit;
    return data;
  }
}

class CancelTransfer {
  int? id;
  bool? isCanceled;

  CancelTransfer({this.id, this.isCanceled});

  CancelTransfer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isCanceled = json['isCanceled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['isCanceled'] = this.isCanceled;
    return data;
  }
}
