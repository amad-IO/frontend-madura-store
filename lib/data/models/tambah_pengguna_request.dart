class TambahPenggunaRequest {
  final String nama;
  final String username;
  final String password;
  final String phone;

  TambahPenggunaRequest({
    required this.nama,
    required this.username,
    required this.password,
    required this.phone, required String namaKasir, required String namaToko, required String alamat,
  });

  Map<String, dynamic> toJson() {
    return {
      "nama": nama,
      "username": username,
      "password": password,
      "phone": phone,
    };
  }
}
