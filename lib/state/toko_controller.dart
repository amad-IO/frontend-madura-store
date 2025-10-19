import 'package:flutter/foundation.dart';
import '../data/models/toko.dart';
import '../data/services/toko_service.dart';

class TokoController extends ChangeNotifier {
  final TokoService _service;
  TokoController.mock() : _service = TokoServiceMock();
  TokoController.http() : _service = TokoServiceHttp();

  List<Toko> _items = [];
  List<Toko> get items => _items;

  bool _loading = false;
  bool get loading => _loading;

  Future<void> load() async {
    _loading = true; notifyListeners();
    _items = await _service.fetchAll();
    _loading = false;

    if (_items.isEmpty) {
      _items = [Toko.empty()];
    }
    notifyListeners();
  }

  Future<void> addEmpty() async {
    final created = await _service.create(Toko.empty());
    _items = [..._items, Toko.empty()];
    notifyListeners();
  }

  Future<void> saveAt(int index, Toko data) async {
    if (data.id == null) {
      // Placeholder → buat ke server lalu GANTI item di index tsb
      final created = await _service.create(data);
      _items[index] = created;
    } else {
      // Sudah ada id → update
      final updated = await _service.update(data);
      _items[index] = updated;
    }
    notifyListeners();
  }


  /// Hapus berdasarkan index (termasuk kartu kosong)
  Future<void> deleteAt(int index) async {
    final item = _items[index];
    if (item.id != null) {
      // kalau sudah punya id dari server
      await _service.delete(item.id!);
    }
    _items.removeAt(index);

    // kalau setelah dihapus list jadi kosong, tambahkan 1 kotak kosong
    if (_items.isEmpty) {
      _items = [Toko.empty()];
    }

    notifyListeners();
  }

}
