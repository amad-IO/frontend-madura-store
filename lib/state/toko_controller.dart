import 'package:flutter/foundation.dart';
import '../data/models/toko.dart';
import '../data/services/toko_service.dart';

class TokoController extends ChangeNotifier {
  final TokoService _service;

  /// Konstruktor untuk mode mock (testing lokal)
  TokoController.mock() : _service = TokoServiceMock();

  /// Konstruktor untuk mode http (terhubung ke backend)
  TokoController.http() : _service = TokoServiceHttp();

  // ======================================================
  // 🔹 STATE
  // ======================================================
  List<Toko> _items = [];
  List<Toko> get items => _items;

  bool _loading = false;
  bool get loading => _loading;

  // ======================================================
  // 🔹 LOAD DATA DARI SERVICE
  // ======================================================
  Future<void> load() async {
    _loading = true;
    notifyListeners();

    try {
      _items = await _service.fetchAll();
    } catch (e, st) {
      debugPrint("Gagal memuat toko: $e");
      debugPrintStack(stackTrace: st);
      _items = []; // fallback biar gak error
    }

    _loading = false;
    notifyListeners();
  }


  // ======================================================
  // 🔹 SIMPAN ATAU UPDATE DATA DI INDEX TERTENTU
  // ======================================================
  Future<void> saveAt(int index, Toko data) async {
    if (data.id == null) {
      // Jika belum punya ID → buat baru di server lalu gantikan data di list
      final created = await _service.create(data);
      _items[index] = created;
    } else {
      // Jika sudah punya ID → update data
      final updated = await _service.update(data);
      _items[index] = updated;
    }

    notifyListeners();
  }

  // ======================================================
  // 🔹 TAMBAH TOKO BARU (untuk popup tambah toko)
  // ======================================================
  Future<void> addItem(Toko data) async {
    // Buat data baru via service
    final created = await _service.create(data);

    // Tambahkan ke daftar toko
    _items = [..._items, created];

    notifyListeners();
  }

  // ======================================================
  // 🔹 TAMBAH SATU TOKO KOSONG (default kosong)
  // ======================================================
  Future<void> addEmpty() async {
    final created = await _service.create(Toko.empty());
    _items = [..._items, created];
    notifyListeners();
  }

  // ======================================================
  // 🔹 HAPUS TOKO BERDASARKAN INDEX
  // ======================================================
  Future<void> deleteAt(int index) async {
    final item = _items[index];

    // Jika data sudah tersimpan di server → hapus dari backend
    if (item.id != null) {
      await _service.delete(item.id!);
    }

    // Hapus dari daftar lokal
    _items.removeAt(index);



    notifyListeners();
  }
}
