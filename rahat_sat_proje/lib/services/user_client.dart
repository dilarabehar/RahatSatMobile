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
              categoriesListingList.add(CategoriesModels.fromJson(allCategories));
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
            permissionStaffList.add(StaffPermissionsListing.fromJson(permission));
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
          categoriesListing.add(CategoriesModelsListing.fromJson(categoriesData));
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
          print("Error: 'product-requests' key is missing or not a list in response");
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
Future<List<ProductRetailProductRetailPrices>?> getAllProductRetailerPrices() async {
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
            requestsListing.add(ProductRetailProductRetailPrices.fromJson(requestsData));
          }

          return requestsListing;
        } else {
          // "product-requests" anahtarı yoksa veya değeri bir liste değilse
          print("Error: 'product-retailer-prices' key is missing or not a list in response");
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

//Response<dynamic> ({"productListings":[{"id":"f5bd5f2a-6a0d-43f9-b4b3-765ed3ffe585","product_id":"60a88aae-3fd7-4708-b0ef-0b2df7416729","market_id":"0535a220-505c-4f0f-b250-a6cd9a48ea22","stock_count":14,"unit_cost":12.21,"tax_rate":20,"profit_rate":35,"total_price":19.78,"created_at":"2023-09-27T21:57:36.000000Z","updated_at":"2023-10-14T09:47:45.000000Z","product":{"id":"60a88aae-3fd7-4708-b0ef-0b2df7416729","category_id":"a6a65298-fe53-46bf-87fe-b58930807b60","name":"Eti Cin Portakal Jöleli Bisküvi Çoklu Paket (325 g)","barcode":"8690526063140","image":"productImages/8690526063140.jpeg","created_at":"2023-09-27T21:51:41.000000Z","updated_at":"2023-09-27T21:51:41.000000Z"}},{"id":"aba295ea-5ad5-4c70-a57a-2e9b6fa8ff36","product_id":"7812839b-d539-44d2-99c3-83a31272c782","market_id":"0535a220-505c-4f0f-b250-a6cd9a48ea22","stock_count":60,"unit_cost":12,"tax_rate":20,"profit_rate":35,"total_price":19.44,"created_at":"2023-10-14T09:08:40.000000Z","updated_at":"2023-10-14T09:47:45.000000Z","product":{"id":"7812839b-d539-44d2-99c3-83a31272c782","category_id":"1df2704c-f208-4407-a450-88ef225348ca","name":"Maltana Ananas Aromalı Alkolsüz Malt İçeceği (250 ml)","barcode":"8697520533525","image":"productImages/8697520533525.jpeg","created_at":"2023-09-27T21:51:44.000000Z","updated_at":"2023-09-27T21:51:44.000000Z"}}],"total":2,"perPage":10,"page":1})

