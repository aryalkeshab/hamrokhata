class LoginParams {
  String? email;
  String? password;

  LoginParams({this.email, this.password});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['password'] = password;
    return map;
  }
}
