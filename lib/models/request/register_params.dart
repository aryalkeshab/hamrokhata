class RegisterParams {
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? contactNumber;
  String? position;
  String? password2;

  RegisterParams({this.email, this.password});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['phone'] = contactNumber;
    map['position'] = position;
    map['email'] = email;
    map['username'] = email;
    map['password'] = password;
    map['password2'] = password2;
    return map;
  }
}
