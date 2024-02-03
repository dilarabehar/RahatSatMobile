import 'dart:convert';

import 'package:http/http.dart';
import 'package:rahat_sat_project/model/staff_model.dart';

class StaffService{
  final String baseUrl = "http://127.0.0.1:8000/api/";
  Future<List<StaffModel>> getAllStaff() async{
    var response = await get(Uri.parse(baseUrl));

    if(response.statusCode == 200){
      final List allUrl = jsonDecode(response.body)["staff"];
      return allUrl.map(((e) => StaffModel.fromJson(e))).toList();
    }
    else{
      throw("${response.statusCode}");
    }
  }
}
