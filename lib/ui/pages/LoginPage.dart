import 'package:flutter/material.dart';
import '../../core/app_routes.dart';
import '../../core/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../ui/pages/dashboardPage.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _pass  = TextEditingController();
  bool _obscure = true;

  OutlineInputBorder _rounded(Color c) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(color: c, width: 1),
  );

  InputDecoration _dec({
    required String hint,
    required IconData icon,
    required Color iconColor,
    Widget? suffix,
    required Color fieldFill,
  }) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, color: iconColor),
      suffixIcon: suffix,
      filled: true,
      fillColor: fieldFill,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      border: _rounded(Colors.transparent),
      enabledBorder: _rounded(Colors.transparent),
      focusedBorder: _rounded(Colors.transparent), // tidak pakai warna brand saat fokus
      errorBorder: _rounded(AppTheme.error),
      focusedErrorBorder: _rounded(AppTheme.error),
    );
  }

  String? _vEmail(String? v){
    if(v==null||v.trim().isEmpty) return 'Email tidak boleh kosong';
    final re = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    if(!re.hasMatch(v.trim())) return 'Format email tidak valid';
    return null;
  }

  String? _vPass(String? v){
    if(v==null||v.isEmpty) return 'Password tidak boleh kosong';
    if(v.length<6) return 'Minimal 6 karakter';
    return null;
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    FocusScope.of(context).unfocus(); // tutup keyboard

    // 🚀 Langsung arahkan ke dashboard tanpa backend
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const DashboardPage()),
    );
  }

  // void _submit(){
  //   if(!(_formKey.currentState?.validate()??false)) return;
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(content: Text('Login sukses (simulasi)')),
  //   );
  //   // TODO: auth & navigate (Navigator.pushReplacementNamed(context, AppRoutes.home);)
  // }

  @override
  void dispose() { _email.dispose(); _pass.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final cs   = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    final topH  = size.height * 0.42;
    const logoW = 146.0;

    return Scaffold(
      // header pakai primaryRed
      backgroundColor: AppTheme.primaryRed,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            // ===== HEADER MERAH ROUNDED =====
            Container(
              height: topH,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppTheme.primaryRed,
                    // “red dark” dibuat dari palet yang sama (lebih pekat)
                    AppTheme.primaryRed.withOpacity(0.95),
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
            ),

            // Panel pink semi-transparan + logo + title
            // Panel pink semi-transparan + logo + title (390 x 314)
            Positioned(
              top: 64,           // atur jarak dari atas header merah (sesuaikan 56–80)
              left: 20,          // 430 - (20+20) = 390
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
                        // LOGO — dinaikkan beberapa pixel (atur nilai top sesuai selera)
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
                            'Kasir maduraa',
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
                      ],
                    ),

                  ),
                ),
              ),
            ),


            // ===== PANEL KREM BESAR (CONTENT) =====
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppTheme.primaryCream, // dari palette
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(38),
                    topRight: Radius.circular(38),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 36),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 430),
                    child: Center(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // TITLE "Sign In"
                            Center(
                              child: Text(
                                'Sign In',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 32,                 // samakan dengan Figma (ubah jika perlu)
                                  fontWeight: FontWeight.w700,  // BLACK (lebih tebal dari w800)
                                  height: 1.0,                  // line-height rapat seperti “Auto”
                                  letterSpacing: 0,             // 0% tracking
                                  color: Theme.of(context).colorScheme.onSurface, // hitam/teks utama
                                ),
                              ),
                            ),
                            const SizedBox(height: 28),

                            // Label Email
                            Text(
                              'Email Address',
                              style: text.titleSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 8),

                            // Field Email
                            TextFormField(
                              controller: _email,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              decoration: _dec(
                                hint: 'Enter your E-mail',
                                icon: Icons.mail_outline_rounded,
                                iconColor: AppTheme.textPrimary,
                                fieldFill: cs.surface, // putih dari theme
                              ),
                              validator: _vEmail,
                            ),

                            const SizedBox(height: 20),

                            // Label Password
                            Text(
                              'Password',
                              style: text.titleSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 8),

                            // Field Password + eye
                            TextFormField(
                              controller: _pass,
                              obscureText: _obscure,
                              textInputAction: TextInputAction.done,
                              onFieldSubmitted: (_) => _submit(),
                              decoration: _dec(
                                hint: 'Enter your password',
                                icon: Icons.lock_outline_rounded,
                                iconColor: AppTheme.textPrimary,
                                fieldFill: cs.surface,
                                suffix: IconButton(
                                  onPressed: ()=> setState(()=> _obscure = !_obscure),
                                  icon: Icon(
                                    _obscure ? Icons.visibility_off : Icons.visibility,
                                    color: AppTheme.textPrimary,
                                  ),
                                  tooltip: _obscure ? 'Show password' : 'Hide password',
                                ),
                              ),
                              validator: _vPass,
                            ),

                            const SizedBox(height: 10),

                            // Forgot
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: (){},
                                child: Text(
                                  'Forgot your password?',
                                  style: text.bodySmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.primaryRed,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 12),

                            // TOMBOL LOGIN (gradient, pill) — gradient pakai palette
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
                                        'Login',
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

                            // Signup text
                            Center(
                              child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                spacing: 6,
                                children: [
                                  Text(
                                    "Don’t have an account?",
                                    style: text.bodyMedium?.copyWith(color: cs.onSurface),
                                  ),
                                  Text(
                                    "Sign Up",
                                    style: text.bodyMedium?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: cs.primary),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ),
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
