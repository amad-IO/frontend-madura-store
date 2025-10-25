import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/signup_request.dart';
import '../models/signup_response.dart';

class SignupService {
  final String baseUrl = "http://10.0.2.2:8080/api"; // ✅ Sesuai backend

  Future<SignupResponse> signup(SignupRequest request) async {
    final url = Uri.parse('$baseUrl/signup'); // ✅ Endpoint cocok dengan backend

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return SignupResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Gagal daftar: ${response.body}');
    }
  }
}
