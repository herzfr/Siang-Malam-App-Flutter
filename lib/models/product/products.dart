import 'package:siangmalam/models/product/category_product.dart';


class Product {
  int? id;
  String? name;
  String? description;
  String? size;
  String? unit;
  String? pic;
  CategoryProduct? product_category;

  Product({this.id,
    this.name,
    this.description,
    this.size,
    this.unit,
    this.pic,
    this.product_category});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    size = json['size'];
    unit = json['unit'];
    pic = json['pic'];
    product_category = json['product_category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['size'] = size;
    data['unit'] = unit;
    data['pic'] = pic;
    data['product_category'] = product_category;
    return data;
  }
}

