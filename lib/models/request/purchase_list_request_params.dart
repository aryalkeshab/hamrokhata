class PurchaseListRequestParams {
  String? status;
  String? vendor;
  String? start_date;
  String? end_date;
  String? created_at;

  PurchaseListRequestParams(
      {this.status,
      this.vendor,
      this.start_date,
      this.end_date,
      this.created_at});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    if (vendor != null) {
      map['vendor'] = vendor;
    }
    if (start_date != null) {
      map['start_date'] = start_date;
    }
    if (end_date != null) {
      map['end_date'] = end_date;
    }
    if (status != null) {
      map['status'] = status;
    }

    if (created_at != null) {
      map['created_at'] = created_at;
    }

    return map;
  }
}
