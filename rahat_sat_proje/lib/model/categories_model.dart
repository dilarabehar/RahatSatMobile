class CategoriesModels {

  String? id;
  String? categoryId;
  String? name;
  String? barcode;
  String? image;
  String? createdAt;
  String? updatedAt;

  CategoriesModels({
    this.id,
    this.categoryId,
    this.name,
    this.barcode,
    this.image,
    this.createdAt,
    this.updatedAt,
  });
  CategoriesModels.fromJson(Map<String, dynamic> json) {
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

class CategoriesModelsListing {
/*
{
  "id": "6096fd9b-88c3-47f3-a552-edabc646eb38",
  "name": "Et, Tavuk, Balık",
  "image": "",
  "created_at": "2023-09-08T20:34:51.000000Z",
  "updated_at": "2023-09-08T20:38:25.000000Z",
  "products": [
    {
      "id": "96b74539-ae2e-4c7d-a378-94d8e4abebe4",
      "category_id": "6096fd9b-88c3-47f3-a552-edabc646eb38",
      "name": "Torku Sucuk Vakum 225 G",
      "barcode": "8680181001984",
      "image": "productImages/8680181001984.jpeg",
      "created_at": "2023-09-08T20:50:26.000000Z",
      "updated_at": "2023-09-08T21:03:42.000000Z"
    }
  ]
}
*/

  String? id;
  String? name;
  String? image;
  String? createdAt;
  String? updatedAt;
  List<CategoriesModels>? products;

  CategoriesModelsListing({
    this.id,
    this.name,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.products,
  });
  CategoriesModelsListing.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    name = json['name']?.toString();
    image = json['image']?.toString();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
  if (json['products'] != null) {
  final v = json['products'];
  final arr0 = <CategoriesModels>[];
  v.forEach((v) {
  arr0.add(CategoriesModels.fromJson(v));
  });
    products = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (products != null) {
      final v = products;
      final arr0 = [];
  v?.forEach((v) {
  arr0.add(v.toJson());
  });
      data['products'] = arr0;
    }
    return data;
  }
}

class CategoriesModel {
/*
{
  "categories": [
    {
      "id": "6096fd9b-88c3-47f3-a552-edabc646eb38",
      "name": "Et, Tavuk, Balık",
      "image": "",
      "created_at": "2023-09-08T20:34:51.000000Z",
      "updated_at": "2023-09-08T20:38:25.000000Z",
      "products": [
        {
          "id": "96b74539-ae2e-4c7d-a378-94d8e4abebe4",
          "category_id": "6096fd9b-88c3-47f3-a552-edabc646eb38",
          "name": "Torku Sucuk Vakum 225 G",
          "barcode": "8680181001984",
          "image": "productImages/8680181001984.jpeg",
          "created_at": "2023-09-08T20:50:26.000000Z",
          "updated_at": "2023-09-08T21:03:42.000000Z"
        }
      ]
    }
  ],
  "total": 18,
  "perPage": 10,
  "page": 1
}
*/

  List<CategoriesModelsListing>? categories;
  int? total;
  int? perPage;
  int? page;

  CategoriesModel({
    this.categories,
    this.total,
    this.perPage,
    this.page,
  });
  CategoriesModel.fromJson(Map<String, dynamic> json) {
  if (json['categories'] != null) {
  final v = json['categories'];
  final arr0 = <CategoriesModelsListing>[];
  v.forEach((v) {
  arr0.add(CategoriesModelsListing.fromJson(v));
  });
    categories = arr0;
    }
    total = json['total']?.toInt();
    perPage = json['perPage']?.toInt();
    page = json['page']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (categories != null) {
      final v = categories;
      final arr0 = [];
  v?.forEach((v) {
  arr0.add(v.toJson());
  });
      data['categories'] = arr0;
    }
    data['total'] = total;
    data['perPage'] = perPage;
    data['page'] = page;
    return data;
  }
}
