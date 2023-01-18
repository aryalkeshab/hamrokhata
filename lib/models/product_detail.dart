class ProductSearchResponse {
  int? id;
  String? name;
  String? description;
  double? purchasePrice;
  double? sellingPrice;
  String? type;
  String? sku;
  String? image;
  int? currentStock;
  String? createdAt;
  String? updatedAt;
  int? category;

  ProductSearchResponse(
      {this.id,
      this.name,
      this.description,
      this.purchasePrice,
      this.sellingPrice,
      this.type,
      this.sku,
      this.image,
      this.currentStock,
      this.createdAt,
      this.updatedAt,
      this.category});

  ProductSearchResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    purchasePrice = json['purchase_price'];
    sellingPrice = json['selling_price'];
    type = json['type'];
    sku = json['sku'];
    image = json['image'];
    currentStock = json['current_stock'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    category = json['category'];
  }
}
