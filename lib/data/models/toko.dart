class Toko {
  final String? id;            // null saat belum disimpan ke server
  final String namaToko;
  final String alamat;
  final String namaKasir;

  const Toko({this.id, required this.namaToko, required this.alamat, required this.namaKasir});

  factory Toko.empty() => const Toko(namaToko: '', alamat: '', namaKasir: '');

  Toko copyWith({String? id, String? namaToko, String? alamat, String? namaKasir}) {
    return Toko(
      id: id ?? this.id,
      namaToko: namaToko ?? this.namaToko,
      alamat: alamat ?? this.alamat,
      namaKasir: namaKasir ?? this.namaKasir,
    );
  }

  bool get isEmpty => namaToko.trim().isEmpty && alamat.trim().isEmpty && namaKasir.trim().isEmpty;

  factory Toko.fromJson(Map<String, dynamic> j) => Toko(
    id: j['id']?.toString(),
    namaToko: j['namaToko'] ?? '',
    alamat: j['alamat'] ?? '',
    namaKasir: j['namaKasir'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    if (id != null) 'id': id,
    'namaToko': namaToko,
    'alamat': alamat,
    'namaKasir': namaKasir,
  };
}
