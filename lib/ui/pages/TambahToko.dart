import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/app_theme.dart';
import '../../data/models/toko.dart';
import '../../state/toko_controller.dart';

class TambahToko extends StatelessWidget {
  const TambahToko({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // sementara pakai mock; nanti ganti ke TokoController.http()
      create: (_) => TokoController.mock()..load(),
      child: const _TambahTokoView(),
    );
  }
}

class _TambahTokoView extends StatelessWidget {
  const _TambahTokoView();

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
              decoration: const BoxDecoration(
                gradient: AppTheme.primaryGradient,
              ),
              child: SafeArea(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Tombol back di kiri atas
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

                    // Isi di tengah (ikon + teks)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.store_mall_directory_outlined,
                          color: AppTheme.primaryCream,
                          size: 30,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Tambah Toko',
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
          : ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 10),
          ...c.items.asMap().entries.map((entry) {
            final i = entry.key;
            final e = entry.value;
            return _TokoCard(
              key: ValueKey(e.id ?? i),
              data: e,
              onSave: (val) => c.saveAt(i, val),
              onDelete: () => c.deleteAt(i), // <--- ini kuncinya
            );
          }),

          const SizedBox(height: 30),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 320), // batas lebar maksimum
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: AppTheme.primaryGradient,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: ElevatedButton(
                    onPressed: () => c.addEmpty(),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.transparent, // biar gradient terlihat
                      shadowColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      'Tambah Toko',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        height: 1.2,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _TokoCard extends StatefulWidget {
  final Toko data;
  final ValueChanged<Toko> onSave;
  final VoidCallback onDelete;

  const _TokoCard({
    super.key,
    required this.data,
    required this.onSave,
    required this.onDelete,     // <-- WAJIB
  });

  @override
  State<_TokoCard> createState() => _TokoCardState();
}

class _TokoCardState extends State<_TokoCard> {
  late final TextEditingController _n;
  late final TextEditingController _a;
  //late final TextEditingController _k; //untuk kasir
  bool _editing = true;

  @override
  void initState() {
    super.initState();
    _n = TextEditingController(text: widget.data.namaToko);
    _a = TextEditingController(text: widget.data.alamat);
    //_k = TextEditingController(text: widget.data.namaKasir); //punya kasir supaya ga tampil di add toko
    if (!widget.data.isEmpty) _editing = false;
  }

  @override
  void dispose() {
    _n.dispose(); _a.dispose(); // _k.dispose(); //kasir
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
        boxShadow: const [BoxShadow(color: AppTheme.shadowLight, blurRadius: 6, offset: Offset(0, 3))],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          IconButton(
            tooltip: 'Hapus',
            onPressed: widget.onDelete,
            icon: const Icon(Icons.delete_outline, color: AppTheme.textPrimary),
          ),
        ]),
        Text('Nama Toko:', style: t.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 2),
        _editing ? TextField(controller: _n, decoration: const InputDecoration(hintText: 'Masukkan nama toko'))
            : Text(_n.text.isEmpty ? '—' : _n.text, style: t.bodyMedium?.copyWith(color: AppTheme.textSubtle)),
        const SizedBox(height: 8),
        Text('Alamat:', style: t.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 2),
        _editing ? TextField(controller: _a, decoration: const InputDecoration(hintText: 'Masukkan alamat'))
            : Text(_a.text.isEmpty ? '—' : _a.text, style: t.bodyMedium?.copyWith(color: AppTheme.textSubtle)),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Kiri: "Nama Kasir: -"
            Expanded(
              child: Row(
                children: [
                  Text(
                    'Nama Kasir:',
                    style: t.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '-', // nilai kasir (fix: selalu '-' sesuai requirement)
                    style: t.bodyMedium?.copyWith(color: AppTheme.textSubtle),
                  ),
                ],
              ),
            ),

            // Kanan: tombol Simpan/Edit (outlined transparan)
            OutlinedButton(
              onPressed: () {
                if (_editing) {
                  widget.onSave(
                    widget.data.copyWith(
                      namaToko: _n.text,
                      alamat: _a.text,
                      namaKasir: "-",
                    ),
                  );
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
          ],
        ),
      ]),
    );
  }
}
