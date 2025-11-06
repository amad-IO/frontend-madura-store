import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../data/models/product.dart';

class ProductController extends ChangeNotifier {
  final List<Product> _items = [];
  List<Product> get items => _items;

  // Ganti IP sesuai backend-mu
  final String baseUrl = 'http://10.10.168.87:8080/api/produk';

  /// Ambil semua produk dari backend
  Future<void> fetchProduk() async {
    try {
      final res = await http.get(Uri.parse(baseUrl));

      if (res.statusCode == 200) {
        final List data = jsonDecode(res.body);
        _items
          ..clear()
          ..addAll(data.map((e) => Product.fromJson(e)));
        notifyListeners();
      } else {
        throw Exception('Gagal mengambil data produk (${res.statusCode})');
      }
    } catch (e) {
      debugPrint('Error fetchProduk: $e');
      rethrow;
    }
  }

  /// Update produk berdasarkan ID
  Future<void> updateProduk(Product product) async {
    try {
      final url = Uri.parse('$baseUrl/update/${product.id}');
      final body = jsonEncode({
        'nama': product.name,
        'hargaJual': product.price,
        'stok': product.stock,
        'satuan': 'pcs', // kamu bisa ubah sesuai input satuan dari form nanti
      });

      final res = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (res.statusCode == 200) {
        // Update data lokal biar UI langsung berubah
        final index = _items.indexWhere((p) => p.id == product.id);
        if (index != -1) _items[index] = product;
        notifyListeners();
      } else {
        throw Exception('Gagal update produk (${res.statusCode}): ${res.body}');
      }
    } catch (e) {
      debugPrint('Error updateProduk: $e');
      rethrow;
    }
  }

  /// Tambah produk baru ke daftar lokal (belum ke backend)
  void add(Product product) {
    _items.add(product);
    notifyListeners();
  }

  Future<void> addProduk(Product newProduct) async {}
}
