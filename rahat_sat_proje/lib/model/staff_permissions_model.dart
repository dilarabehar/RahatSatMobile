
class StaffPermissionsModelPermissionsUser {

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

  StaffPermissionsModelPermissionsUser({
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
  StaffPermissionsModelPermissionsUser.fromJson(Map<String, dynamic> json) {
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

class StaffPermissionsModelPermissions {
  String? id;
  String? userId;
  int? readCategories;
  int? writeCategories;
  int? readProducts;
  int? writeProducts;
  int? readStaff;
  int? writeStaff;
  int? cameraSale;
  String? createdAt;
  String? updatedAt;
  StaffPermissionsModelPermissionsUser? user;

  StaffPermissionsModelPermissions({
    this.id,
    this.userId,
    this.readCategories,
    this.writeCategories,
    this.readProducts,
    this.writeProducts,
    this.readStaff,
    this.writeStaff,
    this.cameraSale,
    this.createdAt,
    this.updatedAt,
    this.user,
  });
  StaffPermissionsModelPermissions.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    userId = json['user_id']?.toString();
    readCategories = json['read_categories']?.toInt();
    writeCategories = json['write_categories']?.toInt();
    readProducts = json['read_products']?.toInt();
    writeProducts = json['write_products']?.toInt();
    readStaff = json['read_staff']?.toInt();
    writeStaff = json['write_staff']?.toInt();
    cameraSale = json['camera_sale']?.toInt();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
    user = (json['user'] != null) ? StaffPermissionsModelPermissionsUser.fromJson(json['user']) : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['read_categories'] = readCategories;
    data['write_categories'] = writeCategories;
    data['read_products'] = readProducts;
    data['write_products'] = writeProducts;
    data['read_staff'] = readStaff;
    data['write_staff'] = writeStaff;
    data['camera_sale'] = cameraSale;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user?.toJson();
    }
    return data;
  }
}

class StaffPermissionsModel {

  List<StaffPermissionsModelPermissions>? permissions;
  int? total;
  int? perPage;
  int? page;

  StaffPermissionsModel({
    this.permissions,
    this.total,
    this.perPage,
    this.page,
  });
  StaffPermissionsModel.fromJson(Map<String, dynamic> json) {
  if (json['permissions'] != null) {
  final v = json['permissions'];
  final arr0 = <StaffPermissionsModelPermissions>[];
  v.forEach((v) {
  arr0.add(StaffPermissionsModelPermissions.fromJson(v));
  });
    permissions = arr0;
    }
    total = json['total']?.toInt();
    perPage = json['perPage']?.toInt();
    page = json['page']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (permissions != null) {
      final v = permissions;
      final arr0 = [];
  v?.forEach((v) {
  arr0.add(v.toJson());
  });
      data['permissions'] = arr0;
    }
    data['total'] = total;
    data['perPage'] = perPage;
    data['page'] = page;
    return data;
  }
}
class StaffPermissionsListing {
  final String id;
  final String userId;
  final int? readCategories;
  final int? writeCategories;
  final int? readProducts;
  final int? writeProducts;
  final int? readStaff;
  final int? writeStaff;
  final int? cameraSale;
  final String createdAt;
  final String updatedAt;
  final StaffPermissionsModelPermissionsUser? user;

  StaffPermissionsListing({
    required this.id,
    required this.userId,
    this.readCategories,
    this.writeCategories,
    this.readProducts,
    this.writeProducts,
    this.readStaff,
    this.writeStaff,
    this.cameraSale,
    required this.createdAt,
    required this.updatedAt,
    this.user,
  });

  factory StaffPermissionsListing.fromJson(Map<String, dynamic> json) {
    return StaffPermissionsListing(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      readCategories: json['read_categories'] ?? null,
      writeCategories: json['write_categories'] ?? null,
      readProducts: json['read_products'] ?? null,
      writeProducts: json['write_products'] ?? null,
      readStaff: json['read_staff'] ?? null,
      writeStaff: json['write_staff'] ?? null,
      cameraSale: json['camera_sale'] ?? null,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      user: (json['user'] != null) ? StaffPermissionsModelPermissionsUser.fromJson(json['user']) : null,
    );
  }
}
