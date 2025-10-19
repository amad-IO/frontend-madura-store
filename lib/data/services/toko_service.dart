import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/api_config.dart';
import '../models/toko.dart';

/// Kontrak service
abstract class TokoService {
  Future<List<Toko>> fetchAll();
  Future<Toko> create(Toko data);
  Future<Toko> update(Toko data); // berdasarkan data.id
  Future<void> delete(String id);
}

/// ===== MOCK (in-memory) – dipakai sementara =====
class TokoServiceMock implements TokoService {
  final List<Toko> _store = []; // mulai 1 kotak kosong

  @override
  Future<List<Toko>> fetchAll() async => List.unmodifiable(_store);

  @override
  Future<Toko> create(Toko data) async {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    final created = data.copyWith(id: id);
    _store.add(created);
    return created;
  }

  @override
  Future<Toko> update(Toko data) async {
    final idx = _store.indexWhere((e) => e.id == data.id);
    if (idx != -1) _store[idx] = data;
    return data;
  }

  @override
  Future<void> delete(String id) async {
    _store.removeWhere((e) => e.id == id);
  }
}

/// ===== HTTP (Java + MySQL) – aktifkan nanti =====
/// Contoh endpoint (silakan sesuaikan):
/// GET    /api/toko
/// POST   /api/toko
/// PUT    /api/toko/{id}
/// DELETE /api/toko/{id}
class TokoServiceHttp implements TokoService {
  final http.Client _c;
  TokoServiceHttp([http.Client? c]) : _c = c ?? http.Client();

  String get _base => ApiConfig.resolvedBaseUrl;

  @override
  Future<List<Toko>> fetchAll() async {
    final r = await _c.get(Uri.parse('$_base/api/toko'));
    final list = (jsonDecode(r.body) as List).map((e) => Toko.fromJson(e)).toList();
    return list;
  }

  @override
  Future<Toko> create(Toko data) async {
    final r = await _c.post(
      Uri.parse('$_base/api/toko'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data.toJson()),
    );
    return Toko.fromJson(jsonDecode(r.body));
  }

  @override
  Future<Toko> update(Toko data) async {
    final r = await _c.put(
      Uri.parse('$_base/api/toko/${data.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data.toJson()),
    );
    return Toko.fromJson(jsonDecode(r.body));
  }

  @override
  Future<void> delete(String id) async {
    await _c.delete(Uri.parse('$_base/api/toko/$id'));
  }
}
