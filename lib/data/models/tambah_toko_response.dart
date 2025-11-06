class TambahTokoResponse {
  final bool success;
  final String message;
  final dynamic data;

  TambahTokoResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory TambahTokoResponse.fromJson(Map<String, dynamic> json) {
    return TambahTokoResponse(
      success: json['success'] ?? true,  // jika backend kirim field success
      message: json['message'] ?? 'Berhasil',
      data: json['data'] ?? json,        // fallback ke json penuh
    );
  }
}
