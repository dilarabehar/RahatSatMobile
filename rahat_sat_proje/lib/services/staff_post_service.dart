import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rahat_sat_project/model/staff_model.dart';

// burası iptal edilecek user clienttan post atıyorum token ile
class StaffPostService {
  final url = Uri.parse("http://127.0.0.1:8000/api/staff");

  Future<StaffModels> createStaff(
      String name, String email, String password) async {
    Map<String, dynamic> request = {
      'name': name,
      'email': email,
      'password': password
    };

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final response =
        await http.post(url, headers: headers, body: jsonEncode(request));

    if (response.statusCode == 200) {
      return StaffModels.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Post İşlemi Başarısız : ${response.statusCode}");
    }
  }
}
