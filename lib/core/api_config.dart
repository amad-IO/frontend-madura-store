// lib/core/api_config.dart
import 'dart:io';

/// Kelas ini menyimpan konfigurasi BASE URL untuk koneksi ke backend.
///
/// Cara pakai:
///   import 'package:kasirmadura/core/api_config.dart';
///   final url = Uri.parse('${ApiConfig.baseUrl}/api/products');
///
/// Cara run Flutter:
///   flutter run --dart-define=BASE_URL=http://192.168.1.9:8080
///
/// Catatan:
/// - Gunakan IP laptop kamu (cek via `ipconfig`).
/// - Jika beda jaringan, aktifkan `adb reverse tcp:8080 tcp:8080`
///   lalu gunakan `http://127.0.0.1:8080`.

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
      return 'http://10.0.2.2:8080';
    } else if (Platform.isIOS) {
      // Untuk iOS simulator
      return 'http://localhost:8080';
    } else {
      // Untuk HP fisik (satu Wi-Fi) — ubah sesuai IP laptop kamu
      return 'http://192.168.1.9:8080';
    }
  }
}
