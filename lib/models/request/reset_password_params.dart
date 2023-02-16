class ResetPasswordParams {
  String? newPassword;
  String? confirmNewPassword;
  int? user_id;

  ResetPasswordParams({this.newPassword, this.confirmNewPassword});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    map['password'] = newPassword;
    map['confirm_password'] = confirmNewPassword;
    // map['user_id'] = user_id;

    return map;
  }
}
