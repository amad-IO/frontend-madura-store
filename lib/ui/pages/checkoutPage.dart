import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/app_theme.dart';
import '../../state/cart_controller.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final bayarC = TextEditingController();
  double kembalian = 0;

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartController>();

    return Scaffold(
      backgroundColor: AppTheme.primaryCream,
      resizeToAvoidBottomInset: false,

      // =========================================================
      //                  CUSTOM HEADER
      // =========================================================
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(180),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: ClipRRect(
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(50)),
            child: Container(
              decoration: const BoxDecoration(
                gradient: AppTheme.primaryGradient,
              ),
              child: SafeArea(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: 8,
                      top: 8,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: AppTheme.primaryCream,
                          size: 24,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.receipt_long ,
                          color: AppTheme.primaryCream,
                          size: 40,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Transaksi',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: AppTheme.primaryCream,
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),


      // =========================================================
      //                           BODY
      // =========================================================
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ================= CART ITEMS =================
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: cart.items.map((item) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _buildCartRow(item, context),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 25),

            // ==================== TOTAL BAYAR ====================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Jumlah yang harus dibayar",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Rp${cart.totalHarga.toInt()}",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            // ==================== INPUT PEMBAYARAN ====================
            Text(
              "Input Uang yang dibayarkan",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: bayarC,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Masukkan uang pelanggan",
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.all(14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onChanged: (_) => _hitungKembalian(cart.totalHarga),
            ),

            const SizedBox(height: 20),

            // ==================== KEMBALIAN ====================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Jumlah Kembalian",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Rp${kembalian.toInt()}",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const Spacer(),
          ],
        ),
      ),

      // =========================================================
      //                     BUTTON CHECKOUT
      //     (Sama persis gaya dengan Tambah Toko)
      // =========================================================
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(45, 8, 45, 20),
        decoration: const BoxDecoration(color: AppTheme.primaryCream),
        child: SizedBox(
          height: 55,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: AppTheme.primaryGradient,
              borderRadius: BorderRadius.circular(20),
            ),
            child: ElevatedButton(
              onPressed: () {
                // TODO: Simpan transaksi
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'Checkout',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // =========================================================
  //                      ITEM CART ROW
  // =========================================================
  Widget _buildCartRow(cartItem, BuildContext context) {
    final cart = context.read<CartController>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cartItem.product.nama,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),

            Row(
              children: [
                _qtyButton("-", () => cart.removeFromCart(cartItem.product)),
                const SizedBox(width: 12),

                Text(
                  "${cartItem.qty}",
                  style: GoogleFonts.poppins(fontSize: 16),
                ),

                const SizedBox(width: 12),
                _qtyButton("+", () => cart.addToCart(cartItem.product)),
              ],
            ),
          ],
        ),

        Text(
          "Rp${(cartItem.product.hargaJual * cartItem.qty).toInt()}",
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _qtyButton(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 28,
        width: 28,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  // =========================================================
  //                   HITUNG KEMBALIAN
  // =========================================================
  void _hitungKembalian(double total) {
    final uang = double.tryParse(bayarC.text) ?? 0;
    setState(() {
      kembalian = uang - total;
    });
  }
}
