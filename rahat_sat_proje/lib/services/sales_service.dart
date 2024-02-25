import 'dart:convert';

import 'package:http/http.dart';
import 'package:rahat_sat_project/model/sales_model.dart';

class SalesService{
  final String baseUrl = "http://127.0.0.1:8000/api/";
  Future<List<SoldProductsModel>> getAllSoldProducts() async{
    var response = await get(Uri.parse(baseUrl));

    if(response.statusCode == 200){
      final List allUrl = jsonDecode(response.body)["product-listings"];
      return allUrl.map(((e) => SoldProductsModel.fromJson(e))).toList();
    }
    else{
      throw("${response.statusCode}");
    }
  }
}
