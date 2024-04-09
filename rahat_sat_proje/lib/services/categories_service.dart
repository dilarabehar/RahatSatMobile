import 'dart:convert';

import 'package:http/http.dart';
import 'package:rahat_sat_project/model/product_model.dart';

class CategoriesService{
  final String baseUrl = "http://127.0.0.1:8000/api/";
  Future<List<ProductModelCategories>> getAllCategories() async{
    var response = await get(Uri.parse(baseUrl));

    if(response.statusCode == 200){
      final List allUrl = jsonDecode(response.body)["categories"];
      return allUrl.map(((e) => ProductModelCategories.fromJson(e))).toList();
    }
    else{
      throw("${response.statusCode}");
    }
  }
}
