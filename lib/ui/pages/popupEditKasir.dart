import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/app_theme.dart';
import '../widgets/notif_popup.dart';



class PopupEditKasir extends StatefulWidget {
  final String? initialNama;
  final String? initialTelp;
  final String? initialPass;
  final void Function(String nama, String telp, String pass) onSave;

  const PopupEditKasir({
    super.key,
    required this.onSave,
    this.initialNama,
    this.initialTelp,
    this.initialPass,
  });

  @override
  State<PopupEditKasir> createState() => _PopupEditKasirState();
}

class _PopupEditKasirState extends State<PopupEditKasir> {
  late TextEditingController namaC;
  late TextEditingController telpC;
  late TextEditingController passC;

  @override
  void initState() {
    super.initState();
    namaC = TextEditingController(text: widget.initialNama ?? '');
    telpC = TextEditingController(text: widget.initialTelp ?? '');
    passC = TextEditingController(text: widget.initialPass ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 28),
        decoration: BoxDecoration(
          color: AppTheme.primaryCream,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// =======================
            ///  HEADER
            /// =======================
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: const BoxDecoration(
                      color: AppTheme.primaryRed,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 16,
                            offset: Offset(0, 4))
                      ],
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            Text(
              "Tambah Kasir",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppTheme.primaryOrange,
              ),
            ),

            const SizedBox(height: 24),

            /// =======================
            /// INPUT NAMA
            /// =======================
            _InputField(
              label: "Input nama kasir",
              hint: "Input nama kasir anda",
              icon: Icons.person_outline_rounded,
              controller: namaC,
            ),

            const SizedBox(height: 14),

            /// =======================
            /// INPUT TELEPON
            /// =======================
            _InputField(
              label: "Input Nomor Telepon",
              hint: "Input Nomor Kasir",
              icon: Icons.phone_in_talk_rounded,
              controller: telpC,
              keyboardType: TextInputType.phone,
            ),

            const SizedBox(height: 14),

            /// =======================
            /// INPUT PASSWORD
            /// =======================
            _InputField(
              label: "Input Password",
              hint: "Input Password anda",
              icon: Icons.lock_outline_rounded,
              controller: passC,
              obscure: true,
            ),

            const SizedBox(height: 26),

            /// =======================
            /// BUTTON SIMPAN
            /// =======================
            GestureDetector(
              onTap: () {
                widget.onSave(
                  namaC.text.trim(),
                  telpC.text.trim(),
                  passC.text.trim(),
                );
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (_) => NotifPopup.success(context, 'Kasir baru berhasil ditambahkan'),
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Center(
                  child: Text(
                    "Simpan",
                    style: GoogleFonts.poppins(
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
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

/// =================================================================
/// WIDGET CUSTOM INPUT FIELD SESUAI FIGMA
/// =================================================================

class _InputField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final TextEditingController controller;
  final bool obscure;
  final TextInputType? keyboardType;

  const _InputField({
    required this.label,
    required this.hint,
    required this.icon,
    required this.controller,
    this.obscure = false,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppTheme.balckicon,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.white, // hanya 1 layer putih
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Icon(icon, size: 20, color: AppTheme.textSubtle),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: controller,
                  obscureText: obscure,
                  keyboardType: keyboardType,
                  style: GoogleFonts.poppins(fontSize: 13),
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: GoogleFonts.poppins(
                      color: AppTheme.textSubtle,
                      fontSize: 13,
                    ),
                    border: InputBorder.none, // hilangkan border semua state
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    filled: false, // pastikan tidak ada fill warna
                    isCollapsed: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),

            ],
          ),
        ),
      ],
    );
  }
}

