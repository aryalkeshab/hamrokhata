class OtpParams {
  String? otp;
  int? user_id;

  OtpParams({this.otp, this.user_id});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['otp'] = otp;
    map['myuser'] = user_id;

    return map;
  }
}
