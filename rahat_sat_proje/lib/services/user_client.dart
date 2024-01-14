import 'package:dio/dio.dart';
import 'package:rahat_sat_project/model/login_model.dart';
import 'package:rahat_sat_project/model/autho_response.dart';
import 'package:rahat_sat_project/services/data_service.dart';
import 'package:rahat_sat_project/model/product_model.dart';

const String baseUrl = "http://127.0.0.1:8000/api/";

class UserClient{
  final _dio = Dio(BaseOptions(baseUrl: baseUrl));

  final DataService _dataService = DataService();

  Future<AuthResponse?> Login(LoginModel user) async{
    try{
      var response = await _dio.post("login", 
      data: {"email": user.email, "password": user.password});

      var data = response.data;
      print(data);
      var authResponse = new AuthResponse(message: data['message'] , token: data['token']);
      print(authResponse);
      if(authResponse.token != null)
      {
        await _dataService.addItem("token", authResponse.token);
      }
      return authResponse;

    }catch(error)
    {
      print(error);
      return null;
    }

  } 
  Future<List<ProductModelCategories>?> getProduct() async {
  try {
    var token = await _dataService.tryGetItem("token");
    if (token != null) {
      var response = await _dio.get(
        "product-listings",
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
        ),
      );

      List<ProductModelCategories> products = [];

      if (response != null && response.data is Map<String, dynamic>) {
        // Assuming your data structure has a key named "productListings"
        var productListings = response.data["productListings"];
        
        if (productListings is List) {
          for (var product in productListings) {
            products.add(ProductModelCategories(
              createdAt: product["created_at"],
              updatedAt: product["updated_at"],
              id: product["id"],
              name: product["name"],
              image: product["image"],
              products: product["products"]
            ));
          }
          return products;
        }
      }
    }
    return null;
  } catch (error) {
    print(error);
    return null;
  }
}


/**
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
}