class StaffModels {

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

  StaffModels({
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
  StaffModels.fromJson(Map<String, dynamic> json) {
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

class StaffModel {
  List<StaffModels>? staff;
  int? total;
  int? perPage;
  int? page;

  StaffModel({
    this.staff,
    this.total,
    this.perPage,
    this.page,
  });

  StaffModel.fromJson(Map<String, dynamic> json) {
  if (json['staff'] != null) {
  final v = json['staff'];
  final arr0 = <StaffModels>[];
  v.forEach((v) {
  arr0.add(StaffModels.fromJson(v));
  });
    staff = arr0;
    }
    total = json['total']?.toInt();
    perPage = json['perPage']?.toInt();
    page = json['page']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (staff != null) {
      final v = staff;
      final arr0 = [];
  v?.forEach((v) {
  arr0.add(v.toJson());
  });
      data['staff'] = arr0;
    }
    data['total'] = total;
    data['perPage'] = perPage;
    data['page'] = page;
    return data;
  }
}
class StaffListing {
  final String id;
  final String marketId;
  final String name;
  final String email;
  final String emailVerifiedAt;
  final int isAdmin;
  final int isMarketOwner;
  final int isMarketStaff;
  final String createdAt;
  final String updatedAt;

  StaffListing({
    required this.id,
    required this.marketId,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.isAdmin,
    required this.isMarketOwner,
    required this.isMarketStaff,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StaffListing.fromJson(Map<String, dynamic> json) {
    return StaffListing(
      id: json['id'] ?? '',
      marketId: json['market_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      emailVerifiedAt: json['email_verified_at'] ?? '',
      isAdmin: json['is_admin'] ?? 0,
      isMarketOwner: json['is_market_owner'] ?? 0,
      isMarketStaff: json['is_market_staff'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
  
}
