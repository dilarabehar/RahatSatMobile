import 'package:dio/dio.dart';
import 'package:rahat_sat_proje/model/login_model.dart';

class Service{
  final String baseUrl = "http://127.0.0.1:8000/api/";
  final dio = Dio();
  Future<LoginModel?> loginCall({
    required String email,required String password })async{

      Map<String, dynamic> json = {
          "email": email,
          "password": password
      };

      var response = await dio.post("${baseUrl}login",data: json);
      if(response.statusCode==200){
        var result = LoginModel.fromJson(response.data);
        return result;
      }
      else{
        throw("${response.statusCode}");
      }
      
  }
}