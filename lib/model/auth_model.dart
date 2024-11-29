class RegisterModel {
  String? fullname;
  String? email;
  String? password;
  String? contactNumber;
  String? token;

  RegisterModel({
    this.fullname,
    this.email,
    this.password,
    this.contactNumber,
    this.token,
  });

  RegisterModel.fromJson(Map<String, dynamic> json) {
    fullname = json['fullname'];
    email = json['email'];
    password = json['password'];
    token = json['token'];
    contactNumber = json['contactno'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fullname'] = fullname;
    data['email'] = email;
    data['password'] = password;
    data['contactno'] = contactNumber;
    data['token'] = token;

    return data;
  }
}
