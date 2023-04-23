class PurchaseOrderModel {
  int? grandTotal;
  int? subTotal;
  int? taxAmount;
  int? discountAmount;
  int? discPercent;
  int? taxPercent;
  String? status;
  String? vendor;
  List<PurchaseItems>? purchaseItems;
  int? userId;

  PurchaseOrderModel(
      {this.grandTotal,
      this.subTotal,
      this.taxAmount,
      this.discountAmount,
      this.discPercent,
      this.taxPercent,
      this.status,
      this.vendor,
      this.purchaseItems,
      this.userId});

  PurchaseOrderModel.fromJson(Map<String, dynamic> json) {
    grandTotal = json['grand_total'];
    subTotal = json['sub_total'];
    taxAmount = json['tax_amount'];
    discountAmount = json['discount_amount'];
    discPercent = json['disc_percent'];
    taxPercent = json['tax_percent'];
    status = json['status'];
    vendor = json['vendor'];
    if (json['purchase_items'] != null) {
      purchaseItems = <PurchaseItems>[];
      json['purchase_items'].forEach((v) {
        purchaseItems!.add(new PurchaseItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['grand_total'] = this.grandTotal;
    // data['sub_total'] = this.subTotal;
    // data['tax_amount'] = this.taxAmount;
    // data['discount_amount'] = this.discountAmount;
    data['disc_percent'] = this.discPercent;
    data['tax_percent'] = this.taxPercent;
    data['status'] = this.status;
    // if (this.vendor != null) {
    data['vendor'] = this.vendor;
    // }
    data['purchased_by'] = this.userId;

    if (this.purchaseItems != null) {
      data['purchase_items'] =
          this.purchaseItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PurchaseItems {
  String? quantity;
  String? total;
  String? product;
  String? price;
  String? name;

  PurchaseItems(
      {this.quantity, this.total, this.product, this.price, this.name});

  PurchaseItems.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    total = json['total'];
    product = json['product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quantity'] = this.quantity;
    data['total'] = this.total;
    data['product'] = this.product;
    return data;
  }
}

// class Vendor {
//   int? name;

//   Vendor({this.name});

//   Vendor.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     return data;
//   }
// }
