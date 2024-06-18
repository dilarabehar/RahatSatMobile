import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductService {
  final String baseUrl = "http://127.0.0.1:8000/api/";

  Future<Map<String, dynamic>> newProductRequest(String productName, String productBarcode, String message, String token) async {
    final url = Uri.parse('$baseUrl/api/product-request');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = jsonEncode({
      'product_name': productName,
      'product_barcode': productBarcode,
      'message': message,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create product request');
    }
  }
}
