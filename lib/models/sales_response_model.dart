class SalesResponseModel {
  String? msg;
  int? status;
  Data? data;

  SalesResponseModel({this.msg, this.status, this.data});

  SalesResponseModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  List<SalesItems>? salesItems;
  String? invoiceNumber;
  int? grandTotal;
  int? subTotal;
  int? taxAmount;
  int? discountAmount;
  int? discPercent;
  int? taxPercent;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? customer;

  Data(
      {this.id,
      this.salesItems,
      this.invoiceNumber,
      this.grandTotal,
      this.subTotal,
      this.taxAmount,
      this.discountAmount,
      this.discPercent,
      this.taxPercent,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.customer});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['sales_items'] != null) {
      salesItems = <SalesItems>[];
      json['sales_items'].forEach((v) {
        salesItems!.add(new SalesItems.fromJson(v));
      });
    }
    invoiceNumber = json['invoice_number'];
    grandTotal = json['grand_total'];
    subTotal = json['sub_total'];
    taxAmount = json['tax_amount'];
    discountAmount = json['discount_amount'];
    discPercent = json['disc_percent'];
    taxPercent = json['tax_percent'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    customer = json['customer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.salesItems != null) {
      data['sales_items'] = this.salesItems!.map((v) => v.toJson()).toList();
    }
    data['invoice_number'] = this.invoiceNumber;
    data['grand_total'] = this.grandTotal;
    data['sub_total'] = this.subTotal;
    data['tax_amount'] = this.taxAmount;
    data['discount_amount'] = this.discountAmount;
    data['disc_percent'] = this.discPercent;
    data['tax_percent'] = this.taxPercent;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['customer'] = this.customer;
    return data;
  }
}

class SalesItems {
  int? id;
  int? quantity;
  int? total;
  String? createdAt;
  String? updatedAt;
  int? product;

  SalesItems(
      {this.id,
      this.quantity,
      this.total,
      this.createdAt,
      this.updatedAt,
      this.product});

  SalesItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    total = json['total'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product = json['product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    data['total'] = this.total;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['product'] = this.product;
    return data;
  }
}
