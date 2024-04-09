import 'dart:convert';
import 'package:http/http.dart';
import 'package:rahat_sat_project/model/markets_model.dart';

class MarketsService{
  final String baseUrl = "http://127.0.0.1:8000/api/";
  Future<List<MarketsModelsListing>> getAllStaff() async{
    var response = await get(Uri.parse(baseUrl));

    if(response.statusCode == 200){
      final List allUrl = jsonDecode(response.body)["markets"];
      return allUrl.map(((e) => MarketsModelsListing.fromJson(e))).toList();
    }
    else{
      throw("${response.statusCode}");
    }
  }
}
