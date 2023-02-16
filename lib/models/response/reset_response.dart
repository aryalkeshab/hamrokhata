class EmailResponse {
  String? status;
  String? userId;

  EmailResponse({this.status, this.userId});

  EmailResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['user_id'] = this.userId;
    return data;
  }
}

class UserIdEmailParams {
  int? user_id;
  String? email;
  bool? fromForgetPassword;

  UserIdEmailParams({this.user_id, this.email, this.fromForgetPassword});

  UserIdEmailParams.fromJson(Map<String, dynamic> json) {
    user_id = json['status'];
    email = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.email;
    data['user_id'] = this.email;
    return data;
  }
}
