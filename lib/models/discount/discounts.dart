import 'package:siangmalam/models/discount/discount.dart';
import 'package:siangmalam/models/pageable.dart';

class Discounts {
  List<ListDiscount>? listdiscount;
  Pageable? pageable;

  Discounts({this.listdiscount, this.pageable});

  Discounts.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      listdiscount = <ListDiscount>[];
      json['content'].forEach((v) {
        listdiscount!.add(new ListDiscount.fromJson(v));
      });
    }
    pageable = json['pageable'] != null
        ? new Pageable.fromJson(json['pageable'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listdiscount != null) {
      data['content'] = this.listdiscount!.map((v) => v.toJson()).toList();
    }
    if (this.pageable != null) {
      data['pageable'] = this.pageable!.toJson();
    }
    return data;
  }
}
