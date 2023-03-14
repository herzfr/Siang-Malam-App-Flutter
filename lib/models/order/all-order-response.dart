import 'package:siangmalam/models/order/create-order-response.dart';
import 'package:siangmalam/models/pageable.dart';

class AllOrderRes {
  List<CreateOrderResponse>? allOrderList;
  Pageable? pageable;

  AllOrderRes({this.allOrderList, this.pageable});

  AllOrderRes.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      allOrderList = <CreateOrderResponse>[];
      json['content'].forEach((v) {
        allOrderList!.add(new CreateOrderResponse.fromJson(v));
      });
    }
    pageable = json['pageable'] != null
        ? new Pageable.fromJson(json['pageable'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.allOrderList != null) {
      data['content'] = this.allOrderList!.map((v) => v.toJson()).toList();
    }
    if (this.pageable != null) {
      data['pageable'] = this.pageable!.toJson();
    }
    return data;
  }
}
