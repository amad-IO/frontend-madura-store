
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import './popupEditKasir.dart';
import '../../core/app_theme.dart';
import '../../data/models/toko.dart';
import '../../state/toko_controller.dart';

class TambahPenggunaPage extends StatelessWidget {
  const TambahPenggunaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // Sementara pakai mock seperti TambahToko; nanti ganti ke sumber data asli (HTTP, dsb.)
      create: (_) => TokoController.mock()..load(),
      child: const _TambahPenggunaView(),
    );
  }
}

class _TambahPenggunaView extends StatelessWidget {
  const _TambahPenggunaView();

  @override
  Widget build(BuildContext context) {
    final c = context.watch<TokoController>();
    final t = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppTheme.primaryCream,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: ClipRRect(
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(50)),
            child: Container(
              decoration: const BoxDecoration(gradient: AppTheme.primaryGradient),
              child: SafeArea(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Back
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
                    // Title
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.person_add_alt_1_rounded,
                          color: AppTheme.primaryCream,
                          size: 30,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Tambah Pengguna',
                          textAlign: TextAlign.center,
                          // Menyamakan gaya dengan TambahToko
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

      body: c.loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: c.items.length,
        itemBuilder: (context, i) {
          final toko = c.items[i];
          return _PenggunaCard(
            key: ValueKey(toko.id ?? i),
            index: i,               // ➕ KIRIM i
            data: toko,
            onSave: (updatedToko) { // menerima full model
              c.saveAt(i, updatedToko);
            },
          );
        },
      ),
    );
  }
}

/// Card untuk mengisi/ubah nama kasir.
/// - Nama Toko & Alamat: hanya tampil (read-only)
/// - Nama Kasir: bisa diubah
class _PenggunaCard extends StatefulWidget {
  final int index;  // ➕ tambah ini
  final Toko data;
  final ValueChanged<Toko> onSave;  // juga akan diperbaiki


  const _PenggunaCard({
    super.key,
    required this.index,
    required this.data,
    required this.onSave,
  });

  @override
  State<_PenggunaCard> createState() => _PenggunaCardState();
}

class _PenggunaCardState extends State<_PenggunaCard> {
  late final TextEditingController _kasirC;
  bool _editing = false;

  @override
  void initState() {
    super.initState();
    _kasirC = TextEditingController(text: _normalizeKasir(widget.data.namaKasir));

    // Jika sudah ada nama kasir → default tidak editing
    if (_kasirC.text.trim().isNotEmpty && _kasirC.text.trim() != '-') {
      _editing = false;
    }
  }

  String _normalizeKasir(String? v) {
    final s = (v ?? '').trim();
    return s.isEmpty || s == '-' ? '' : s;
  }

  @override
  void dispose() {
    _kasirC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppTheme.primaryCream,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppTheme.border),
        boxShadow: const [
          BoxShadow(
            color: AppTheme.shadowLight,
            offset: Offset(0, 3),
            blurRadius: 6,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// =========================
          /// NAMA TOKO
          /// =========================
          Text('Nama toko :',
              style: t.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 3),
          Text(
            widget.data.namaToko?.isEmpty == true
                ? '—'
                : widget.data.namaToko!,
            style: t.bodyMedium?.copyWith(color: AppTheme.textSubtle),
          ),
          const SizedBox(height: 10),

          /// =========================
          /// ALAMAT
          /// =========================
          Text('Alamat :',
              style: t.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 3),
          Text(
            widget.data.alamat?.isEmpty == true
                ? '—'
                : widget.data.alamat!,
            style: t.bodyMedium?.copyWith(color: AppTheme.textSubtle),
          ),
          const SizedBox(height: 10),

          /// =========================
          /// ROW: Nama Kasir + Tombol Edit/Simpan
          /// =========================
          Text(
            'Nomor telepon :',
            style: t.titleSmall?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 3),
          Text(
            (widget.data.nomorTelp ?? '').isEmpty ? '—' : widget.data.nomorTelp!,
            style: t.bodyMedium?.copyWith(color: AppTheme.balckicon),
          ),
          const SizedBox(height: 10),

          Text(
            'Nama kasir :',
            style: t.titleSmall?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 3),
          Text(
            widget.data.namaKasir.isEmpty ? '—' : widget.data.namaKasir,
            style: t.bodyMedium?.copyWith(color: AppTheme.balckicon),
          ),
          const SizedBox(height: 20),

          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              onPressed: () async {
                final result = await showDialog(
                  context: context,
                  builder: (_) => PopupEditKasir(
                    initialNama: widget.data.namaKasir,
                    initialTelp: widget.data.nomorTelp,
                    initialPass: widget.data.password,
                    onSave: (nama, telp, pass) {
                      final updated = widget.data.copyWith(
                        namaKasir: nama,
                        nomorTelp: telp,
                        password: pass,
                      );
                      widget.onSave(updated);
                      setState(() {}); // refresh card
                    },
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryRed,
                foregroundColor: Colors.white,
                elevation: 3,
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              icon: const Icon(Icons.edit_note_rounded, size: 22, color: Colors.white),
              label: Text(
                'Edit',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

