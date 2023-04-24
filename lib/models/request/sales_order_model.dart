class SalesOrderRequestModel {
  int? grandTotal;
  int? subTotal;
  int? taxAmount;
  int? discountAmount;
  double? discPercent;
  int? taxPercent;
  String? status;
  String? customer;
  List<SalesItemsRequest>? salesItems;
  int? userId;

  SalesOrderRequestModel(
      {this.grandTotal,
      this.subTotal,
      this.taxAmount,
      this.discountAmount,
      this.discPercent,
      this.taxPercent,
      this.status,
      this.customer,
      this.userId,
      this.salesItems});

  SalesOrderRequestModel.fromJson(Map<String, dynamic> json) {
    grandTotal = json['grand_total'];
    subTotal = json['sub_total'];
    taxAmount = json['tax_amount'];
    discountAmount = json['discount_amount'];
    discPercent = json['disc_percent'];
    taxPercent = json['tax_percent'];
    status = json['status'];
    customer = json['customer'];
    if (json['sales_items'] != null) {
      salesItems = <SalesItemsRequest>[];
      json['sales_items'].forEach((v) {
        salesItems!.add(new SalesItemsRequest.fromJson(v));
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
    data['customer'] = this.customer!;

    data['sales_by'] = this.userId;

    if (this.salesItems != null) {
      data['sales_items'] = this.salesItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SalesItemsRequest {
  String? quantity;
  String? total;
  String? product;
  String? price;
  String? name;

  SalesItemsRequest({
    this.quantity,
    this.total,
    this.product,
    this.price,
    this.name,
  });

  SalesItemsRequest.fromJson(Map<String, dynamic> json) {
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

// class Customer {
//   int? name;

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
