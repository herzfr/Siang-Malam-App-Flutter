class MergeBill {
  String? name;
  String? note;
  String? waiter;
  List<int>? bills;

  MergeBill({this.name, this.note, this.waiter, this.bills});

  MergeBill.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    note = json['note'];
    waiter = json['waiter'];
    bills = json['bills'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['note'] = this.note;
    data['waiter'] = this.waiter;
    data['bills'] = this.bills;
    return data;
  }
}
