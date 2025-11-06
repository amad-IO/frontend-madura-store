class TambahPenggunaResponse {
  final int id;
  final String nama;
  final String username;
  final String role;

  TambahPenggunaResponse({
    required this.id,
    required this.nama,
    required this.username,
    required this.role,
  });

  factory TambahPenggunaResponse.fromJson(Map<String, dynamic> json) {
    return TambahPenggunaResponse(
      id: json['id'],
      nama: json['nama'],
      username: json['username'],
      role: json['role'],
    );
  }
}
