import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:rahat_sat_proje/model/product_model.dart';

class ProductService{
  final String baseUrl = "https://uygulama.rahatsat.com/api/";
  Future<List<ProductModelCategoriesProducts>> getProduct()async{
      var response = await get(Uri.parse(baseUrl));
      if(response.statusCode==200){
        final List result = jsonDecode(response.body)['product'];
        return result.map(((e) => ProductModelCategoriesProducts.fromJson(e))).toList();
      }
      else{
        throw("${response.statusCode}");
      }
      
  }
}

//now this data in shared state
final productProvider = Provider<ProductService>((ref) => ProductService());