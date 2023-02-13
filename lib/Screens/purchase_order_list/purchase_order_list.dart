class PurchaseOrderList {
  int? id;
  String? purchaseByName;
  List<PurchaseItems>? purchaseItems;
  String? vendor;
  String? billNumber;
  double? grandTotal;
  double? subTotal;
  double? taxAmount;
  double? discountAmount;
  double? discPercent;
  double? taxPercent;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? purchasedBy;

  PurchaseOrderList(
      {this.id,
      this.purchaseByName,
      this.purchaseItems,
      this.vendor,
      this.billNumber,
      this.grandTotal,
      this.subTotal,
      this.taxAmount,
      this.discountAmount,
      this.discPercent,
      this.taxPercent,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.purchasedBy});

  PurchaseOrderList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    purchaseByName = json['purchase_by_name'];
    if (json['purchase_items'] != null) {
      purchaseItems = <PurchaseItems>[];
      json['purchase_items'].forEach((v) {
        purchaseItems!.add(new PurchaseItems.fromJson(v));
      });
    }
    vendor = json['vendor'];
    billNumber = json['bill_number'];
    grandTotal = json['grand_total'];
    subTotal = json['sub_total'];
    taxAmount = json['tax_amount'];
    discountAmount = json['discount_amount'];
    discPercent = json['disc_percent'];
    taxPercent = json['tax_percent'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    purchasedBy = json['purchased_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['purchase_by_name'] = this.purchaseByName;
    if (this.purchaseItems != null) {
      data['purchase_items'] =
          this.purchaseItems!.map((v) => v.toJson()).toList();
    }
    data['vendor'] = this.vendor;
    data['bill_number'] = this.billNumber;
    data['grand_total'] = this.grandTotal;
    data['sub_total'] = this.subTotal;
    data['tax_amount'] = this.taxAmount;
    data['discount_amount'] = this.discountAmount;
    data['disc_percent'] = this.discPercent;
    data['tax_percent'] = this.taxPercent;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['purchased_by'] = this.purchasedBy;
    return data;
  }
}

class PurchaseItems {
  int? id;
  String? productName;
  String? purchasePrice;
  int? quantity;
  double? total;
  String? createdAt;
  String? updatedAt;
  int? product;

  PurchaseItems(
      {this.id,
      this.productName,
      this.purchasePrice,
      this.quantity,
      this.total,
      this.createdAt,
      this.updatedAt,
      this.product});

  PurchaseItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    purchasePrice = json['purchase_price'];
    quantity = json['quantity'];
    total = json['total'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product = json['product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_name'] = this.productName;
    data['purchase_price'] = this.purchasePrice;
    data['quantity'] = this.quantity;
    data['total'] = this.total;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['product'] = this.product;
    return data;
  }
}
