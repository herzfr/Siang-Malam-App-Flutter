class SuplierDto {
  int? id;
  String? name;
  String? address1;
  String? address2;
  String? address3;
  String? phone;
  String? email;

  SuplierDto(
      {this.id,
      this.name,
      this.address1,
      this.address2,
      this.address3,
      this.phone,
      this.email});

  SuplierDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address1 = json['address1'];
    address2 = json['address2'];
    address3 = json['address3'];
    phone = json['phone'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['address3'] = this.address3;
    data['phone'] = this.phone;
    data['email'] = this.email;
    return data;
  }
}
