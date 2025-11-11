import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/app_theme.dart';
import '../../data/models/toko.dart';
import '../../state/toko_controller.dart';
import '../widgets/notif_popup.dart';
import './popupTambahToko.dart';


class TambahToko extends StatelessWidget {
  const TambahToko({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
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

    return Scaffold(
      backgroundColor: AppTheme.primaryCream,
      resizeToAvoidBottomInset: false, // ✅ biar tombol gak naik saat keyboard muncul

      // ✅ AppBar tetap seperti biasa
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

      // ✅ BODY (list toko)
      body: c.loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: c.items.length,
        itemBuilder: (context, i) {
          final toko = c.items[i];
          return _TokoCard(
            key: ValueKey(toko.id ?? i),
            index: i,
            data: toko,
            onSave: (updatedToko) {
              c.saveAt(i, updatedToko);
              showDialog(
                context: context,
                builder: (_) => NotifPopup.success(
                  context,
                  'Toko baru berhasil disimpan',
                ),
              );
            },
          );
        },
      ),

      // ✅ Tombol tetap di bawah layar (tidak ikut scroll / keyboard)
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(45, 8, 45, 20),
        decoration: const BoxDecoration(
          color: AppTheme.primaryCream,
        ),
        child: SizedBox(
          height: 55,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: AppTheme.primaryGradient,
              borderRadius: BorderRadius.circular(20),
            ),
            child: ElevatedButton(
              // 🔽 Bagian ini yang kamu ubah
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (_) => PopupTambahToko(
                    index: c.items.length,        // ← INI YANG WAJIB ADA
                    onSave: (tokoBaru) {
                      c.addItem(tokoBaru);        // tambah toko baru
                    },
                  ),
                );
              },
              // 🔼 sampai sini
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'Tambah Toko',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),

    );
  }
}

/// ===========================================================
/// CARD TOKO (Nama toko dan alamat saja)
/// ===========================================================
class _TokoCard extends StatefulWidget {
  final int index;
  final Toko data;
  final ValueChanged<Toko> onSave;

  const _TokoCard({
    super.key,
    required this.index,
    required this.data,
    required this.onSave,
  });

  @override
  State<_TokoCard> createState() => _TokoCardState();
}

class _TokoCardState extends State<_TokoCard> {
  late final TextEditingController _namaC;
  late final TextEditingController _alamatC;
  bool _editing = true;

  @override
  void initState() {
    super.initState();
    _namaC = TextEditingController(text: widget.data.namaToko);
    _alamatC = TextEditingController(text: widget.data.alamat);
    if (!widget.data.isEmpty) _editing = false;
  }

  @override
  void dispose() {
    _namaC.dispose();
    _alamatC.dispose();
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
          /// Nama toko
          Text('Nama toko :',
              style: t.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 3),
          _editing
              ? TextField(
            controller: _namaC,
            decoration: const InputDecoration(
              hintText: 'Masukkan nama toko',
              border: InputBorder.none,
              isDense: true,
            ),
          )
              : Text(
            _namaC.text.isEmpty ? '—' : _namaC.text,
            style: t.bodyMedium?.copyWith(color: AppTheme.textSubtle),
          ),
          const SizedBox(height: 10),

          /// Alamat
          Text('Alamat :',
              style: t.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 3),
          _editing
              ? TextField(
            controller: _alamatC,
            decoration: const InputDecoration(
              hintText: 'Masukkan alamat toko',
              border: InputBorder.none,
              isDense: true,
            ),
          )
              : Text(
            _alamatC.text.isEmpty ? '—' : _alamatC.text,
            style: t.bodyMedium?.copyWith(color: AppTheme.textSubtle),
          ),
          const SizedBox(height: 10),

          /// Nomor Telepon dan Kasir (statis '-')
          Text(
            'Nomor telepon :',
            style: t.titleSmall?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 3),
          Text('—', style: t.bodyMedium?.copyWith(color: AppTheme.balckicon)),
          const SizedBox(height: 10),
          Text(
            'Nama kasir :',
            style: t.titleSmall?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 3),
          Text('—', style: t.bodyMedium?.copyWith(color: AppTheme.balckicon)),
          const SizedBox(height: 16),

          /// Tombol Simpan/Edit
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // ==========================
              // 🗑 DELETE BUTTON
              // ==========================
              ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      backgroundColor: AppTheme.primaryCream,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      title: Text(
                        "Hapus Toko?",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          color: AppTheme.primaryRed,
                        ),
                      ),
                      content: Text(
                        "Apakah Anda yakin ingin menghapus toko ini?",
                        style: GoogleFonts.poppins(fontSize: 14),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("Batal"),
                        ),
                        TextButton(
                          onPressed: () async {
                            Navigator.pop(context); // tutup dialog

                            final c = Provider.of<TokoController>(context, listen: false);
                            await c.deleteAt(widget.index);

                            showDialog(
                              context: context,
                              builder: (_) => NotifPopup.success(
                                context,
                                "Toko berhasil dihapus",
                              ),
                            );
                          },
                          child: Text(
                            "Hapus",
                            style: TextStyle(color: AppTheme.primaryRed),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryRed,
                  foregroundColor: Colors.white,
                  elevation: 3,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                icon: const Icon(Icons.delete, size: 18, color: Colors.white),
                label: Text(
                  "Hapus",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),

              const SizedBox(width: 10),

              // ==========================
              // ✏ EDIT BUTTON
              // ==========================
              ElevatedButton.icon(
                onPressed: () async {
                  await showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (_) => PopupTambahToko(
                      index: widget.index,
                      initialNama: widget.data.namaToko,
                      initialAlamat: widget.data.alamat,
                      onSave: (updatedToko) {
                        final updated = widget.data.copyWith(
                          namaToko: updatedToko.namaToko,
                          alamat: updatedToko.alamat,
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
                icon: const Icon(Icons.edit_note_rounded, size: 18, color: Colors.white),
                label: Text(
                  'Edit',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
