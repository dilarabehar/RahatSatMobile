import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rahat_sat_project/model/autho_response.dart';
import 'package:rahat_sat_project/model/categories_model.dart';
import 'package:rahat_sat_project/model/login_model.dart';
import 'package:rahat_sat_project/model/markets_model.dart';
import 'package:rahat_sat_project/model/product_model.dart';
import 'package:rahat_sat_project/model/product_requests_model.dart';
import 'package:rahat_sat_project/model/product_retailer_model.dart';
import 'package:rahat_sat_project/model/staff_model.dart';
import 'package:rahat_sat_project/model/staff_permissions_model.dart';
import 'package:rahat_sat_project/model/users_model.dart';
import 'package:rahat_sat_project/services/data_service.dart';

const String baseUrl = "http://127.0.0.1:8000/api/";

class UserClient {
  // final _dio = Dio(BaseOptions(baseUrl: baseUrl));

  final DataService _dataService = DataService();

  Future<AuthResponse?> Login(LoginModel user) async {
    try {
      var response = await http.post(Uri.parse(baseUrl + "login"),
          body: {"email": user.email, "password": user.password});

      var data = jsonDecode(response.body);
      print(data);

      if (data['token'] != null) {
        var authResponse = AuthResponse(
          message: data['message'],
          token: data['token'],
        );

        print(authResponse);

        await _dataService.addItem("token", authResponse.token);
        return authResponse;
      } else {
        // Handle the case when the token is null
        print("Token is null");
        return null;
      }
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<List<SoldListing>?> getProduct() async {
    try {
      var token = await _dataService.tryGetItem("token");
      if (token != null) {
        var response = await http.get(
          Uri.parse(baseUrl + "product-listings"),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
        );
        if (response.statusCode == 200) {
          List<SoldListing> productListingList = [];

          for (var productListing
              in jsonDecode(response.body)["productListings"]) {
            productListingList.add(SoldListing.fromJson(productListing));
          }
          return productListingList;
        }
      }
      return null;
    } catch (error) {
      print(error);
      return null;
    }
  }

// bunu yeni ekledim page olmadan almak için gerekli mi tartisilir ?:( ?
Future<List<ProductListing>?> getAllProduct() async {
    try {
      var token = await _dataService.tryGetItem("token");
      if (token != null) {
        var response = await http.get(
          Uri.parse(baseUrl + "products"),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
        );
        if (response.statusCode == 200) {
          List<ProductListing> productListingList = [];

          for (var productListing
              in jsonDecode(response.body)["products"]) {
            productListingList.add(ProductListing.fromJson(productListing));
          }
          return productListingList;
        }
      }
      return null;
    } catch (error) {
      print(error);
      return null;
    }
  }
  Future<List<SoldListing>?> getSalesProduct() async {
    try {
      var token = await _dataService.tryGetItem("token");
      if (token != null) {
        var response = await http.get(
          Uri.parse(baseUrl + "product-listings"),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
        );
        if (response.statusCode == 200) {
          List<SoldListing> productListingList = [];

          for (var productListing
              in jsonDecode(response.body)["productListings"]) {
            productListingList.add(SoldListing.fromJson(productListing));
          }
          return productListingList;
        }
      }
      return null;
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<List<ProductListing>> fetchDataForPage(int page) async {
    try {
      var token = await _dataService.tryGetItem("token");
      if (token != null) {
        var response = await http.get(
          Uri.parse(baseUrl +
              "products?page=$page"), // Include the page parameter in the URL
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
        );

        if (response.statusCode == 200) {
          List<ProductListing> productListingList = [];

          var products = jsonDecode(response.body)["products"];
          if (products is List) {
            for (var product in products) {
              productListingList.add(ProductListing.fromJson(product));
            }
            return productListingList;
          }
        }
      }
      // Handle the case where the request fails
      throw Exception('Failed to load data for page $page');
    } catch (error) {
      print(error);
      // Handle any errors that occur during the process
      throw Exception('Error fetching data for page $page: $error');
    }
  }

// Tüm kategorilerin sayfa sayfa yüklenmesi için
// yükleme de değişiklik yapılacak burada bir hata var unutma !!!!!!!!
  Future<List<CategoriesModels>> fetchCategoriesForPage(int page) async {
    try {
      var token = await _dataService.tryGetItem("token");
      if (token != null) {
        var response = await http.get(
          Uri.parse(baseUrl +
              "categories?page=$page"), // Include the page parameter in the URL
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
        );

        if (response.statusCode == 200) {
          List<CategoriesModels> categoriesListingList = [];

          var categories = jsonDecode(response.body)["categories"];
          if (categories is List) {
            for (var allCategories in categories) {
              categoriesListingList
                  .add(CategoriesModels.fromJson(allCategories));
            }
            return categoriesListingList;
          }
        }
      }
      // Handle the case where the request fails
      throw Exception('Failed to load data for page $page');
    } catch (error) {
      print(error);
      // Handle any errors that occur during the process
      throw Exception('Error fetching data for page $page: $error');
    }
  }

  Future<List<StaffListing>> getAllStaff() async {
    try {
      var token = await _dataService.tryGetItem("token");
      if (token != null) {
        var response = await http.get(
          Uri.parse(baseUrl + "staff"),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
        );
        if (response.statusCode == 200) {
          List<StaffListing> staffListing = [];
          var responseData = jsonDecode(response.body);
          var allStaff = responseData["staff"] as List;

          for (var staffData in allStaff) {
            staffListing.add(StaffListing.fromJson(staffData));
          }
          return staffListing;
        }
      }
    } catch (error) {
      print(error);
    }

    // hata olursa veya istek başarısız olursa, boş bir liste döndürmek için yazdım
    return [];
  }

  Future<StaffModel> createStaff(
      String name, String mail, String password) async {
    try {
      var token = await _dataService.tryGetItem("token");
      if (token != null) {
        var response = await http.post(
          Uri.parse(baseUrl + "staff"),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
          body: jsonEncode({'name': name, 'email': mail, 'password': password}),
        );
        if (response.statusCode == 200) {
          return StaffModel.fromJson(jsonDecode(response.body));
        } else {
          throw Exception("Post İşlemi Başarısız : ${response.statusCode}");
        }
      } else {
        throw Exception("Token alınamadı.");
      }
    } catch (error) {
      print(error);
      throw Exception("Post işlemi sırasında bir hata oluştu.");
    }
  }

  Future<void> deleteStaff(String staffId) async {
    try {
      var token = await _dataService.tryGetItem("token");
      if (token != null) {
        // Token başarıyla alındı, şimdi isteği gönderebiliriz
        var response = await http.delete(
          Uri.parse(baseUrl + "staff/$staffId"),
          headers: {"Authorization": "Bearer $token"},
        );
        if (response.statusCode == 200) {
          print("Staff deleted successfully");
        } else {
          throw Exception("Delete İşlemi Başarısız : ${response.statusCode}");
        }
      } else {
        // Token alınamadı, hata durumu
        throw Exception("Token alınamadı.");
      }
    } catch (error) {
      print(error);
      // Hata durumunda
      throw Exception("Delete işlemi sırasında bir hata oluştu.");
    }
  }

  Future<void> updateStaff(
      String staffId, String name, String email, String password) async {
    try {
      var token = await _dataService.tryGetItem("token");
      if (token != null) {
        var response = await http.patch(
          Uri.parse(baseUrl + "staff/$staffId"),
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
          body:
              jsonEncode({"name": name, "email": email, "password": password}),
        );
        if (response.statusCode == 200) {
          print("Staff updated successfully");
        } else {
          throw Exception(
              "Güncelleme İşlemi Başarısız : ${response.statusCode}");
        }
      } else {
        throw Exception("Token alınamadı.");
      }
    } catch (error) {
      print(error);
      throw Exception("Güncelleme işlemi sırasında bir hata oluştu.");
    }
  }

  Future<List<StaffPermissionsListing>?> getPermissionsStaff() async {
    try {
      var token = await _dataService.tryGetItem("token");
      if (token != null) {
        var response = await http.get(
          Uri.parse(baseUrl + "staff/permissions"),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
        );

        if (response.statusCode == 200) {
          List<StaffPermissionsListing> permissionStaffList = [];

          // JSON'dan doğrudan "productListings" alanını çekmek yerine, "StaffPermissionsModel" sınıfından çevirin
          var responseData = jsonDecode(response.body);
          if (responseData['permissions'] != null) {
            for (var permission in responseData['permissions']) {
              permissionStaffList
                  .add(StaffPermissionsListing.fromJson(permission));
            }
            return permissionStaffList;
          }
        }
      }

      return null;
    } catch (error) {
      print(error);
      return null;
    }
  }

  // update staff permission
  Future<void> updateStaffPermissions(
      String staffId,
      bool read_categories,
      bool read_products,
      bool read_staff,
      bool write_categories,
      bool write_products,
      bool camera_sale,
      bool write_staff) async {
    try {
      var token = await _dataService.tryGetItem("token");
      if (token != null) {
        var response = await http.patch(
          Uri.parse(baseUrl + "staff/permissions/$staffId"),
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
          body: jsonEncode({
            "read_categories": read_categories,
            "read_products": read_products,
            "read_staff": read_staff,
            "write_staff": write_staff,
            "write_categories": write_categories,
            "write_products": write_products,
            "camera_sale": camera_sale
          }),
        );
        if (response.statusCode == 200) {
          print("staff updated succesfully");
        } else {
          throw Exception(
              "Güncelleme işlemi başarısız..:${response.statusCode}");
        }
      } else {
        throw Exception("Token Alınamadı.");
      }
    } catch (error) {
      print(error);
      throw Exception("Güncelleme işlemi sırasında bir hata oluştu");
    }
  }

  Future<List<UsersModelsListing>> getAllUsers() async {
    try {
      var token = await _dataService.tryGetItem("token");
      if (token != null) {
        var response = await http.get(
          Uri.parse(baseUrl + "users"),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
        );
        if (response.statusCode == 200) {
          List<UsersModelsListing> userListings = [];
          var responseData = jsonDecode(response.body);
          var allUsers = responseData["users"] as List;

          for (var usersData in allUsers) {
            userListings.add(UsersModelsListing.fromJson(usersData));
          }
          return userListings;
        }
      }
    } catch (error) {
      print(error);
    }
    return [];
  }

  Future<List<CategoriesModelsListing>> getAllCategories() async {
    try {
      var token = await _dataService.tryGetItem("token");
      if (token != null) {
        var response = await http.get(
          Uri.parse(baseUrl + "categories"),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
        );
        if (response.statusCode == 200) {
          List<CategoriesModelsListing> categoriesListing = [];
          var responseData = jsonDecode(response.body);
          var allCategories = responseData["categories"] as List;

          for (var categoriesData in allCategories) {
            categoriesListing
                .add(CategoriesModelsListing.fromJson(categoriesData));
          }
          return categoriesListing;
        }
      }
    } catch (error) {
      print(error);
    }
    return [];
  }

  Future<List<ProductRequest>?> getProductsRequests() async {
    try {
      var token = await _dataService.tryGetItem("token");

      if (token != null) {
        var response = await http.get(
          Uri.parse(baseUrl + "product-requests"),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
        );

        if (response.statusCode == 200) {
          List<ProductRequest> requestsListing = [];
          var responseData = jsonDecode(response.body);

          if (responseData.containsKey("productRequests") &&
              responseData["productRequests"] is List) {
            var allRequests = responseData["productRequests"] as List;

            for (var requestsData in allRequests) {
              requestsListing.add(ProductRequest.fromJson(requestsData));
            }

            return requestsListing;
          } else {
            // "product-requests" anahtarı yoksa veya değeri bir liste değilse
            print(
                "Error: 'product-requests' key is missing or not a list in response");
            return [];
          }
        } else {
          // Hata durumu
          print("Error: ${response.statusCode} - ${response.reasonPhrase}");
          return [];
        }
      }
    } catch (error) {
      // Hata yakalanırsa
      print("Error: $error");
      return [];
    }

    return [];
  }

// product retailer service isteği
  Future<List<ProductRetailProductRetailPrices>?>
      getAllProductRetailerPrices() async {
    try {
      var token = await _dataService.tryGetItem("token");

      if (token != null) {
        var response = await http.get(
          Uri.parse(baseUrl + "product-retailer-prices"),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
        );

        if (response.statusCode == 200) {
          List<ProductRetailProductRetailPrices> requestsListing = [];
          var responseData = jsonDecode(response.body);

          if (responseData.containsKey("productRetailPrices") &&
              responseData["productRetailPrices"] is List) {
            var allRequests = responseData["productRetailPrices"] as List;

            for (var requestsData in allRequests) {
              requestsListing
                  .add(ProductRetailProductRetailPrices.fromJson(requestsData));
            }

            return requestsListing;
          } else {
            // "product-requests" anahtarı yoksa veya değeri bir liste değilse
            print(
                "Error: 'product-retailer-prices' key is missing or not a list in response");
            return [];
          }
        } else {
          // Hata durumu
          print("Error: ${response.statusCode} - ${response.reasonPhrase}");
          return [];
        }
      }
    } catch (error) {
      // Hata yakalanırsa
      print("Error: $error");
      return [];
    }

    return [];
  }

// get all markets
  Future<List<MarketsModelsListing>> getAllMarkets() async {
    try {
      var token = await _dataService.tryGetItem("token");
      if (token != null) {
        var response = await http.get(
          Uri.parse(baseUrl + "markets"),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
        );
        if (response.statusCode == 200) {
          List<MarketsModelsListing> marketListings = [];
          var responseData = jsonDecode(response.body);
          var allMarkets = responseData["markets"] as List;

          for (var marketsData in allMarkets) {
            marketListings.add(MarketsModelsListing.fromJson(marketsData));
          }
          return marketListings;
        }
      }
    } catch (error) {
      print(error);
    }
    return [];
  }

//  product listing api -> sold products
  Future<void> updateSoldProduct(
    String id,
    String product_id,
    double product_listing_stock_count,
    double product_listing_unit_cost,
    double product_listing_tax_rate,
    double product_listing_profit_rate,
  ) async {
    try {
      var token = await _dataService.tryGetItem("token");
      if (token != null) {
        var response = await http.patch(
          Uri.parse(baseUrl + "product-listings/$id"),
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
          body: jsonEncode({
            "product_id": product_id,
            "product_listing_stock_count": product_listing_stock_count,
            "product_listing_unit_cost": product_listing_unit_cost,
            "product_listing_tax_rate": product_listing_tax_rate,
            "product_listing_profit_rate": product_listing_profit_rate,
          }),
        );
        if (response.statusCode == 200) {
          print("Product updated successfully");
        } else {
          throw Exception(
              "Güncelleme İşlemi Başarısız : ${response.statusCode}");
        }
      } else {
        throw Exception("Token alınamadı.");
      }
    } catch (error) {
      print(error);
      throw Exception("Güncelleme işlemi sırasında bir hata oluştu.${error}");
    }
  }
Future<void> deleteSoldProduct(String id) async {
    try {
      var token = await _dataService.tryGetItem("token");
      if (token != null) {
        // Token başarıyla alındı, şimdi isteği gönderebiliriz
        var response = await http.delete(
          Uri.parse(baseUrl + "product-listings/$id"),
          headers: {"Authorization": "Bearer $token"},
        );
        if (response.statusCode == 200) {
          print("Satılan ürün başarı ile silindi");
        } else {
          throw Exception("Delete İşlemi Başarısız : ${response.statusCode}");
        }
      } else {
        // Token alınamadı, hata durumu
        throw Exception("Token alınamadı.");
      }
    } catch (error) {
      print(error);
      // Hata durumunda
      throw Exception("Silme işlemi sırasında bir hata oluştu.");
    }
  }
}



/**
 *
 * List<ProductModelCategoriesProducts> products = [];
          var productListings = jsonDecode(response.body)["productListings"];
          if (productListings is List) {
            for (var product in productListings) {
              products.add(ProductModelCategoriesProducts.fromJson(product));
            }
            return products;
          }
 *
 *
 *
 *   createdAt: product["created_at"],
                  updatedAt: product["updated_at"],
                  id: product["id"],
                  name: product["name"],
                  image: product["image"],
 *
 *  Future<List<ProductModelCategories>?> getProduct()async{
      try{
        var token = await _dataService.tryGetItem("token");
        if(token != null)
        {
          var response = await _dio.get("product-listings",
          options: Options(headers: {"Content-Type" : "application/json",
                                     "Accept" : "application/json",
                                     "Authorization" : "Bearer $token"}));
          List<ProductModelCategories> products = new List.empty(growable: true);

          if(response != null && response.data is List)
          {
            for(var product in response.data)
            {
              products.add(ProductModelCategories(createdAt: product["created_at"], updatedAt: product["updated_at"], id: product["id"], name: product["name"] ));
            }
            return products;
          }
        }else{return null;}

      }catch(error){
        print(error);
        return null; }
}
 
 */
