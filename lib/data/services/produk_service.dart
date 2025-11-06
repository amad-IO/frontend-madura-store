// lib/data/services/product_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_request.dart';
import '../models/product_response.dart';

class ProductService {
  final String baseUrl;

  ProductService({this.baseUrl = 'http://10.0.2.2:8080/api/products'});

  Future<ProductResponse> updateProduct(int id, ProductRequest request) async {
    final url = Uri.parse('$baseUrl/$id');
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return ProductResponse.fromJson(json);
    } else {
      throw Exception('Gagal memperbarui produk: ${response.body}');
    }
  }
}
