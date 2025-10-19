import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/app_theme.dart';
import '../../core/dialog_utils.dart';
import '../../data/models/product.dart';
import '../../state/product_controller.dart';
import '../widgets/product_card.dart';
import '../widgets/humberger.dart';
import 'TambahToko.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;

    return ChangeNotifierProvider(
      create: (_) => ProductController(),
      child: Scaffold(
        backgroundColor: AppTheme.primaryCream,
        body: SafeArea(
          top: false,
          child: Builder(
            builder: (context) {
              final topPad = MediaQuery.of(context).padding.top;

              // ukuran layout
              const double headerBase = 220;
              const double profileCardH = 110;
              const double profileOverlap = 40;

              final double headerH = headerBase + topPad;
              final double contentTop = headerH - profileOverlap + profileCardH;

              return Stack(
                children: [
                  // ====== PRODUK (scrollable) ======
                  Positioned.fill(
                    top: contentTop,
                    child: Consumer<ProductController>(
                      builder: (context, ctrl, _) {
                        final items = ctrl.items;
                        return GridView.builder(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 14,
                            mainAxisSpacing: 14,
                            childAspectRatio: 0.78,
                          ),
                          itemCount: items.length,
                          itemBuilder: (_, i) => ProductCard(
                            product: items[i],
                            onAdd: () {}, // nanti bisa untuk add-to-cart
                          ),
                        );
                      },
                    ),
                  ),

                  // ====== HEADER (fixed) ======
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    height: headerH,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: AppTheme.primaryGradient,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
                      ),
                      child: Stack(
                        children: [
                          // Title di atas tengah
                          Positioned.fill(
                            child: Padding(
                              padding: EdgeInsets.only(top: topPad + 16),
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  'Madura Store',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    height: 1.0,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Tombol hamburger
                          Positioned(
                            left: 20,
                            bottom: 130,
                            child: Builder(
                              builder: (context) => IconButton(
                                icon: const Icon(
                                  Icons.menu_rounded,
                                  size: 40,
                                  color: Colors.white,
                                ),
                                splashRadius: 28,
                                onPressed: () {
                                  showHamburgerMenu(
                                    context,
                                    onLaporan: () {
                                      // TODO: navigasi ke halaman laporan
                                    },
                                    onTambahToko: () {
                                      Navigator.pop(context); // tutup menu dulu
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                          Tambahtoko(),
                                        ),
                                      );
                                    },
                                    onEditProduk: () {
                                      // TODO: navigasi ke halaman edit produk
                                    },
                                    onTambahPengguna: () {
                                      // TODO: navigasi ke halaman edit produk
                                    },
                                    onLogout: () => handleLogout(context),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // ====== PROFILE CARD (fixed) ======
                  Positioned(
                    left: 20,
                    right: 20,
                    top: headerH - profileOverlap,
                    height: profileCardH,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppTheme.accentOrange,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: AppTheme.shadowLight,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 40,
                            backgroundImage:
                            NetworkImage("https://picsum.photos/200"),
                            backgroundColor: Colors.white,
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "AZTECA CHELSY",
                                style:
                                t.titleLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Owner",
                                style:
                                t.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
