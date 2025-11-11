class Toko {
  final String? id;
  final String namaToko;
  final String alamat;
  final String namaKasir;

  final String? nomorTelp;   // ➕ Ditambahkan
  final String? password;    // ➕ Ditambahkan

  const Toko({
    this.id,
    required this.namaToko,
    required this.alamat,
    required this.namaKasir,
    this.nomorTelp,
    this.password,
  });

  factory Toko.empty() => const Toko(
    namaToko: '',
    alamat: '',
    namaKasir: '',
    nomorTelp: '',
    password: '',
  );

  Toko copyWith({
    String? id,
    String? namaToko,
    String? alamat,
    String? namaKasir,
    String? nomorTelp,
    String? password,
  }) {
    return Toko(
      id: id ?? this.id,
      namaToko: namaToko ?? this.namaToko,
      alamat: alamat ?? this.alamat,
      namaKasir: namaKasir ?? this.namaKasir,
      nomorTelp: nomorTelp ?? this.nomorTelp,
      password: password ?? this.password,
    );
  }

  bool get isEmpty =>
      namaToko.trim().isEmpty &&
          alamat.trim().isEmpty &&
          namaKasir.trim().isEmpty;

  factory Toko.fromJson(Map<String, dynamic> j) => Toko(
    id: j['id']?.toString(),
    namaToko: j['namaToko'] ?? '',
    alamat: j['alamat'] ?? '',
    namaKasir: j['namaKasir'] ?? '',
    nomorTelp: j['nomorTelp'],      // ➕ Ditambahkan
    password: j['password'],        // ➕ Ditambahkan
  );

  Map<String, dynamic> toJson() => {
    if (id != null) 'id': id,
    'namaToko': namaToko,
    'alamat': alamat,
    'namaKasir': namaKasir,
    'nomorTelp': nomorTelp,        // ➕ Ditambahkan
    'password': password,          // ➕ Ditambahkan
  };
}
