class SalesOrderModel {
  int? grandTotal;
  int? subTotal;
  int? taxAmount;
  int? discountAmount;
  int? discPercent;
  int? taxPercent;
  String? status;
  int? customer;
  List<SalesItems>? salesItems;

  SalesOrderModel(
      {this.grandTotal,
      this.subTotal,
      this.taxAmount,
      this.discountAmount,
      this.discPercent,
      this.taxPercent,
      this.status,
      this.customer,
      this.salesItems});

  SalesOrderModel.fromJson(Map<String, dynamic> json) {
    grandTotal = json['grand_total'];
    subTotal = json['sub_total'];
    taxAmount = json['tax_amount'];
    discountAmount = json['discount_amount'];
    discPercent = json['disc_percent'];
    taxPercent = json['tax_percent'];
    status = json['status'];
    customer = json['customer'];
    if (json['sales_items'] != null) {
      salesItems = <SalesItems>[];
      json['sales_items'].forEach((v) {
        salesItems!.add(new SalesItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['grand_total'] = this.grandTotal;
    data['sub_total'] = this.subTotal;
    data['tax_amount'] = this.taxAmount;
    data['discount_amount'] = this.discountAmount;
    data['disc_percent'] = this.discPercent;
    data['tax_percent'] = this.taxPercent;
    data['status'] = this.status;
    data['customer'] = this.customer;
    if (this.salesItems != null) {
      data['sales_items'] = this.salesItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SalesItems {
  String? quantity;
  String? total;
  String? product;
  String? price;

  SalesItems({this.quantity, this.total, this.product, this.price});

  SalesItems.fromJson(Map<String, dynamic> json) {
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
