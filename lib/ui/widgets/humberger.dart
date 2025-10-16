import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../core/app_theme.dart';
import 'dart:math' as math;

/// Panggil ini dari tombol hamburger:
/// await showHamburgerMenu(context, onLaporan: ..., onTambahToko: ..., onEditProduk: ..., onLogout: ...);
Future<void> showHamburgerMenu(
    BuildContext context, {
      VoidCallback? onLaporan,
      VoidCallback? onTambahToko,
      VoidCallback? onEditProduk,
      VoidCallback? onLogout,
    }) {
  return showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Menu',
    barrierColor: Colors.black54, // backdrop
    transitionDuration: const Duration(milliseconds: 280),
    pageBuilder: (context, _, __) {
      // kosong — UI dibangun di transitionBuilder
      return const SizedBox.shrink();
    },
    transitionBuilder: (context, anim, _, __) {
      final curved = CurvedAnimation(parent: anim, curve: Curves.easeOutCubic);
      final slide = Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero).animate(curved);

      final panelWidth = math.min(MediaQuery.of(context).size.width * 0.82, 320.0);

      return Stack(
        children: [
          // Dismiss area
          Positioned.fill(
            child: GestureDetector(onTap: () => Navigator.of(context).pop()),
          ),
          // Panel geser dari kiri
          Align(
            alignment: Alignment.centerLeft,
            child: SlideTransition(
              position: slide,
              child: _HamburgerPanel( // 🚀 hilangkan SafeArea
                width: panelWidth,
                onLaporan: onLaporan,
                onTambahToko: onTambahToko,
                onEditProduk: onEditProduk,
                onLogout: onLogout,
              ),
            ),
          ),
        ],
      );
    },
  );
}

class _HamburgerPanel extends StatelessWidget {
  final double width;
  final VoidCallback? onLaporan;
  final VoidCallback? onTambahToko;
  final VoidCallback? onEditProduk;
  final VoidCallback? onLogout;

  const _HamburgerPanel({
    required this.width,
    this.onLaporan,
    this.onTambahToko,
    this.onEditProduk,
    this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final bottomInset = MediaQuery.of(context).padding.bottom;

    return Container(
      width: width,
      // hilangkan margin kiri, biar nempel ke tepi
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias, // agar isi ter-clip radius kanan
      decoration: const BoxDecoration(
        color: AppTheme.primaryWhite,
        // radius kanan saja
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(150),
          bottomRight: Radius.circular(15),
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowLight,
            blurRadius: 18,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header gradient (radius kanan saja)
          Container(
            height: 140,
            decoration: const BoxDecoration(
              gradient: AppTheme.primaryGradient,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(21),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(20, 16, 16, 16),
            alignment: Alignment.bottomLeft,
            child: Text(
              'Menu Madura Store',
              style: t.titleLarge?.copyWith(
                color: AppTheme.primaryWhite,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          const SizedBox(height: 100),

          // Menu item (biarkan sama seperti sebelumnya)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                _OutlineMenuButton(
                  label: 'Laporan penjualan',
                  icon: Icons.assessment_outlined,
                  onTap: onLaporan,
                ),
                const SizedBox(height: 16),
                _OutlineMenuButton(
                  label: 'Tambah toko',
                  icon: Icons.store_mall_directory_outlined,
                  onTap: onTambahToko,
                ),
                const SizedBox(height: 16),
                _OutlineMenuButton(
                  label: 'Edit produk',
                  icon: Icons.edit_outlined,
                  onTap: onEditProduk,
                ),
              ],
            ),
          ),

          const Spacer(),

          // Tombol logout
      Padding(
        // gunakan bottom inset supaya tidak ketutup gesture bar
        padding: EdgeInsets.fromLTRB(
          20,
          8,
          100,
          math.max(24, MediaQuery.of(context).padding.bottom + 16),
        ),
        child: SizedBox(
          height: 48,
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: onLogout,
            icon: Transform.rotate(
              angle: 3.1416, // 180 derajat (π radian)
              child: const Icon(Icons.logout_rounded),
            ),
            label: const Text('Logout'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryRed,
              foregroundColor: AppTheme.primaryWhite,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14),
                  bottomLeft: Radius.circular(14),
                  topRight: Radius.circular(0),   // 👈 kanan 0
                  bottomRight: Radius.circular(50), // 👈 kanan bawah besar (setengah lingkaran)
                ),
              ),
              textStyle: t.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
         ),
        ],
      ),
    );

  }
}

class _OutlineMenuButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onTap;

  const _OutlineMenuButton({
    required this.label,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.primaryOrange, width: 1.2),
          ),
          child: Row(
            children: [
              Icon(icon, color: AppTheme.primaryRed),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: t.titleMedium?.copyWith(
                    color: AppTheme.primaryRed,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: AppTheme.textSubtle),
            ],
          ),
        ),
      ),
    );
  }
}
