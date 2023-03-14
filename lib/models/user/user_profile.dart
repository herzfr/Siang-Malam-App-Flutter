/* Created By Dwi Sutrisno */

class UserProfileDto {
  String? userId;
  String? firstName;
  String? lastName;
  bool? gender;
  String? address1;
  String? address2;
  String? address3;
  String? phone;
  String? email;

  UserProfileDto(
      {this.userId,
      this.firstName,
      this.lastName,
      this.gender,
      this.address1,
      this.address2,
      this.address3,
      this.phone,
      this.email});

  UserProfileDto.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    gender = json['gender'];
    address1 = json['address1'];
    address2 = json['address2'];
    address3 = json['address3'];
    phone = json['phone'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['gender'] = gender;
    data['address1'] = address1;
    data['address2'] = address2;
    data['address3'] = address3;
    data['phone'] = phone;
    data['email'] = email;
    return data;
  }

}
