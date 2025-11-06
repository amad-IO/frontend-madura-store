// lib/data/models/product_response.dart
class ProductResponse {
  final int id;
  final String nama;
  final double hargaJual;
  final int stok;
  final String satuan;

  ProductResponse({
    required this.id,
    required this.nama,
    required this.hargaJual,
    required this.stok,
    required this.satuan,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      id: json['id'],
      nama: json['nama'],
      hargaJual: (json['hargaJual'] as num).toDouble(),
      stok: json['stok'],
      satuan: json['satuan'],
    );
  }
}
