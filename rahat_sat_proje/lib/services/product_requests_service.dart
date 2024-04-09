import 'dart:convert';

import 'package:http/http.dart';
import 'package:rahat_sat_project/model/product_requests_model.dart';

class ProductRequestsService {
  final String baseUrl= "http://127.0.0.1:8000/api/";
  Future<List<ProductRequest>> getProductsRequests() async {
    var response = await get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List url = jsonDecode(response.body)["product-requests"];
      return url.map((e) => ProductRequest.fromJson(e)).toList();
    } else {
      throw ("${response.statusCode}");
    }
  }
}
