class SalesListRequestParams {
  String? status;
  String? customer;
  String? date;

  SalesListRequestParams({this.status, this.customer, this.date});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    if (customer != null || customer != "") map['customer'] = customer;
    if (status != null || status != "") map['status'] = status;
    if (date != null || date != "") map['created_at'] = date;

    return map;
  }
}
