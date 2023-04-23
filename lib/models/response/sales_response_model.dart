class SalesOrderResponse {
  String? msg;
  int? status;
  Data? data;

  SalesOrderResponse({this.msg, this.status, this.data});

  SalesOrderResponse.fromJson(Map<String, dynamic> json) {
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
  String? sellingByName;
  String? customer;
  String? invoiceNumber;
  double? grandTotal;
  double? subTotal;
  double? taxAmount;
  double? discountAmount;
  double? discPercent;
  double? taxPercent;
  String? salesStatus;
  String? createdAt;
  String? updatedAt;
  int? salesBy;

  Data(
      {this.id,
      this.salesItems,
      this.sellingByName,
      this.invoiceNumber,
      this.customer,
      this.grandTotal,
      this.subTotal,
      this.taxAmount,
      this.discountAmount,
      this.discPercent,
      this.taxPercent,
      this.salesStatus,
      this.createdAt,
      this.updatedAt,
      this.salesBy});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['sales_items'] != null) {
      salesItems = <SalesItems>[];
      json['sales_items'].forEach((v) {
        salesItems!.add(new SalesItems.fromJson(v));
      });
    }

    sellingByName = json['selling_by_name'];
    customer = json['customer'];
    invoiceNumber = json['invoice_number'];
    grandTotal = json['grand_total'];
    subTotal = json['sub_total'];
    taxAmount = json['tax_amount'];
    discountAmount = json['discount_amount'];
    discPercent = json['disc_percent'];
    taxPercent = json['tax_percent'];
    salesStatus = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    salesBy = json['sales_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.salesItems != null) {
      data['sales_items'] = this.salesItems!.map((v) => v.toJson()).toList();
    }
    data['customer'] = this.customer;

    data['selling_by_name'] = this.sellingByName;
    data['invoice_number'] = this.invoiceNumber;
    data['grand_total'] = this.grandTotal;
    data['sub_total'] = this.subTotal;
    data['tax_amount'] = this.taxAmount;
    data['discount_amount'] = this.discountAmount;
    data['disc_percent'] = this.discPercent;
    data['tax_percent'] = this.taxPercent;
    data['status'] = this.salesStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['sales_by'] = this.salesBy;
    return data;
  }
}

class SalesItems {
  int? id;
  String? productName;
  String? sellingPrice;
  int? quantity;
  double? total;
  String? createdAt;
  String? updatedAt;
  int? product;

  SalesItems(
      {this.id,
      this.productName,
      this.sellingPrice,
      this.quantity,
      this.total,
      this.createdAt,
      this.updatedAt,
      this.product});

  SalesItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    sellingPrice = json['selling_price'];
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
    data['selling_price'] = this.sellingPrice;
    data['quantity'] = this.quantity;
    data['total'] = this.total;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['product'] = this.product;
    return data;
  }
}

// class Customer {
//   String? name;

//   Customer({this.name});

//   Customer.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     return data;
//   }
// }
