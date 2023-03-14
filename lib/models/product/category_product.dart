/* Created By Dwi Sutrisno */

class CategoryProduct {
  int? id;
  String? name;
  String? description;
  String? pic;

  CategoryProduct(
      {this.id,
        this.name,
        this.description,
        this.pic});

  CategoryProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    pic = json['pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['pic'] = pic;
    return data;
  }
}
