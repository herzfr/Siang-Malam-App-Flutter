class StockTransferDto {
  int? frmWarehouseId;
  int? destWarehouseId;
  List<Products>? products;

  StockTransferDto({this.frmWarehouseId, this.destWarehouseId, this.products});

  StockTransferDto.fromJson(Map<String, dynamic> json) {
    frmWarehouseId = json['frmWarehouseId'];
    destWarehouseId = json['destWarehouseId'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['frmWarehouseId'] = this.frmWarehouseId;
    data['destWarehouseId'] = this.destWarehouseId;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int? productId;
  int? quantity;

  Products({this.productId, this.quantity});

  Products.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['quantity'] = this.quantity;
    return data;
  }
}
