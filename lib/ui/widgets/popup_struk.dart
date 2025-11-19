import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/app_theme.dart';
import '../../state/cart_controller.dart';

class PopupStruk extends StatelessWidget {
  final CartController cart;
  final String dibayar;
  final double kembalian;

  const PopupStruk({
    super.key,
    required this.cart,
    required this.dibayar,
    required this.kembalian,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: AppTheme.primaryCream,

      title: Text(
        'Transaksi Berhasil',
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          color: AppTheme.primaryRed,
        ),
      ),

      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // ===== LIST PRODUK =====
          ...cart.items.map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                "${item.product.nama}  x${item.qty}   =  Rp${(item.product.hargaJual * item.qty).toInt()}",
                style: GoogleFonts.poppins(fontSize: 14),
              ),
            );
          }),

          const SizedBox(height: 12),

          Text(
            "Total: Rp${cart.totalHarga.toInt()}",
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),

          Text(
            "Dibayar: Rp$dibayar",
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),

          Text(
            "Kembalian: Rp${kembalian.toInt()}",
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),
        ],
      ),

      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // tutup popup
            Navigator.pop(context); // kembali ke dashboard
          },
          child: Text(
            "OK",
            style: GoogleFonts.poppins(
              color: AppTheme.primaryRed,
              fontWeight: FontWeight.w600,
            ),
          ),
        )
      ],
    );
  }
}
