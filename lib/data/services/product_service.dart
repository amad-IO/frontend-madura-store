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
  Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception("Gagal memuat produk");
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
  }) async {
    var uri = Uri.parse("$baseUrl/add");

    var request = http.MultipartRequest("POST", uri);

    request.fields["nama"] = nama;
    request.fields["hargaJual"] = hargaJual.toString();
    request.fields["stok"] = stok.toString();
    request.fields["satuan"] = satuan;

    request.files.add(await http.MultipartFile.fromPath("image", imageFile.path));

    var response = await request.send();

    // 🔥 Tambahkan log ini
    print("========== ADD PRODUCT RESPONSE ==========");
    print("STATUS CODE : ${response.statusCode}");
    print("REASON      : ${response.reasonPhrase}");
    print("==========================================");

    return response.statusCode == 200 || response.statusCode == 201;
  }


  // ---------------------------------------------------------
  // UPDATE produk (gunakan POST, bukan PUT)
  // ---------------------------------------------------------
  Future<bool> updateProduct({
    required int id,
    File? imageFile,
    required String nama,
    required double hargaJual,
    required int stok,
    required String satuan,
  }) async {
    var uri = Uri.parse("$baseUrl/update/$id");

    var request = http.MultipartRequest("POST", uri);

    request.fields["nama"] = nama;
    request.fields["hargaJual"] = hargaJual.toString();
    request.fields["stok"] = stok.toString();
    request.fields["satuan"] = satuan;

    if (imageFile != null) {
      request.files.add(await http.MultipartFile.fromPath(
        "image",
        imageFile.path,
      ));
    }

    var response = await request.send();
    return response.statusCode == 200;
  }

  Future<bool> deleteProduct(int id) async {
    final url = Uri.parse("$baseUrl/delete/$id");

    final response = await http.delete(url);

    print("========== DELETE PRODUCT RESPONSE ==========");
    print("STATUS CODE : ${response.statusCode}");
    print("BODY        : ${response.body}");
    print("=============================================");

    return response.statusCode == 200;
  }

  
}
