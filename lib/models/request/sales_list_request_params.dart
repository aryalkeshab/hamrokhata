class SalesListRequestParams {
  String? status;
  String? customer;
  String? start_date;
  String? end_date;
  String? created_at;

  SalesListRequestParams(
      {this.status,
      this.customer,
      this.start_date,
      this.end_date,
      this.created_at});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (customer != null) {
      map['customer'] = customer;
    }
    if (status != null) {
      map['status'] = status;
    }
    if (start_date != null) {
      map['start_date'] = start_date;
    }
    if (end_date != null) {
      map['end_date'] = end_date;
    }
    if (created_at != null) {
      map['created_at'] = created_at;
    }
    return map;
  }
}
