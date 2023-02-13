class PurchaseOrderList {
  int? id;
  List<PurchaseItems>? purchaseItems;
  String? billNumber;
  double? grandTotal;
  double? subTotal;
  double? taxAmount;
  double? discountAmount;
  double? discPercent;
  double? taxPercent;
  String? status;
  int? vendor;
  int? purchasedBy;
  String? createdAt;

  PurchaseOrderList(
      {this.id,
      this.purchaseItems,
      this.billNumber,
      this.grandTotal,
      this.subTotal,
      this.taxAmount,
      this.discountAmount,
      this.discPercent,
      this.taxPercent,
      this.status,
      this.vendor,
      this.purchasedBy,
      this.createdAt});

  PurchaseOrderList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['purchase_items'] != null) {
      purchaseItems = <PurchaseItems>[];
      json['purchase_items'].forEach((v) {
        purchaseItems!.add(new PurchaseItems.fromJson(v));
      });
    }
    billNumber = json['bill_number'];
    grandTotal = json['grand_total'];
    subTotal = json['sub_total'];
    taxAmount = json['tax_amount'];
    discountAmount = json['discount_amount'];
    discPercent = json['disc_percent'];
    taxPercent = json['tax_percent'];
    status = json['status'];
    vendor = json['vendor'];
    purchasedBy = json['purchased_by'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.purchaseItems != null) {
      data['purchase_items'] =
          this.purchaseItems!.map((v) => v.toJson()).toList();
    }
    data['bill_number'] = this.billNumber;
    data['grand_total'] = this.grandTotal;
    data['sub_total'] = this.subTotal;
    data['tax_amount'] = this.taxAmount;
    data['discount_amount'] = this.discountAmount;
    data['disc_percent'] = this.discPercent;
    data['tax_percent'] = this.taxPercent;
    data['status'] = this.status;
    data['vendor'] = this.vendor;
    data['purchased_by'] = this.purchasedBy;
    return data;
  }
}

class PurchaseItems {
  int? id;
  int? quantity;
  double? total;
  int? product;

  PurchaseItems({this.id, this.quantity, this.total, this.product});

  PurchaseItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    total = json['total'];
    product = json['product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    data['total'] = this.total;
    data['product'] = this.product;
    return data;
  }
}
