class RegisterParams {
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? contactNumber;
  String? nationalId;

  RegisterParams({this.email, this.password});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['contactNumber'] = contactNumber;
    map['nationalId'] = nationalId;

    map['email'] = email;
    map['password'] = password;
    return {"user": map};
  }
}
