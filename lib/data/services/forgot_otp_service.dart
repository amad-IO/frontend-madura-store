import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/verify_otp_response.dart';
import '../models/verify_otp_request.dart';
import '../models/verify_otp_response.dart';

class ForgotOtpService {
  static const String baseUrl = 'http://10.0.2.2:8080/api/auth'; // sesuaikan IP backend

  static Future<VerifyOtpResponse> verifyOtp(VerifyOtpRequest req) async {
    final url = Uri.parse('$baseUrl/verify-otp');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(req.toJson()),
    );

    if (response.statusCode == 200) {
      return VerifyOtpResponse.fromJson(jsonDecode(response.body));
    } else {
      return VerifyOtpResponse(
        success: false,
        message: 'Verifikasi OTP gagal (${response.statusCode})',
      );
    }
  }
}
