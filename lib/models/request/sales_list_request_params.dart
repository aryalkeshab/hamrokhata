class SalesListRequestParams {
  String? status;
  String? customer;
  String? date;
  String? start_date;
  String? end_date;

  SalesListRequestParams(
      {this.status, this.customer, this.date, this.start_date, this.end_date});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (customer != null || customer != "") map['customer'] = customer;
    if (status != null || status != "") map['status'] = status;
    if (date != null || date != "") map['created_at'] = date;
    if (start_date != null || date != "") map['start_date'] = start_date;
    if (end_date != null || date != "") map['end_date'] = date;
    return map;
  }
}
