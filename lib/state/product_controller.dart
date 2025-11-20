import 'package:flutter/foundation.dart';
import '../data/models/product.dart';
import '../data/services/product_service.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class ProductController extends ChangeNotifier {
  final ProductService _service = ProductService();

  List<Product> _items = [];
  List<Product> get items => _items;

  bool isLoading = false;

  // =========================================================
  // LOAD PRODUCT dari backend
  // =========================================================
  Future<void> loadProducts() async {
    isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");

      if (token == null) {
        print("TOKEN TIDAK ADA");
        _items = [];
        isLoading = false;
        notifyListeners();
        return;
      }

      _items = await _service.getProducts(token);
    } catch (e) {
      print("Gagal load produk: $e");
    }

    isLoading = false;
    notifyListeners();
  }

  // =========================================================
  // UPDATE ke backend
  // =========================================================
  Future<bool> update(Product p, {File? imageFile}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token")!;

      final ok = await _service.updateProduct(
        id: p.id,
        nama: p.nama,
        hargaJual: p.hargaJual,
        stok: p.stok,
        satuan: p.satuan,
        imageFile: imageFile,
        token: token,            // <- WAJIB
      );

      if (ok) {
        await loadProducts();
        return true;
      } else {
        print("Gagal update produk");
        return false;
      }
    } catch (e) {
      print("Error update: $e");
      return false;
    }
  }

  // =========================================================
  // ADD produk
  // =========================================================
  Future<bool> add(Product p, File? imageFile) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token")!;

      final ok = await _service.addProduct(
        imageFile: imageFile!,
        nama: p.nama,
        hargaJual: p.hargaJual,
        stok: p.stok,
        satuan: p.satuan,
        token: token,          // <- WAJIB
      );

      if (ok) {
        await loadProducts();
        return true;
      } else {
        print("Gagal tambah produk");
        return false;
      }
    } catch (e) {
      print("Error add product: $e");
      return false;
    }
  }

  // =========================================================
  // DELETE produk
  // =========================================================
  Future<bool> delete(int id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token")!;

      final ok = await _service.deleteProduct(id, token);  // <- BENAR

      if (ok) {
        _items.removeWhere((p) => p.id == id);
        notifyListeners();
        return true;
      } else {
        print("Gagal hapus produk");
        return false;
      }
    } catch (e) {
      print("Error delete: $e");
      return false;
    }
  }
}
