class PurchaseListRequestParams {
  String? status;
  String? vendor;
  String? date;

  PurchaseListRequestParams({this.status, this.vendor, this.date});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    map['vendor'] = vendor;
    map['status'] = status;
    map['created_at'] = date;

    return map;
  }
}
