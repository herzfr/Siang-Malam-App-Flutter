import 'package:siangmalam/models/purchase-order-product/po_products.dart';

class PoProductApprovalDto {
  String? orderNo;
  String? status;
  String? note;
  String? expenseStatus;
  List<ProductsList>? products;

  PoProductApprovalDto(
      {this.orderNo,
      this.status,
      this.note,
      this.expenseStatus,
      this.products});

  PoProductApprovalDto.fromJson(Map<String, dynamic> json) {
    orderNo = json['orderNo'];
    status = json['status'];
    note = json['note'];
    expenseStatus = json['expenseStatus'];
    if (json['products'] != null) {
      products = <ProductsList>[];
      json['products'].forEach((v) {
        products!.add(new ProductsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderNo'] = this.orderNo;
    data['status'] = this.status;
    data['note'] = this.note;
    data['expenseStatus'] = this.expenseStatus;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
