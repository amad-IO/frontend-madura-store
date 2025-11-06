class TambahTokoRequest {
  final String namaToko;
  final String alamat;
  final int kasirId;

  TambahTokoRequest({
    required this.namaToko,
    required this.alamat,
    required this.kasirId,
  });

  Map<String, dynamic> toJson() => {
    'namaToko': namaToko,
    'alamat': alamat,
    'kasirId': kasirId,
  };
}
