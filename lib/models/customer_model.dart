class CustomerModel {
  int? id;
  String? name;
  String? phone;
  String? email;
  String? createdAt;
  String? updatedAt;

  CustomerModel(
      {this.id,
      this.name,
      this.phone,
      this.email,
      this.createdAt,
      this.updatedAt});

  CustomerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
