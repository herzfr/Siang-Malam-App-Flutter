// import 'package:siangmalam/models/product.dart';

// class Content {
//   int? id;
//   int? productId;
//   int? warehouseId;
//   int? quantity;
//   String? createdAt;
//   String? updatedAt;
//   String? createdBy;
//   String? updatedBy;
//   Product? product;
//   Product? warehouse;

//   Content(
//       {this.id,
//       this.productId,
//       this.warehouseId,
//       this.quantity,
//       this.createdAt,
//       this.updatedAt,
//       this.createdBy,
//       this.updatedBy,
//       this.product,
//       this.warehouse});

//   Content.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     productId = json['productId'];
//     warehouseId = json['warehouseId'];
//     quantity = json['quantity'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     createdBy = json['createdBy'];
//     updatedBy = json['updatedBy'];
//     product =
//         json['product'] != null ? Product.fromJson(json['product']) : null;
//     warehouse = json['warehouse'] != null
//         ? new Product.fromJson(json['warehouse'])
//         : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['productId'] = productId;
//     data['warehouseId'] = warehouseId;
//     data['quantity'] = quantity;
//     data['createdAt'] = createdAt;
//     data['updatedAt'] = updatedAt;
//     data['createdBy'] = createdBy;
//     data['updatedBy'] = updatedBy;
//     if (product != null) {
//       data['product'] = product!.toJson();
//     }
//     if (warehouse != null) {
//       data['warehouse'] = warehouse!.toJson();
//     }
//     return data;
//   }
// }
