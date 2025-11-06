import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/forgot_password_request.dart';
import '../models/verify_otp_request.dart';
import '../models/forgot_password_response.dart';

class ForgotPasswordService {
  static const String baseUrl = 'http://10.0.2.2:8080/api/auth'; // ganti sesuai backend kamu

  // Kirim OTP ke nomor pengguna
  static Future<ForgotPasswordResponse> sendOtp(ForgotPasswordRequest req) async {
    final url = Uri.parse('$baseUrl/send-otp');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(req.toJson()),
    );

    if (response.statusCode == 200) {
      return ForgotPasswordResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Gagal mengirim OTP');
    }
  }

  // Verifikasi OTP
  static Future<ForgotPasswordResponse> verifyOtp(VerifyOtpRequest req) async {
    final url = Uri.parse('$baseUrl/verify-otp');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(req.toJson()),
    );

    if (response.statusCode == 200) {
      return ForgotPasswordResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Verifikasi OTP gagal');
    }
  }
}
