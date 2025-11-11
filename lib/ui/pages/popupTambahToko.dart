import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../core/app_theme.dart';
import '../../data/models/toko.dart';
import '../../state/toko_controller.dart';
import '../widgets/notif_popup.dart';

class PopupTambahToko extends StatefulWidget {
  final int index;
  final void Function(Toko tokoBaru) onSave;
  final String? initialNama;
  final String? initialAlamat;

  const PopupTambahToko({
    super.key,
    required this.index,
    required this.onSave,
    this.initialNama,
    this.initialAlamat,
  });

  @override
  State<PopupTambahToko> createState() => _PopupTambahTokoState();
}

class _PopupTambahTokoState extends State<PopupTambahToko> {
  late final TextEditingController namaC;
  late final TextEditingController alamatC;

  @override
  void initState() {
    super.initState();
    namaC = TextEditingController(text: widget.initialNama ?? '');
    alamatC = TextEditingController(text: widget.initialAlamat ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 28),
        decoration: BoxDecoration(
          color: AppTheme.primaryCream,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(context),
            const SizedBox(height: 8),

            Text(
              "Tambah Toko",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppTheme.primaryOrange,
              ),
            ),

            const SizedBox(height: 24),

            _InputField(
              label: "Nama Toko",
              hint: "Input nama toko anda",
              icon: Icons.store_mall_directory_outlined,
              controller: namaC,
            ),

            const SizedBox(height: 14),

            _InputField(
              label: "Alamat",
              hint: "Input alamat toko",
              icon: Icons.location_on_outlined,
              controller: alamatC,
            ),

            const SizedBox(height: 26),

            _buildSaveButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
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
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final toko = Toko(
          namaToko: namaC.text.trim(),
          alamat: alamatC.text.trim(),
          namaKasir: '-',
        );

        widget.onSave(toko);
        Navigator.pop(context);

        showDialog(
          context: context,
          builder: (_) =>
              NotifPopup.success(context, 'Toko baru berhasil ditambahkan'),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          gradient: AppTheme.primaryGradient,
          borderRadius: BorderRadius.circular(18),
        ),
        alignment: Alignment.center,
        child: Text(
          "Simpan",
          style: GoogleFonts.poppins(
            fontSize: 17,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

/// ===============================================================
///                    WIDGET INPUT FIELD
/// ===============================================================

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
            color: AppTheme.primaryWhite, // ✅ Container putih
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Icon(icon, size: 20, color: AppTheme.primaryRed),
              const SizedBox(width: 8),

              Expanded(
                child: TextField(
                  controller: controller,
                  obscureText: obscure,
                  keyboardType: keyboardType,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: AppTheme.balckicon, // warna teks
                  ),

                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppTheme.primaryWhite,
                    // ✅ sama putihnya
                    hintText: hint,
                    hintStyle: GoogleFonts.poppins(
                      color: AppTheme.textSubtle,
                      fontSize: 13,
                    ),

                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,

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
