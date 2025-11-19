import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductService {
  // GANTI dengan IP backend kamu (WAJIB)
  static const String baseUrl = "http://localhost:8080/api/produk";

  // ---------------------------------------------------------
  // GET semua produk
  // ---------------------------------------------------------
  Future<List<Product>> getProducts(String token) async {
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      },
    );

    print("STATUS GET PRODUK : ${response.statusCode}");
    print("BODY              : ${response.body}");

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((e) => Product.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  // ---------------------------------------------------------
  // ADD produk + upload gambar
  // ---------------------------------------------------------
  Future<bool> addProduct({
    required File imageFile,
    required String nama,
    required double hargaJual,
    required int stok,
    required String satuan,
    required String token,     // 🔥 WAJIB
  }) async {
    var uri = Uri.parse("$baseUrl/add");

    var request = http.MultipartRequest("POST", uri);

    // 🔥 HEADER TOKEN WAJIB
    request.headers["Authorization"] = "Bearer $token";

    request.fields["nama"] = nama;
    request.fields["hargaJual"] = hargaJual.toString();
    request.fields["stok"] = stok.toString();
    request.fields["satuan"] = satuan;

    request.files.add(await http.MultipartFile.fromPath("image", imageFile.path));

    var response = await request.send();

    print("========== ADD PRODUCT RESPONSE ==========");
    print("STATUS CODE : ${response.statusCode}");
    print("REASON      : ${response.reasonPhrase}");
    print("==========================================");

    return response.statusCode == 200 || response.statusCode == 201;
  }

  // ---------------------------------------------------------
  // UPDATE produk
  // ---------------------------------------------------------
  Future<bool> updateProduct({
    required int id,
    File? imageFile,
    required String nama,
    required double hargaJual,
    required int stok,
    required String satuan,
    required String token,     // 🔥 WAJIB
  }) async {
    var uri = Uri.parse("$baseUrl/update/$id");

    var request = http.MultipartRequest("POST", uri);

    // 🔥 TOKEN
    request.headers["Authorization"] = "Bearer $token";

    request.fields["nama"] = nama;
    request.fields["hargaJual"] = hargaJual.toString();
    request.fields["stok"] = stok.toString();
    request.fields["satuan"] = satuan;

    if (imageFile != null) {
      request.files.add(await http.MultipartFile.fromPath("image", imageFile.path));
    }

    var response = await request.send();
    return response.statusCode == 200;
  }

  // ---------------------------------------------------------
  // DELETE produk
  // ---------------------------------------------------------
  Future<bool> deleteProduct(int id, String token) async {
    final url = Uri.parse("$baseUrl/delete/$id");

    final response = await http.delete(
      url,
      headers: {
        "Authorization": "Bearer $token",   // 🔥 WAJIB
      },
    );

    print("========== DELETE PRODUCT RESPONSE ==========");
    print("STATUS CODE : ${response.statusCode}");
    print("BODY        : ${response.body}");
    print("=============================================");

    return response.statusCode == 200;
  }
}
