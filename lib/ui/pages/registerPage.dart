import 'package:flutter/material.dart';
import '../../core/app_theme.dart';
import '../../core/app_routes.dart'; // pastikan ada route login
import 'package:google_fonts/google_fonts.dart';

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

  // Validasi username (3–20, huruf/angka . _ -, tidak diawali/diakhiri simbol, tidak dobel simbol)
  String? _validateUsername(String? x) {
    final v = x?.trim() ?? '';
    final re = RegExp(r'^(?=.{3,20}$)(?![._-])(?!.*[._-]{2})[a-zA-Z0-9._-]+(?<![._-])$');
    if (v.isEmpty) return 'Username wajib diisi';
    if (!re.hasMatch(v)) {
      return '3–20: huruf/angka . _ - (tidak boleh diawali/diakhiri simbol)';
    }
    return null;
  }

  String? _validatePhone(String? x) {
    final v = x?.trim() ?? '';
    if (v.isEmpty) return 'Nomor hp wajib diisi';
    // sederhana: 9–15 digit, boleh mulai +62/0
    final re = RegExp(r'^(?:\+?62|0)\d{8,13}$');
    if (!re.hasMatch(v)) return 'Nomor hp tidak valid';
    return null;
  }

  String? _validatePassword(String? x) {
    final v = x ?? '';
    if (v.length < 6) return 'Minimal 6 karakter';
    return null;
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO: panggil backend/register di layer service/state kamu
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Register berhasil (mock)')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppTheme.primaryCream,
      body: SafeArea(
        child: Stack(
          children: [
            // Header merah besar dengan sudut bulat
            Container(
              height: 220,
              decoration: const BoxDecoration(
                color: AppTheme.primaryRed,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(48),
                  bottomRight: Radius.circular(48),
                ),
              ),
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.only(top: 24),
              child: Text(
                'Register',
                style: t.headlineMedium?.copyWith(
                  color: AppTheme.primaryWhite,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            // Konten
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 140, 24, 24),
              child: Column(
                children: [
                  // kartu krem (feel figma)
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryCream.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(24),
                      // opsional: tambahkan efek blur kaca (frosted glass)
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),

                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        // Logo
                        Container(
                          width: 146,
                          height: 146,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/logo3.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Madura Store',
                          style: t.titleLarge?.copyWith(
                            color: AppTheme.primaryRed,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // FORM
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 16),
                              Text('Username', style: t.titleMedium?.copyWith(color: AppTheme.textPrimary)),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: _usernameCtrl,
                                validator: _validateUsername,
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                  hintText: 'username',
                                  prefixIcon: Icon(Icons.person_outline),
                                ),
                              ),

                              const SizedBox(height: 16),
                              Text('Nomer hanphone', style: t.titleMedium?.copyWith(color: AppTheme.textPrimary)),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: _phoneCtrl,
                                validator: _validatePhone,
                                keyboardType: TextInputType.phone,
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                  hintText: 'Enter your number',
                                  prefixIcon: Icon(Icons.phone_outlined),
                                ),
                              ),

                              const SizedBox(height: 16),
                              Text('Password', style: t.titleMedium?.copyWith(color: AppTheme.textPrimary)),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: _passwordCtrl,
                                validator: _validatePassword,
                                obscureText: _obscure,
                                decoration: InputDecoration(
                                  hintText: 'Enter your password',
                                  prefixIcon: const Icon(Icons.lock_outline),
                                  suffixIcon: IconButton(
                                    onPressed: () => setState(() => _obscure = !_obscure),
                                    icon: Icon(_obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 28),
                              // Tombol gradient sesuai AppTheme.primaryGradient
                              Center(
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(maxWidth: 300), // ubah 260–320 sesuai selera
                                  child: SizedBox(
                                    width: double.infinity, // biar mengisi sampai maxWidth di atas
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
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                                          padding: const EdgeInsets.symmetric(vertical: 16),
                                        ),
                                        child: Text(
                                          'Next',
                                          style: GoogleFonts.poppins(
                                            fontSize: 20, fontWeight: FontWeight.w600,
                                            height: 1.2, color: AppTheme.primaryWhite,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),


                              const SizedBox(height: 20),
                              Center(
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Text('Have an account? ', style: t.bodyLarge?.copyWith(color: AppTheme.textPrimary)),
                                    InkWell(
                                      onTap: () => Navigator.pushReplacementNamed(context, AppRoutes.login),
                                      child: Text(
                                        'Sign In',
                                        style: t.bodyLarge?.copyWith(
                                          color: AppTheme.primaryRed,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 12),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
