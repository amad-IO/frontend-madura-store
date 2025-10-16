import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/app_theme.dart';
import '../../core/app_routes.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final _usernameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _usernameCtrl.dispose();
    _phoneCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Register success (dummy)', style: GoogleFonts.poppins()),
        ),
      );
      Navigator.pop(context);
      // Atau: Navigator.pushNamedAndRemoveUntil(context, AppRoutes.dashboard, (r) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppTheme.primaryRed,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: 16,
              child: Text(
                'Register',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Positioned.fill(
              top: 100,
              child: Container(
                decoration: const BoxDecoration(
                  color: AppTheme.primaryCream,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(29),
                    topRight: Radius.circular(29),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      const Positioned(
                        top: 0, // makin kecil = makin naik (coba 0–12)
                        child: SizedBox(
                          width: 146,
                          height: 146,
                          child: Image(
                            image: AssetImage('assets/images/logo3.png'),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),

                      // TEKS — tepat di bawah logo
                      Positioned(
                        top: 146, // atur sesuai kebutuhan
                        child: Text(
                          'Kasir madura',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: AppTheme.primaryRed,
                            fontSize: 20,
                            fontWeight: FontWeight.w700, // lebih tebal (Bold)
                            letterSpacing: 0,
                            height: 1.0,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Username',
                                style: t.titleMedium?.copyWith(
                                  color: AppTheme.textPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),

                            TextFormField(
                              controller: _usernameCtrl,
                              textInputAction: TextInputAction.next,
                              decoration: _inputDecoration(
                                context,
                                hint: 'username',
                                icon: Icons.person_outline_rounded,
                              ),
                              validator: (x) {
                                if (x == null || x.trim().isEmpty) {
                                  return 'Username tidak boleh kosong';
                                }
                                final re = RegExp(
                                  r'^(?=.{3,20}$)(?![._-])(?!.*[._-]{2})[a-zA-Z0-9._-]+(?<![._-])$',
                                );
                                if (!re.hasMatch(x.trim())) {
                                  return 'Gunakan 3–20 karakter: huruf/angka . _ - (tidak diawali/diakhiri simbol)';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),

                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Nomor handphone',
                                style: t.titleMedium?.copyWith(
                                  color: AppTheme.textPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _phoneCtrl,
                              keyboardType: TextInputType.phone,
                              textInputAction: TextInputAction.next,
                              decoration: _inputDecoration(
                                context,
                                hint: 'Enter your number',
                                icon: Icons.phone_outlined,
                              ),
                              validator: (x) {
                                if (x == null || x.trim().isEmpty) {
                                  return 'Nomor handphone tidak boleh kosong';
                                }
                                final re = RegExp(r'^[0-9+\s()-]{8,15}$');
                                if (!re.hasMatch(x.trim())) {
                                  return 'Nomor tidak valid';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),

                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Password',
                                style: t.titleMedium?.copyWith(
                                  color: AppTheme.textPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _passwordCtrl,
                              obscureText: _obscure,
                              textInputAction: TextInputAction.done,
                              decoration: _inputDecoration(
                                context,
                                hint: 'Enter your password',
                                icon: Icons.lock_outline_rounded,
                                suffix: IconButton(
                                  icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
                                  onPressed: () => setState(() => _obscure = !_obscure),
                                ),
                              ),
                              validator: (x) {
                                if (x == null || x.isEmpty) {
                                  return 'Password tidak boleh kosong';
                                }
                                if (x.length < 8) {
                                  return 'Min. 8 karakter';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 28),

                      Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 300), // lebar maksimum seperti tombol login
                          child: SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment(-1.0, -0.05),
                                  end: Alignment(1.0, 0.05),
                                  colors: [AppTheme.primaryOrange, AppTheme.primaryRed],
                                ),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: ElevatedButton(
                                onPressed: _submit,
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                ),
                                child: Text(
                                  'Next',
                                  style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    height: 1.2,
                                    color: AppTheme.primaryWhite,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),


                      const SizedBox(height: 16),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Have an account? ',
                            style: GoogleFonts.poppins(
                              color: AppTheme.textPrimary,
                              fontSize: 14,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if (Navigator.canPop(context)) {
                                Navigator.pop(context);
                              } else {
                                Navigator.pushReplacementNamed(context, AppRoutes.login);
                              }
                            },
                            borderRadius: BorderRadius.circular(6),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                              child: Text(
                                'Sign In',
                                style: GoogleFonts.poppins(
                                  color: AppTheme.primaryRed,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),
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

  InputDecoration _inputDecoration(
      BuildContext context, {
        required String hint,
        required IconData icon,
        Widget? suffix,
      }) {
    final theme = Theme.of(context).inputDecorationTheme;

    final decoration = InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, color: AppTheme.textSubtle),
      suffixIcon: suffix,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: AppTheme.border, width: 1.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: AppTheme.border, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: AppTheme.primaryRed, width: 2.0),
      ),
      filled: true,
      fillColor: AppTheme.primaryWhite,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );

    return decoration.applyDefaults(theme);
  }
}