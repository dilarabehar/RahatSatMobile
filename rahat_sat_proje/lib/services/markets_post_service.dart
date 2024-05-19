import 'dart:convert';
import 'package:http/http.dart' as http;

class MarketService {
  final String baseUrl = "http://127.0.0.1:8000/api/markets"; 

  Future<void> createMarket(String marketName, String marketAddress, String marketImage) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': marketName,
          'address': marketAddress,
          'image': marketImage,
        }),
      );

      if (response.statusCode == 201) {
        print('Market oluşturuldu: ${response.body}');
      } else {
        print('Hata oluştu: ${response.statusCode}');
      }
    } catch (e) {
      print('İstek gönderilirken bir hata oluştu: $e');
    }
  }
}
