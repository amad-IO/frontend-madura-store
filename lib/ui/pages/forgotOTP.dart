import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/app_theme.dart';
import '../../core/app_routes.dart';
import '../../data/models/verify_otp_request.dart';
import '../../data/models/verify_otp_response.dart';
import '../../data/services/forgot_otp_service.dart';

class ForgotOTPPage extends StatefulWidget {
  ForgotOTPPage({super.key});

  @override
  State<ForgotOTPPage> createState() => _ForgotOTPPageState();
}

class _ForgotOTPPageState extends State<ForgotOTPPage> {
  final _otpControllers = List.generate(4, (_) => TextEditingController());
  bool _isLoading = false;

  @override
  void dispose() {
    for (final c in _otpControllers) c.dispose();
    super.dispose();
  }

  Future<void> _submit(String phone) async {
    final otp = _otpControllers.map((c) => c.text).join();
    if (otp.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppTheme.error,
          content: Text('Masukkan kode OTP lengkap', style: GoogleFonts.poppins(color: Colors.white)),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final req = VerifyOtpRequest(phone: phone, otp: otp);
      final VerifyOtpResponse res = await ForgotOtpService.verifyOtp(req);

      if (res.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppTheme.primaryRed,
            content: Text(res.message ?? 'OTP berhasil diverifikasi!',
                style: GoogleFonts.poppins(color: Colors.white)),
          ),
        );
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppTheme.error,
            content: Text(res.message ?? 'Kode OTP salah atau kadaluarsa',
                style: GoogleFonts.poppins(color: Colors.white)),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppTheme.error,
          content: Text('Terjadi kesalahan: $e', style: GoogleFonts.poppins(color: Colors.white)),
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final phone = ModalRoute.of(context)?.settings.arguments as String?;
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: AppTheme.primaryRed,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 100),
              Text('Enter OTP', style: GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.w700, color: AppTheme.textPrimary)),
              const SizedBox(height: 16),
              Text('We sent a code to ${phone ?? "your number"}', style: GoogleFonts.poppins(fontSize: 16, color: AppTheme.textSubtle)),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (i) {
                  return SizedBox(
                    width: 60,
                    child: TextField(
                      controller: _otpControllers[i],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      decoration: InputDecoration(counterText: '', filled: true, fillColor: cs.surface),
                      onChanged: (v) {
                        if (v.isNotEmpty && i < 3) FocusScope.of(context).nextFocus();
                      },
                    ),
                  );
                }),
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading || phone == null ? null : () => _submit(phone),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryRed,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text('Verify OTP', style: GoogleFonts.poppins(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
