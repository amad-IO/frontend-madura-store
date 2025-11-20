import 'dart:io';

class ApiConfig {
  // BASE_URL bisa dikirim saat run dengan --dart-define.
  static const String baseUrl = String.fromEnvironment('BASE_URL');

  /// Kembalikan BASE_URL yang sudah ditentukan atau default sesuai platform.
  static String get resolvedBaseUrl {
    // Jika diisi lewat --dart-define, pakai itu.
    if (baseUrl.isNotEmpty) return baseUrl;

    // Jika tidak diisi, fallback otomatis.
    if (Platform.isAndroid) {
      // Default untuk emulator Android
      return 'http://localhost:8080';
    } else if (Platform.isIOS) {
      // Untuk iOS simulator
      return 'http://localhost:8080';
    } else {
      // Untuk HP fisik (satu Wi-Fi) — ubah sesuai IP laptop kamu
      return 'http://192.168.1.9:8080';
    }
  }
}
