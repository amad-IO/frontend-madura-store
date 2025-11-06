import 'package:flutter/foundation.dart';
import '../data/models/toko.dart';
import '../data/services/tambah_toko_service.dart';

class TokoController extends ChangeNotifier {
  List<Toko> items = [];
  bool loading = false;
  final TambahTokoService service;

  TokoController.http() : service = TambahTokoService();

  // Load semua toko dari backend
  Future<void> load() async {
    loading = true;
    notifyListeners();

    try {
      // Misal ambil toko untuk kasir yang sedang login (id=1 sementara)
      final result = await service.getTokoByKasir(1);

      if (result.success) {
        // Konversi data menjadi List<Toko>
        items = [Toko.fromJson(result.data)];
      } else {
        items = [];
      }
    } catch (e) {
      items = [];
    }

    loading = false;
    notifyListeners();
  }

  void addEmpty() {
    items.add(Toko.empty());
    notifyListeners();
  }

  void saveAt(int index, Toko toko) {
    items[index] = toko;
    notifyListeners();
  }

  void deleteAt(int index) {
    items.removeAt(index);
    notifyListeners();
  }
}
