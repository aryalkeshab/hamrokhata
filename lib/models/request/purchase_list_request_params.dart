class PurchaseListRequestParams {
  String? status;
  String? vendor;
  String? date;
  String? start_date;
  String? end_date;

  PurchaseListRequestParams(
      {this.status, this.vendor, this.date, this.start_date, this.end_date});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    map['vendor'] = vendor;
    map['status'] = "Completed";
    map['created_at'] = date;
    map['start_date'] = start_date;
    map['end_date'] = end_date;

    return map;
  }
}
