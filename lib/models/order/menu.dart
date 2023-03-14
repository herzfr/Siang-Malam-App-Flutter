import 'package:siangmalam/models/pageable.dart';

class MenuProduct {
  List<Menu>? menulist;
  Pageable? pageable;

  MenuProduct({this.menulist, this.pageable});

  MenuProduct.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      menulist = <Menu>[];
      json['content'].forEach((v) {
        menulist!.add(new Menu.fromJson(v));
      });
    }
    pageable = json['pageable'] != null
        ? new Pageable.fromJson(json['pageable'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.menulist != null) {
      data['content'] = this.menulist!.map((v) => v.toJson()).toList();
    }
    if (this.pageable != null) {
      data['pageable'] = this.pageable!.toJson();
    }
    return data;
  }
}

class Menu {
  String? id;
  bool? active;
  int? branchId;
  String? branchName;
  int? productId;
  String? name;
  String? description;
  String? size;
  String? unit;
  String? pic;
  int? quantity;
  int? stockId;
  List<Prices>? prices;

  Menu(
      {this.id,
      this.active,
      this.branchId,
      this.branchName,
      this.productId,
      this.name,
      this.description,
      this.size,
      this.unit,
      this.pic,
      this.quantity,
      this.stockId,
      this.prices});

  Menu.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    active = json['active'];
    branchId = json['branchId'];
    branchName = json['branchName'];
    productId = json['productId'];
    name = json['name'];
    description = json['description'];
    size = json['size'];
    unit = json['unit'];
    pic = json['pic'];
    quantity = json['quantity'];
    stockId = json['stockId'];
    if (json['prices'] != null) {
      prices = <Prices>[];
      json['prices'].forEach((v) {
        prices!.add(new Prices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['active'] = this.active;
    data['branchId'] = this.branchId;
    data['branchName'] = this.branchName;
    data['productId'] = this.productId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['size'] = this.size;
    data['unit'] = this.unit;
    data['pic'] = this.pic;
    data['quantity'] = this.quantity;
    data['stockId'] = this.stockId;
    if (this.prices != null) {
      data['prices'] = this.prices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Prices {
  int? price;
  String? priceCategory;

  Prices({this.price, this.priceCategory});

  Prices.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    priceCategory = json['priceCategory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['priceCategory'] = this.priceCategory;
    return data;
  }
}
