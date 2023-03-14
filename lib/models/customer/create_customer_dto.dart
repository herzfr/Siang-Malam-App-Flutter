class CreateCustomerDto {
  String? name;
  String? address1;
  String? address2;
  String? address3;
  String? phone;

  CreateCustomerDto(
      {this.name, this.address1, this.address2, this.address3, this.phone});

  CreateCustomerDto.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address1 = json['address1'];
    address2 = json['address2'];
    address3 = json['address3'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['address3'] = this.address3;
    data['phone'] = this.phone;
    return data;
  }
}
