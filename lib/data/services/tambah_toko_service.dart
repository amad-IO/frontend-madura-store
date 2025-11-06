import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/tambah_toko_request.dart';
import '../models/tambah_toko_response.dart';

class TambahTokoService {
  static const String baseUrl = 'http://10.0.2.2:8080/api/toko';

  Future<TambahTokoResponse> tambahToko(TambahTokoRequest request) async {
    final prefs = await SharedPreferences.getInstance();
    final jwtToken = prefs.getString('jwt_token') ?? '';

    if (jwtToken.isEmpty) {
      return TambahTokoResponse(
        success: false,
        message: 'Token JWT tidak ditemukan. Silakan login terlebih dahulu.',
      );
    }

    final response = await http.post(
      Uri.parse('$baseUrl/add'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken', // kirim token JWT
      },
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return TambahTokoResponse.fromJson(jsonDecode(response.body));
    } else {
      return TambahTokoResponse(
        success: false,
        message: 'Gagal menambahkan toko. (${response.statusCode})\n${response.body}',
      );
    }
  }

  Future getTokoByKasir(int i) async {}
}
