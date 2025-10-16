import '../../core/app_routes.dart';
import '../../core/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

Future<void> handleLogout(BuildContext context) async {
  final t = Theme.of(context).textTheme;

  final bool? ok = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (ctx) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Konfirmasi',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w700),
        ),
        content: Text(
          'Yakin mau logout?',
          style: GoogleFonts.poppins(),
        ),
        actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryRed,
              foregroundColor: AppTheme.primaryWhite,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Ya, logout'),
          ),
        ],
      );
    },
  );

  if (ok == true) {
    // TODO: bersihkan sesi / token di sini
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.login,
          (route) => false,
    );
  }
}
