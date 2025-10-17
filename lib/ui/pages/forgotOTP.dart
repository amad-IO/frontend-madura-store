import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/app_theme.dart';
import '../../core/app_routes.dart';


class ForgotOTPPage extends StatefulWidget {
  const ForgotOTPPage({super.key});

  @override
  State<ForgotOTPPage> createState() => _ForgotOTPPageState();
}

class _ForgotOTPPageState extends State<ForgotOTPPage> {
  final _otpControllers =
  List.generate(4, (_) => TextEditingController()); // 4 kotak OTP
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    for (final c in _otpControllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _submit() {
    final otp = _otpControllers.map((c) => c.text).join();
    if (otp.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppTheme.error,
          content: Text('Masukkan kode OTP lengkap',
              style: GoogleFonts.poppins(color: Colors.white)),
        ),
      );
      return;
    }
    // TODO: verifikasi OTP ke backend
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppTheme.primaryRed,
        content: Text('OTP diverifikasi (simulasi)',
            style: GoogleFonts.poppins(color: Colors.white)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final phone = ModalRoute.of(context)?.settings.arguments as String?;
    final cs = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final topH = (size.height * 0.42).clamp(260.0, 420.0);

    return Scaffold(
      backgroundColor: AppTheme.primaryRed,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            // ===== HEADER MERAH =====
            Container(
              height: topH,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppTheme.primaryRed, AppTheme.primaryRed.withOpacity(0.95)],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
            ),

            // Panel pink + logo
            Positioned(
              top: 64,
              left: 20,
              right: 20,
              child: SizedBox(
                height: 314,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(35),
                  child: Container(
                    color: AppTheme.primaryCream.withOpacity(.45),
                    padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        const Positioned(
                          top: 0,
                          child: SizedBox(
                            width: 146,
                            height: 146,
                            child: Image(
                              image: AssetImage('assets/images/logo3.png'),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 146,
                          child: Text(
                            'Madura Store',
                            style: GoogleFonts.poppins(
                              color: AppTheme.primaryRed,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // ===== PANEL BAWAH =====
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                constraints: const BoxConstraints(minHeight: 531),
                decoration: const BoxDecoration(
                  color: AppTheme.primaryCream,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(38),
                    topRight: Radius.circular(38),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                    24, 32, 24, 36 + MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 28),
                      Text(
                        'Forgot Password',
                        style: GoogleFonts.poppins(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'We sent a code to ',
                              style: text.bodyMedium?.copyWith(
                                color: AppTheme.textSubtle,
                              ),
                            ),
                            TextSpan(
                              text: phone ?? 'your number', // tampilkan seluruh nomor
                              style: text.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 40),

                      // ===== INPUT OTP =====
                      Form(
                        key: _formKey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(4, (i) {
                            return SizedBox(
                              width: 60,
                              height: 65,
                              child: TextFormField(
                                controller: _otpControllers[i],
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                maxLength: 1,
                                style: GoogleFonts.poppins(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textPrimary,
                                ),
                                decoration: InputDecoration(
                                  counterText: '',
                                  filled: true,
                                  fillColor: cs.surface,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: AppTheme.primaryRed, width: 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: AppTheme.primaryRed, width: 2),
                                  ),
                                ),
                                onChanged: (v) {
                                  if (v.isNotEmpty && i < 3) {
                                    FocusScope.of(context).nextFocus();
                                  }
                                },
                              ),
                            );
                          }),
                        ),
                      ),

                      const SizedBox(height: 50),

                      // ===== BUTTON SEND =====
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 300),
                        child: SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: DecoratedBox(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment(-1.0, -0.05),
                                  end: Alignment(1.0, 0.05),
                                  colors: [
                                    AppTheme.primaryOrange,
                                    AppTheme.primaryRed
                                  ],
                                ),
                              ),
                              child: ElevatedButton(
                                onPressed: _submit,
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(24)),
                                  ),
                                ),
                                child: Text(
                                  'Send',
                                  style: GoogleFonts.poppins(
                                    color: AppTheme.primaryWhite,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // ===== SIGN UP LINK =====
                      Center(
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 6,
                          children: [
                            Text("Don’t have an account?",
                                style: text.bodyMedium?.copyWith(
                                    color: cs.onSurface)),
                            InkWell(
                              onTap: () => Navigator.pushReplacementNamed(
                                  context, AppRoutes.register),
                              borderRadius: BorderRadius.circular(6),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 2, vertical: 4),
                                child: Text(
                                  "Sign Up",
                                  style: text.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.primaryRed,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
