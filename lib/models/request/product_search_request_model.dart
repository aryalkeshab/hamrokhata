class ProductSearchRequestModel {
  String? sku;
  String? name;
  ProductSearchRequestModel({this.sku, this.name});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    // if (name!.isNotEmpty) {
    data['name'] = name;
    // }
    // if (sku!.isNotEmpty) {
    data['sku'] = sku;
    // }

    return data;
  }
}
