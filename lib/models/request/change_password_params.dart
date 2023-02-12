class ChangePasswordParams {
  String? oldPassword;

  String? newPassword;
  String? confirmNewPassword;
  String? id;

  ChangePasswordParams(
      {this.oldPassword, this.newPassword, this.confirmNewPassword});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['old_password'] = oldPassword;
    map['new_password'] = newPassword;
    map['new_confirm_password'] = confirmNewPassword;
    return map;
  }
}
