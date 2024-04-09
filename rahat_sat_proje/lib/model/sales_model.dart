class SoldProductsModel {
  String? id;
  String? categoryId;
  String? name;
  String? barcode;
  String? image;
  String? createdAt;
  String? updatedAt;

  SoldProductsModel({
    this.id,
    this.categoryId,
    this.name,
    this.barcode,
    this.image,
    this.createdAt,
    this.updatedAt,
  });
  SoldProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    categoryId = json['category_id']?.toString();
    name = json['name']?.toString();
    barcode = json['barcode']?.toString();
    image = json['image']?.toString();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['category_id'] = categoryId;
    data['name'] = name;
    data['barcode'] = barcode;
    data['image'] = image;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class SoldProductsModelListings {
  String? id;
  String? productId;
  String? marketId;
  int? stockCount;
  double? unitCost;
  int? taxRate;
  int? profitRate;
  double? totalPrice;
  String? createdAt;
  String? updatedAt;
  SoldProductsModel? product;

  SoldProductsModelListings({
    required this.id,
    required this.productId,
    required this.marketId,
    required this.stockCount,
    required this.unitCost,
    required this.taxRate,
    required this.profitRate,
    required this.totalPrice,
    required this.createdAt,
    required this.updatedAt,
    required this.product,
  });
  SoldProductsModelListings.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    productId = json['product_id']?.toString();
    marketId = json['market_id']?.toString();
    stockCount = json['stock_count']?.toInt();
    unitCost = json['unit_cost']?.toDouble();
    taxRate = json['tax_rate']?.toInt();
    profitRate = json['profit_rate']?.toInt();
    totalPrice = json['total_price']?.toDouble();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
    product = (json['product'] != null)
        ? SoldProductsModel.fromJson(json['product'])
        : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['market_id'] = marketId;
    data['stock_count'] = stockCount;
    data['unit_cost'] = unitCost;
    data['tax_rate'] = taxRate;
    data['profit_rate'] = profitRate;
    data['total_price'] = totalPrice;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (product != null) {
      data['product'] = product?.toJson();
    }
    return data;
  }
}

class SalesModel {
  List<SoldProductsModelListings>? productListings;
  int? total;
  int? perPage;
  int? page;

  SalesModel({
    this.productListings,
    this.total,
    this.perPage,
    this.page,
  });
  SalesModel.fromJson(Map<String, dynamic> json) {
    if (json['productListings'] != null) {
      final v = json['productListings'];
      final arr0 = <SoldProductsModelListings>[];
      v.forEach((v) {
        arr0.add(SoldProductsModelListings.fromJson(v));
      });
      productListings = arr0;
    }
    total = json['total']?.toInt();
    perPage = json['perPage']?.toInt();
    page = json['page']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (productListings != null) {
      final v = productListings;
      final arr0 = [];
      v?.forEach((v) {
        arr0.add(v.toJson());
      });
      data['productListings'] = arr0;
    }
    data['total'] = total;
    data['perPage'] = perPage;
    data['page'] = page;
    return data;
  }
}
