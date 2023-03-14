class SplitBill {
  int? tempSalesId;
  String? waiter;
  List<Bills>? bills;

  SplitBill({this.tempSalesId, this.waiter, this.bills});

  SplitBill.fromJson(Map<String, dynamic> json) {
    tempSalesId = json['tempSalesId'];
    waiter = json['waiter'];
    if (json['bills'] != null) {
      bills = <Bills>[];
      json['bills'].forEach((v) {
        bills!.add(new Bills.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tempSalesId'] = this.tempSalesId;
    data['waiter'] = this.waiter;
    if (this.bills != null) {
      data['bills'] = this.bills!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Bills {
  String? name;
  String? note;
  List<ItemsSplit> items = [];

  Bills({this.name, this.note});

  Bills.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    note = json['note'];
    if (json['items'] != null) {
      items = <ItemsSplit>[];
      json['items'].forEach((v) {
        items.add(new ItemsSplit.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['note'] = this.note;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ItemsSplit {
  int? id;
  int? amount;
  String? name;
  String? menuId;

  ItemsSplit({this.id, this.amount, this.name, this.menuId});

  ItemsSplit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    name = json['name'];
    menuId = json['menuId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['amount'] = this.amount;
    data['name'] = this.name;
    data['menuId'] = this.menuId;
    return data;
  }
}
