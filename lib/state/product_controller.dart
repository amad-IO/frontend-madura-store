import 'package:flutter/foundation.dart';
import '../data/models/product.dart';
import '../data/services/product_service.dart';
import 'dart:io';

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
      _items = await _service.getProducts();
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
      final ok = await _service.updateProduct(
        id: p.id,
        nama: p.nama,
        hargaJual: p.hargaJual,
        stok: p.stok,
        satuan: p.satuan,
        imageFile: imageFile,
      );

      if (ok) {
        await loadProducts();
        return true;  // ⬅ WAJIB
      } else {
        print("Gagal update produk");
        return false; // ⬅ WAJIB
      }
    } catch (e) {
      print("Error update: $e");
      return false;  // ⬅ WAJIB
    }
  }

  Future<bool> add(Product p, File? imageFile) async {
    try {
      final ok = await _service.addProduct(
        imageFile: imageFile!,
        nama: p.nama,
        hargaJual: p.hargaJual,
        stok: p.stok,
        satuan: p.satuan,
      );

      if (ok) {
        await loadProducts();
        return true;   // ⬅ WAJIB
      } else {
        print("Gagal tambah produk");
        return false;  // ⬅ WAJIB
      }
    } catch (e) {
      print("Error add product: $e");
      return false;    // ⬅ WAJIB
    }
  }

  Future<bool> delete(int id) async {
    try {
      final ok = await _service.deleteProduct(id);

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
