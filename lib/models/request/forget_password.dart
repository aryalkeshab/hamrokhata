class ForgetPasswordParams {
  String? email;

  ForgetPasswordParams({
    this.email,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    return map;
  }
}
