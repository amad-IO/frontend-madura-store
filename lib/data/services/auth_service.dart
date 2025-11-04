import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';

class AuthService {
  final String baseUrl = "http://localhost:8080/api";

  Future<LoginResponse> login(LoginRequest request) async {
    final url = Uri.parse('$baseUrl/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );

    try {
      // Coba parse JSON dulu
      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', data['token']);
        await prefs.setString('role', data['role']);
        await prefs.setString('username', request.username);

        return LoginResponse.fromJson(data);
      } else {
        // Jika backend kirim JSON error
        return LoginResponse(
          token: '',
          role: '',
          message: data['message'] ?? 'Login gagal',
        );
      }
    } catch (e) {
      // Jika backend kirim plain text (bukan JSON)
      return LoginResponse(
        token: '',
        role: '',
        message: response.body.toString().isNotEmpty
            ? response.body.toString()
            : 'Login gagal, format tidak dikenal',
      );
    }
  }
}
