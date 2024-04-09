import 'dart:convert';

import 'package:http/http.dart';
import 'package:rahat_sat_project/model/users_model.dart';

class UsersService{
  final String baseUrl = "http://127.0.0.1:8000/api/";
  Future<List<UsersModels>> getAllUsers() async{
    var response = await get(Uri.parse(baseUrl));

    if(response.statusCode == 200){
      final List allUrl = jsonDecode(response.body)["users"];
      return allUrl.map(((e) => UsersModels.fromJson(e))).toList();
    }
    else{
      throw("${response.statusCode}");
    }
  }
}
