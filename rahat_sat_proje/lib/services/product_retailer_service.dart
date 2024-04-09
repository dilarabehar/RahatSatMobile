import 'dart:convert';
import 'package:http/http.dart';
import 'package:rahat_sat_project/model/product_retailer_model.dart';

class ProductRetailerService {
  final String baseUrl= "http://127.0.0.1:8000/api/";
  Future<List<ProductRetail>> getProductsRetailsPrices() async {
    var response = await get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List url = jsonDecode(response.body)["product-retailer-prices"];
      return url.map((e) => ProductRetail.fromJson(e)).toList();
    } else {
      throw ("${response.statusCode}");
    }
  }
}