import 'package:flutter/material.dart';
import '../../core/app_routes.dart';
import '../../core/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';




class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    return Scaffold(
      // latar krem sesuai mockup (bisa kamu masukkan ke AppTheme kalau mau)
      backgroundColor: const Color(0xFFFBF4EA),
      body: Stack(
        children: [
          // ===== OVAL GRADIENT BAWAH (lengkung merah→oranye) =====
          Positioned(
            left: -w * 0.55,
            bottom: -w * 0.95,
            child: SizedBox(
              width: w * 2.05,
              height: w * 2.05,
              child: Stack(
                children: [
                  // Base merah solid (#E53E3E)
                  Container(
                    decoration: const ShapeDecoration(
                      color: AppTheme.primaryRed,
                      shape: OvalBorder(),
                    ),
                  ),
                  // Overlay gradient oranye (#F56545) transparan → solid (diagonal)
                  Container(
                    decoration: ShapeDecoration(
                      gradient: LinearGradient(
                        // arah garis gradient sesuai panah di Figma:
                        begin: const Alignment(-0.9, 0.9),  // bottom-left
                        end:   const Alignment(0.5, -0.1),  // menuju top-right
                        colors: [
                          AppTheme.primaryOrange.withOpacity(0.0), // 0% (transparan)
                          AppTheme.primaryOrange,                  // 100% (solid)
                        ],
                        stops: const [0.0, 1.0], // sama seperti Figma
                      ),
                      shape: const OvalBorder(),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ===== KONTEN =====
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: h * 0.12),

                // Logo
                SizedBox(
                  width: 146,
                  height: 146,
                  child: Image.asset(
                    'assets/images/logo3.png',
                    fit: BoxFit.contain,
                  ),
                ),

                const SizedBox(height: 16),

                // Judul brand (pakai primaryRed)
                Text(
                  'Madura Store',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: AppTheme.primaryRed,
                    fontSize: 20,
                    fontWeight: FontWeight.w700, // Figma: Bold
                    letterSpacing: 0,            // 0% seperti Figma
                    height: 1.0,                 // “Auto” line-height
                  ),
                ),

                SizedBox(height: h * 0.25),

                // Teks putih di area gradient
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: w * 0.12),
                  child: Column(
                    children: [
                      const Text(
                        'Solusi Kasir Moderen',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppTheme.primaryWhite,
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Transaksi cepat, laporan otomatis, jualan pun makin lancar.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppTheme.primaryWhite,
                          fontSize: 17,
                          height: 1.35,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Tombol (kuning sesuai desain)
                      SizedBox(
                        width: w * 0.56,
                        height: 52,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFAB12F), // warna utama tombol
                            foregroundColor: Colors.white,             // warna teks & ripple
                            minimumSize: const Size(0, 48),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15), // bentuk rounded
                            ),
                            elevation: 0,                              // tanpa bayangan (flat)
                            overlayColor: Colors.white.withOpacity(0.1), // efek klik putih halus
                          ),
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, AppRoutes.login);
                          },
                          child: const Text(
                            'Get Started',
                            style: TextStyle(
                              fontSize: 20.5,
                              fontWeight: FontWeight.w600,
                              height: 1.0,
                            ),
                          ),
                        ),
                      ),


                      SizedBox(height: h * 0.06),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
