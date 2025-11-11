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

class PopupEditProduk extends StatefulWidget {
  final Product? product; // null = tambah baru
  const PopupEditProduk({super.key, this.product});

  @override
  State<PopupEditProduk> createState() => _PopupEditProdukState();
}

class _PopupEditProdukState extends State<PopupEditProduk> {
  late TextEditingController namaC;
  late TextEditingController hargaC;
  late TextEditingController stokC;
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();


  @override
  void initState() {
    super.initState();
    namaC = TextEditingController(text: widget.product?.name ?? '');
    hargaC = TextEditingController(text: widget.product?.price.toString() ?? '');
    stokC = TextEditingController(text: widget.product?.stock.toString() ?? '');
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
        preferredSize: const Size.fromHeight(180),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(50)),
          child: Container(
            decoration: const BoxDecoration(gradient: AppTheme.primaryGradient),
            child: SafeArea(
              child: Stack(
                children: [
                  Positioned(
                    left: 16,
                    top: 16,
                    child: CircleAvatar(
                      backgroundColor: AppTheme.primaryCream,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new_rounded,
                            color: AppTheme.primaryRed),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      isEdit ? 'Edit' : 'Tambah',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
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
            // Area upload foto
            GestureDetector(
              onTap: () async {
                final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
                if (pickedFile != null) {
                  setState(() {
                    _imageFile = File(pickedFile.path);
                  });
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
                  child: _imageFile == null
                      ? const Center(
                    child: Icon(Icons.folder_copy_rounded,
                        size: 50, color: AppTheme.primaryRed),
                  )
                      : ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.file(
                      _imageFile!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),

            _InputField(
              label: 'Input Nama Produk',
              hint: 'Input nama produk anda',
              icon: Icons.person_outline_rounded,
              controller: namaC,
            ),
            const SizedBox(height: 16),
            _InputField(
              label: 'Input Harga',
              hint: 'Input harga produk',
              icon: Icons.call_outlined,
              controller: hargaC,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            _InputField(
              label: 'Input Jumlah Stok',
              hint: 'Input jumlah stok anda',
              icon: Icons.lock_outline_rounded,
              controller: stokC,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 40),

            // Tombol Save
            Center(
              child: InkWell(
                onTap: () {
                  final nama = namaC.text.trim();
                  final harga = int.tryParse(hargaC.text.trim()) ?? 0;
                  final stok = int.tryParse(stokC.text.trim()) ?? 0;
                  if (nama.isEmpty) return;

                  final ctrl = context.read<ProductController>();

                  if (isEdit) {
                    // ✅ update produk lama
                    ctrl.update(widget.product!.copyWith(
                      name: nama,
                      price: harga,
                      stock: stok,
                      imageUrl: _imageFile?.path ?? widget.product!.imageUrl,
                    ));
                  } else {
                    // ✅ tambah produk baru
                    final newId = 'p${DateTime.now().millisecondsSinceEpoch}';
                    ctrl.add(Product(
                      id: newId,
                      name: nama,
                      price: harga,
                      stock: stok,
                      rating: 0,
                      imageUrl: _imageFile?.path ?? '',
                      category: '',
                    ));
                  }

                  // ✅ Tutup halaman popup
                  Navigator.pop(context);

                  // ✅ Tampilkan notifikasi sukses
                  Future.delayed(const Duration(milliseconds: 300), () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) => NotifPopup.success(
                        context,
                        isEdit
                            ? 'Produk berhasil diperbarui'
                            : 'Produk berhasil ditambahkan',
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
            )
          ],
        ),
      ),
    );
  }
}

// Widget untuk input form
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
    final t = Theme.of(context).textTheme;
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
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: t.bodyMedium?.copyWith(color: AppTheme.textSubtle),
              prefixIcon: Icon(icon, color: AppTheme.textSubtle),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
      ],
    );
  }
}
