class ProductRequestModel {
  String? name;
  String? description;
  double? purchasePrice;
  double? sellingPrice;
  String? type;
  String? sku;
  int? currentStock;
  int? category;
  String? vendorName;

  ProductRequestModel(
      {this.name,
      this.description,
      this.purchasePrice,
      this.sellingPrice,
      this.type,
      this.sku,
      this.currentStock,
      this.category,
      this.vendorName});

  // ProductRequestModel.fromJson(Map<String, dynamic> json) {
  //   name = json['name'];
  //   description = json['description'];
  //   purchasePrice = json['purchase_price'];
  //   sellingPrice = json['selling_price'];
  //   type = json['type'];
  //   sku = json['sku'];
  //   currentStock = json['current_stock'];
  //   category = json['category'];
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['description'] = description;
    data['purchase_price'] = purchasePrice;
    data['selling_price'] = sellingPrice;
    data['type'] = type;
    data['sku'] = sku;
    data['current_stock'] = currentStock;
    data['category'] = category;
    data['vendor_name'] = vendorName;
    return data;
  }
}
