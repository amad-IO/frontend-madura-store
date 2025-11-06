import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/tambah_pengguna_request.dart';
import '../models/tambah_pengguna_response.dart';

class TambahPenggunaService {
  final String baseUrl = "http://10.0.2.2:8080/api/users";

  Future<TambahPenggunaResponse> tambahKasir({
    required String namaKasir,
  }) async {
    final request = TambahPenggunaRequest(
      nama: namaKasir,
      username: namaKasir.toLowerCase().replaceAll(' ', ''),
      password: "123456", // default password
      phone: "", namaKasir: '', namaToko: '', alamat: '',
    );

    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return TambahPenggunaResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Gagal menambahkan kasir: ${response.body}');
    }
  }

  Future tambahPengguna(TambahPenggunaRequest req) async {}
}
