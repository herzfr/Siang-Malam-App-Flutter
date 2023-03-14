import 'package:siangmalam/models/order/menu.dart';
import 'package:siangmalam/models/pageable.dart';

class MenuPackage {
  List<Package>? packagelist;
  Pageable? pageable;

  MenuPackage({this.packagelist, this.pageable});

  MenuPackage.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      packagelist = <Package>[];
      json['content'].forEach((v) {
        packagelist!.add(new Package.fromJson(v));
      });
    }
    pageable = json['pageable'] != null
        ? new Pageable.fromJson(json['pageable'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.packagelist != null) {
      data['content'] = this.packagelist!.map((v) => v.toJson()).toList();
    }
    if (this.pageable != null) {
      data['pageable'] = this.pageable!.toJson();
    }
    return data;
  }
}

class Package {
  String? id;
  bool? active;
  String? name;
  int? packageId;
  String? description;
  String? pic;
  List<Prices>? prices;
  List<ProductsPackage>? products;
  List<int>? stockIds;

  Package(
      {this.id,
      this.active,
      this.name,
      this.packageId,
      this.description,
      this.pic,
      this.prices,
      this.products,
      this.stockIds});

  Package.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    active = json['active'];
    name = json['name'];
    packageId = json['packageId'];
    description = json['description'];
    pic = json['pic'];
    if (json['prices'] != null) {
      prices = <Prices>[];
      json['prices'].forEach((v) {
        prices!.add(new Prices.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = <ProductsPackage>[];
      json['products'].forEach((v) {
        products!.add(new ProductsPackage.fromJson(v));
      });
    }
    stockIds = json['stockIds'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['active'] = this.active;
    data['name'] = this.name;
    data['packageId'] = this.packageId;
    data['description'] = this.description;
    data['pic'] = this.pic;
    if (this.prices != null) {
      data['prices'] = this.prices!.map((v) => v.toJson()).toList();
    }
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    data['stockIds'] = this.stockIds;
    return data;
  }
}

class ProductsPackage {
  String? name;
  int? quantity;

  ProductsPackage({this.name, this.quantity});

  ProductsPackage.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['quantity'] = this.quantity;
    return data;
  }
}
