class Product {
  final int id;
  final String nama;
  final double hargaJual;
  final int stok;
  final String satuan;
  final String imageName;

  Product({
    required this.id,
    required this.nama,
    required this.hargaJual,
    required this.stok,
    required this.satuan,
    required this.imageName,
  });

  String get imageUrl =>
      "http://localhost:8080/api/produk/gambar/$imageName"; // tampilkan foto

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      nama: json['nama'],
      hargaJual: json['hargaJual'],
      stok: json['stok'],
      satuan: json['satuan'],
      imageName: json['imageName'] ?? "",  // jika null
    );
  }
}
