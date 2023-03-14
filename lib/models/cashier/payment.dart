// import 'package:logger/logger.dart';

class PaymentCustomList {
  List<PaymentCustom>? paymentCustList;
  Pageable? pageable;

  PaymentCustomList({this.paymentCustList, this.pageable});

  PaymentCustomList.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      paymentCustList = <PaymentCustom>[];
      json['content'].forEach((v) {
        paymentCustList!.add(new PaymentCustom.fromJson(v));
      });
    }
    pageable = json['pageable'] != null
        ? new Pageable.fromJson(json['pageable'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.paymentCustList != null) {
      data['content'] = this.paymentCustList!.map((v) => v.toJson()).toList();
    }
    if (this.pageable != null) {
      data['pageable'] = this.pageable!.toJson();
    }
    return data;
  }
}

class PaymentCustom {
  int? id;
  String? name;
  String? description;
  String? createdAt;
  String? accountNo;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;
  String? type;
  double? adminFee;

  PaymentCustom(
      {this.id,
      this.name,
      this.description,
      this.createdAt,
      this.accountNo,
      this.updatedAt,
      this.createdBy,
      this.updatedBy,
      this.type,
      this.adminFee});

  PaymentCustom.fromJson(Map<String, dynamic> json) {
    double dataFee = checkDouble(json['adminFee']);

    id = json['id'];
    name = json['name'];
    description = json['description'];
    createdAt = json['createdAt'];
    accountNo = json['accountNo'];
    updatedAt = json['updatedAt'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    type = json['type'];
    adminFee = dataFee;
  }

  double checkDouble(dynamic value) {
    if (value is int) {
      return double.parse(value.toString());
    } else {
      return value;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['createdAt'] = this.createdAt;
    data['accountNo'] = this.accountNo;
    data['updatedAt'] = this.updatedAt;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    data['type'] = this.type;
    data['adminFee'] = this.adminFee;
    return data;
  }
}

class Pageable {
  int? totalElements;
  int? totalPage;
  int? pageNumber;
  int? pageSize;

  Pageable(
      {this.totalElements, this.totalPage, this.pageNumber, this.pageSize});

  Pageable.fromJson(Map<String, dynamic> json) {
    totalElements = json['totalElements'];
    totalPage = json['totalPage'];
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalElements'] = this.totalElements;
    data['totalPage'] = this.totalPage;
    data['pageNumber'] = this.pageNumber;
    data['pageSize'] = this.pageSize;
    return data;
  }
}

class GetPaymentCust {
  int? size;
  int? page;
  String? search;
  String? type;
  String? option;

  GetPaymentCust({this.size, this.page, this.search, this.type, this.option});

  GetPaymentCust.fromJson(Map<String, dynamic> json) {
    size = json['size'];
    page = json['page'];
    search = json['search'];
    type = json['type'];
    option = json['option'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['size'] = this.size;
    data['page'] = this.page;
    data['search'] = this.search;
    data['type'] = this.type;
    data['option'] = this.option;
    return data;
  }
}

class ImageEwalletRequestDto {
  String fileName;
  String filePath;

  ImageEwalletRequestDto({required this.fileName, required this.filePath});
}
