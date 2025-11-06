// lib/ui/pages/tambahPenggunaPage.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../core/app_theme.dart';
import '../../data/models/toko.dart';
import '../../data/models/tambah_pengguna_request.dart';
import '../../data/services/tambah_pengguna_service.dart';
import '../../state/toko_controller.dart';

class TambahPenggunaPage extends StatelessWidget {
  const TambahPenggunaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TokoController.http()..load(), // pakai data dari backend
      child: const _TambahPenggunaView(),
    );
  }
}

class _TambahPenggunaView extends StatelessWidget {
  const _TambahPenggunaView();

  @override
  Widget build(BuildContext context) {
    final c = context.watch<TokoController>();

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
                          Icons.person_add_alt_1_rounded,
                          color: AppTheme.primaryCream,
                          size: 30,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Tambah Pengguna',
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
      body: c.loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: c.items.length,
        itemBuilder: (context, i) {
          final toko = c.items[i];
          return _PenggunaCard(
            key: ValueKey(toko.id ?? i),
            data: toko,
            onSave: (kasirBaru) async {
              // 🔹 Panggil service untuk menyimpan data ke backend
              final req = TambahPenggunaRequest(
                namaKasir: kasirBaru,
                namaToko: toko.namaToko ?? '',
                alamat: toko.alamat ?? '',
                nama: '',
                username: '',
                password: '',
                phone: '',
              );

              final success = await TambahPenggunaService().tambahPengguna(req);

              if (success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Kasir berhasil ditambahkan!')),
                );
                // Update list toko dengan nama kasir baru
                c.saveAt(i, toko.copyWith(namaKasir: kasirBaru));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Gagal menambahkan kasir')),
                );
              }
            },
          );
        },
      ),
    );
  }
}

class _PenggunaCard extends StatefulWidget {
  final Toko data;
  final ValueChanged<String> onSave;

  const _PenggunaCard({
    super.key,
    required this.data,
    required this.onSave,
  });

  @override
  State<_PenggunaCard> createState() => _PenggunaCardState();
}

class _PenggunaCardState extends State<_PenggunaCard> {
  late final TextEditingController _kasirC;
  bool _editing = true;

  @override
  void initState() {
    super.initState();
    _kasirC = TextEditingController(text: _normalizeKasir(widget.data.namaKasir));
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
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.primaryCream,
        border: Border.all(color: AppTheme.border, width: 1),
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(color: AppTheme.shadowLight, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Nama Toko:', style: t.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 2),
          Text(
            widget.data.namaToko?.isEmpty == true ? '—' : widget.data.namaToko!,
            style: t.bodyMedium?.copyWith(color: AppTheme.textSubtle),
          ),
          const SizedBox(height: 8),
          Text('Alamat:', style: t.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 2),
          Text(
            widget.data.alamat?.isEmpty == true ? '—' : widget.data.alamat!,
            style: t.bodyMedium?.copyWith(color: AppTheme.textSubtle),
          ),
          const SizedBox(height: 12),
          Text('Nama Kasir:', style: t.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 2),
          _editing
              ? TextField(
            controller: _kasirC,
            decoration: const InputDecoration(hintText: 'Masukkan nama kasir'),
          )
              : Text(
            _kasirC.text.trim().isEmpty ? '—' : _kasirC.text.trim(),
            style: t.bodyMedium?.copyWith(color: AppTheme.textSubtle),
          ),
          const SizedBox(height: 14),
          Align(
            alignment: Alignment.centerRight,
            child: OutlinedButton(
              onPressed: () {
                if (_editing) {
                  final val = _kasirC.text.trim();
                  widget.onSave(val.isEmpty ? '-' : val);
                }
                setState(() => _editing = !_editing);
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppTheme.primaryOrange, width: 1.5),
                foregroundColor: AppTheme.primaryOrange,
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              child: Text(
                _editing ? 'Simpan' : 'Edit',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: AppTheme.primaryOrange,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
