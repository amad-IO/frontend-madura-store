import 'package:flutter/material.dart';
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
      appBar: AppBar(
        title: const Text('Tambah Toko'),
        backgroundColor: AppTheme.primaryRed,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 2,
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
          SizedBox(
            height: 55,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => c.addEmpty(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryOrange,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                textStyle: t.titleLarge?.copyWith(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              child: const Text('Tambah Toko'),
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
        color: Colors.white,
        border: Border.all(color: AppTheme.border, width: 1),
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [BoxShadow(color: AppTheme.shadowLight, blurRadius: 6, offset: Offset(0, 3))],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          IconButton(
            tooltip: 'Hapus',
            onPressed: widget.onDelete,
            icon: const Icon(Icons.delete_outline, color: Colors.red),
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
        Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nama Kasir:',
                  style: t.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '-', // selalu tampil "-" (tidak bisa diubah)
                        style: t.bodyMedium?.copyWith(color: AppTheme.textSubtle),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {
              if (_editing) {
                widget.onSave(widget.data.copyWith(namaToko: _n.text, alamat: _a.text, namaKasir: "-"));
              }
              setState(() => _editing = !_editing);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _editing ? AppTheme.primaryOrange : AppTheme.primaryRed,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(_editing ? 'Simpan' : 'Edit'),
          ),
        ]),
      ]),
    );
  }
}
