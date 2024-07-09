class MarketsModels {
  String? id;
  String? marketId;
  String? name;
  String? email;
  String? emailVerifiedAt;
  int? isAdmin;
  int? isMarketOwner;
  int? isMarketStaff;
  String? createdAt;
  String? updatedAt;

  MarketsModels({
    this.id,
    this.marketId,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.isAdmin,
    this.isMarketOwner,
    this.isMarketStaff,
    this.createdAt,
    this.updatedAt,
  });
  MarketsModels.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    marketId = json['market_id']?.toString();
    name = json['name']?.toString();
    email = json['email']?.toString();
    emailVerifiedAt = json['email_verified_at']?.toString();
    isAdmin = json['is_admin']?.toInt();
    isMarketOwner = json['is_market_owner']?.toInt();
    isMarketStaff = json['is_market_staff']?.toInt();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['market_id'] = marketId;
    data['name'] = name;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['is_admin'] = isAdmin;
    data['is_market_owner'] = isMarketOwner;
    data['is_market_staff'] = isMarketStaff;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class MarketsModelsListing {
  String? id;
  String? name;
  String? image;
  String? address;
  String? createdAt;
  String? updatedAt;
  List<MarketsModels>? users;

  MarketsModelsListing({
    this.id,
    this.name,
    this.image,
    this.address,
    this.createdAt,
    this.updatedAt,
    this.users,
  });
  MarketsModelsListing.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    name = json['name']?.toString();
    image = json['image']?.toString();
    address = json['address']?.toString();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
    if (json['users'] != null) {
      final v = json['users'];
      final arr0 = <MarketsModels>[];
      v.forEach((v) {
        arr0.add(MarketsModels.fromJson(v));
      });
      users = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['address'] = address;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (users != null) {
      final v = users;
      final arr0 = [];
      v?.forEach((v) {
        arr0.add(v.toJson());
      });
      data['users'] = arr0;
    }
    return data;
  }
}

class Markets {
/*
{
  "markets": [
    {
      "id": "0535a220-505c-4f0f-b250-a6cd9a48ea22",
      "name": "Market isim",
      "image": null,
      "address": "Istabul",
      "created_at": "2023-09-08T01:56:06.000000Z",
      "updated_at": "2023-09-08T01:56:06.000000Z",
      "users": [
        {
          "id": "268f48af-5aec-4bc1-9a50-047a3bc22b2d",
          "market_id": "0535a220-505c-4f0f-b250-a6cd9a48ea22",
          "name": "a",
          "email": "a@deneme.com",
          "email_verified_at": null,
          "is_admin": 1,
          "is_market_owner": 1,
          "is_market_staff": 0,
          "created_at": "2023-09-08T01:55:31.000000Z",
          "updated_at": "2023-10-09T11:24:15.000000Z"
        }
      ]
    }
  ],
  "total": 2,
  "perPage": 10,
  "page": 1
}
*/

  List<MarketsModelsListing>? markets;
  int? total;
  int? perPage;
  int? page;

  Markets({
    this.markets,
    this.total,
    this.perPage,
    this.page,
  });
  Markets.fromJson(Map<String, dynamic> json) {
    if (json['markets'] != null) {
      final v = json['markets'];
      final arr0 = <MarketsModelsListing>[];
      v.forEach((v) {
        arr0.add(MarketsModelsListing.fromJson(v));
      });
      markets = arr0;
    }
    total = json['total']?.toInt();
    perPage = json['perPage']?.toInt();
    page = json['page']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (markets != null) {
      final v = markets;
      final arr0 = [];
      v?.forEach((v) {
        arr0.add(v.toJson());
      });
      data['markets'] = arr0;
    }
    data['total'] = total;
    data['perPage'] = perPage;
    data['page'] = page;
    return data;
  }
}
