import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/app_theme.dart';
import '../../data/models/product.dart';
import '../../state/product_controller.dart';
import 'package:provider/provider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../widgets/notif_popup.dart';

class TambahEditProduk extends StatefulWidget {
  final Product? product; // null = tambah baru
  const TambahEditProduk({super.key, this.product});

  @override
  State<TambahEditProduk> createState() => _TambahEditProdukState();
}

class _TambahEditProdukState extends State<TambahEditProduk> {
  late TextEditingController namaC;
  late TextEditingController hargaC;
  late TextEditingController stokC;
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    namaC = TextEditingController(text: widget.product?.nama ?? '');
    hargaC = TextEditingController(
      text: widget.product != null
          ? widget.product!.hargaJual.toInt().toString()
          : '',
    );
    stokC = TextEditingController(text: widget.product?.stok.toString() ?? '');
  }

  @override
  void dispose() {
    namaC.dispose();
    hargaC.dispose();
    stokC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.product != null;

    return Scaffold(
      backgroundColor: AppTheme.primaryCream,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(50),
          ),
          child: Container(
            decoration: const BoxDecoration(gradient: AppTheme.primaryGradient),
            child: SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    height: 80,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 8,
                          top: 8,
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: AppTheme.primaryCream,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            isEdit ? 'Edit Produk' : 'Tambah Produk',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              color: AppTheme.primaryCream,
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // UPLOAD FOTO
            GestureDetector(
              onTap: () async {
                final pickedFile = await _picker.pickImage(
                  source: ImageSource.gallery,
                );
                if (pickedFile != null) {
                  setState(() => _imageFile = File(pickedFile.path));
                }
              },
              child: DottedBorder(
                color: AppTheme.primaryRed,
                strokeWidth: 2,
                dashPattern: const [6, 4],
                borderType: BorderType.RRect,
                radius: const Radius.circular(24),
                child: Container(
                  width: double.infinity,
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: AppTheme.primaryCream,
                  ),
                  child: _imageFile != null
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.file(_imageFile!, fit: BoxFit.cover),
                  )
                      : widget.product?.imageName != null &&
                      widget.product!.imageName!.isNotEmpty
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.network(
                      "http://localhost:8080/api/produk/gambar/${widget.product!.imageName}",
                      fit: BoxFit.cover,
                    ),
                  )
                      : const Center(
                    child: Icon(
                      Icons.add_photo_alternate_rounded,
                      size: 50,
                      color: AppTheme.primaryRed,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 35),

            // BUTTON DELETE JIKA EDIT
            if (isEdit)
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        backgroundColor: AppTheme.primaryCream,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        title: Text(
                          "Hapus Produk?",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            color: AppTheme.primaryRed,
                          ),
                        ),
                        content: Text(
                          "Apakah yakin ingin menghapus produk ini?",
                          style: GoogleFonts.poppins(fontSize: 14),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx, false),
                            child: const Text("Batal"),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(ctx, true),
                            child: const Text(
                              "Hapus",
                              style: TextStyle(color: AppTheme.primaryRed),
                            ),
                          ),
                        ],
                      ),
                    );

                    if (confirm == true) {
                      final ctrl = context.read<ProductController>();
                      final ok = await ctrl.delete(widget.product!.id);

                      if (ok) {
                        Navigator.pop(context);

                        Future.delayed(const Duration(milliseconds: 300), () {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) => NotifPopup.success(
                              context,
                              "Produk berhasil dihapus",
                            ),
                          );
                        });
                      }
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    child: const Icon(
                      Icons.delete_outline_rounded,
                      color: AppTheme.primaryOrange,
                      size: 30,
                    ),
                  ),
                ),
              ),

            const SizedBox(height: 10),

            // FORM
            _InputField(
              label: 'Input Nama Produk',
              hint: 'Input nama produk anda',
              icon: Icons.fastfood_rounded,
              controller: namaC,
            ),
            const SizedBox(height: 16),
            _InputField(
              label: 'Input Harga',
              hint: 'Input harga produk',
              icon: Icons.attach_money_rounded,
              controller: hargaC,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            _InputField(
              label: 'Input Jumlah Stok',
              hint: 'Input jumlah stok anda',
              icon: Icons.inventory_2_rounded,
              controller: stokC,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 40),

            // ===============================
            // TOMBOL SAVE (SUDAH DIBENERKAN)
            // ===============================
            Center(
              child: InkWell(
                onTap: () async {
                  final nama = namaC.text.trim();
                  final hargaStr = hargaC.text.trim();
                  final stokStr = stokC.text.trim();

                  if (nama.isEmpty || hargaStr.isEmpty || stokStr.isEmpty) {
                    print("❌ Semua field wajib diisi!");
                    return;
                  }

                  final harga = int.tryParse(hargaStr);
                  final stok = int.tryParse(stokStr);

                  if (harga == null || stok == null) {
                    print("❌ Harga & stok harus berupa angka!");
                    return;
                  }

                  final ctrl = context.read<ProductController>();
                  bool success = false;

                  if (isEdit) {
                    final updated = Product(
                      id: widget.product!.id,
                      nama: nama,
                      hargaJual: harga.toDouble(),
                      stok: stok,
                      satuan: widget.product!.satuan,
                      imageName: widget.product!.imageName,
                    );

                    success = await ctrl.update(updated, imageFile: _imageFile);
                  } else {
                    if (_imageFile == null) {
                      print("❌ Gambar wajib diisi untuk tambah produk!");
                      return;
                    }

                    final baru = Product(
                      id: 0,
                      nama: nama,
                      hargaJual: harga.toDouble(),
                      stok: stok,
                      satuan: "pcs",
                      imageName: "",
                    );

                    success = await ctrl.add(baru, _imageFile!);
                  }

                  if (!success) {
                    print("❌ Gagal menyimpan produk");
                    return;
                  }

                  Navigator.pop(context);

                  Future.delayed(const Duration(milliseconds: 300), () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) => NotifPopup.success(
                        context,
                        isEdit
                            ? "Produk berhasil diperbarui"
                            : "Produk berhasil ditambahkan",
                      ),
                    );
                  });
                },
                borderRadius: BorderRadius.circular(15),
                child: Ink(
                  width: 230,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    gradient: AppTheme.primaryGradient,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      'Save',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
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

class _InputField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final TextEditingController controller;
  final TextInputType? keyboardType;

  const _InputField({
    required this.label,
    required this.hint,
    required this.icon,
    required this.controller,
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
            color: const Color(0xFF525252),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: SizedBox(
              height: 42,
              child: TextField(
                controller: controller,
                keyboardType: keyboardType,
                style: GoogleFonts.poppins(fontSize: 18),
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: GoogleFonts.poppins(
                    color: AppTheme.textSubtle,
                    fontSize: 15,
                  ),
                  prefixIcon: Icon(
                    icon,
                    color: AppTheme.primaryOrange,
                    size: 25,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
