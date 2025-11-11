import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SuccessPopup extends StatelessWidget {
  final String message; // Pesan dinamis
  final Duration duration; // Durasi tampil popup (opsional)
  final IconData icon; // Ikon bisa disesuaikan

  const SuccessPopup({
    super.key,
    required this.message,
    this.icon = Icons.check_circle_rounded,
    this.duration = const Duration(seconds: 2),
  });

  @override
  Widget build(BuildContext context) {
    // Jalankan animasi auto-close
    Future.delayed(duration, () {
      if (Navigator.of(context).canPop()) Navigator.pop(context);
    });

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 40),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF00C853), // hijau sukses
              ),
              padding: const EdgeInsets.all(5),
              child: Icon(icon, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
