// lib/data/models/product_request.dart
class ProductRequest {
  final String nama;
  final double hargaJual;
  final int stok;
  final String satuan;

  ProductRequest({
    required this.nama,
    required this.hargaJual,
    required this.stok,
    required this.satuan,
  });

  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'hargaJual': hargaJual,
      'stok': stok,
      'satuan': satuan,
    };
  }
}
