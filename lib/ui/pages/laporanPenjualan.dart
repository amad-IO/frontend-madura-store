import 'package:flutter/material.dart';
import '../../core/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/app_routes.dart';


final r = BorderRadius.circular(30);
/// ====== MODEL SEDERHANA (dummy) ======
/// TODO: ganti dengan model dari backend/API nanti.
class SalesItem {
  final String name;
  final String qty;
  final String price;
  SalesItem(this.name, this.qty, this.price);
}

class SalesReport {
  final String date;
  final String cashier;
  final List<SalesItem> items;
  final String total;
  SalesReport({
    required this.date,
    required this.cashier,
    required this.items,
    required this.total,
  });
}

class LaporanPenjualanPage extends StatefulWidget {
  const LaporanPenjualanPage({super.key});

  @override
  State<LaporanPenjualanPage> createState() => _LaporanPenjualanPageState();
}

class _LaporanPenjualanPageState extends State<LaporanPenjualanPage> {
  // ====== DATA DUMMY ======
  // TODO: fetch dari backend & simpan ke _reports
  final List<SalesReport> _reports = [
    SalesReport(
      date: 'Senin, 14 Januari 2029',
      cashier: 'Pak Dudung',
      items: [
        SalesItem('Kopi Golda', '2 Botol', 'Rp6.000'),
        SalesItem('Rokok Gudang Garam', '2 Bungkus', 'Rp54.000'),
      ],
      total: 'Rp60.000',
    ),
    SalesReport(
      date: 'Senin, 11 Januari 2029',
      cashier: 'Pak Dudung',
      items: [
        SalesItem('Air Mineral', '2 Botol', 'Rp6.000'),
        SalesItem('Teh Pucuk', '10 Botol', 'Rp40.000'),
      ],
      total: 'Rp46.000',
    ),
  ];

  List<SalesReport> _filtered = [];
  final _search = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filtered = List.from(_reports);
  }

  void _filter(String q) {
    final k = q.toLowerCase();
    setState(() {
      _filtered = _reports.where((r) {
        final byDate = r.date.toLowerCase().contains(k);
        final byCashier = r.cashier.toLowerCase().contains(k);
        final byItem = r.items.any((i) => i.name.toLowerCase().contains(k));
        return byDate || byCashier || byItem;
      }).toList();
    });
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppTheme.primaryCream,

      // ====== APP BAR (header gradient + search kecil di bawah) ======
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(180),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(50)),
          child: Container(
            decoration: const BoxDecoration(gradient: AppTheme.primaryGradient),
            child: SafeArea(
              child: Column(
                children: [
                  // Back + Judul
                  SizedBox(
                    height: 80, // sedikit lebih tinggi supaya judul muat di bawah back
                    child: Stack(
                      children: [
                        // 🔹 Tombol Back (pojok kiri atas)
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

                        // 🔹 Judul (tengah bawah)
                        Align(
                          alignment: Alignment.bottomCenter,
                            child: Text(
                              'Laporan Penjualan',
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

                  const Spacer(),
                  // ====== SEARCH KECIL DI TENGAH BAWAH ======
              Align(
                alignment: Alignment.bottomCenter,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 200),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryCream,   // warna pindah ke Container
                      boxShadow: const [
                        BoxShadow(color: AppTheme.shadowLight, blurRadius: 12, offset: Offset(0, 4)),
                      ],
                      borderRadius: r,
                    ),
                    clipBehavior: Clip.antiAlias,     // penting: child ikut melengkung
                    child: TextField(
                      controller: _search,
                      onChanged: _filter,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: 'Cari',
                        hintStyle: t.bodySmall?.copyWith(color: AppTheme.textSubtle, fontSize: 16),
                        prefixIcon: const Icon(Icons.search, size: 20, color: AppTheme.textSubtle),
                        contentPadding: const EdgeInsets.symmetric(vertical: 10),
                        // samakan semua state border → bulat sejak awal
                        border: OutlineInputBorder(borderRadius: r, borderSide: BorderSide.none),
                        enabledBorder: OutlineInputBorder(borderRadius: r, borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: r,
                          borderSide: const BorderSide(color: AppTheme.primaryRed, width: 1),
                        ),
                        filled: false, // biar bentuk & warna dari Container (yang sudah di-clip)
                      ),
                    ),
                  ),
                ),
              ),
                ],
              ),
            ),
          ),
        ),
      ),

      // ====== BODY: list laporan ======
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
        itemCount: _filtered.length,
        itemBuilder: (context, index) {
          final r = _filtered[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tanggal + Total
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      r.date,
                      style: t.titleMedium?.copyWith(
                        color: AppTheme.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      r.total,
                      style: t.titleMedium?.copyWith(
                        color: AppTheme.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              // Kartu detail
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: AppTheme.primaryCream,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      color: AppTheme.shadowLight,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // header kasir
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('KASIR',
                              style: t.bodyMedium?.copyWith(
                                  color: AppTheme.textSubtle)),
                          Text(r.cashier,
                              style: t.bodyMedium?.copyWith(
                                  color: AppTheme.textSubtle)),
                        ],
                      ),
                    ),
                    const Divider(height: 0),
                    // items
                    ...r.items.map((it) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              it.name,
                              style: t.bodyMedium?.copyWith(
                                  color: AppTheme.textPrimary),
                            ),
                          ),
                          Text(it.qty,
                              style: t.bodySmall?.copyWith(
                                  color: AppTheme.textSubtle)),
                          const SizedBox(width: 16),
                          Text(it.price,
                              style: t.bodySmall?.copyWith(
                                  color: AppTheme.textPrimary)),
                        ],
                      ),
                    )),
                    const Divider(height: 0),
                    // total
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('TOTAL',
                              style: t.bodyMedium?.copyWith(
                                color: AppTheme.textPrimary,
                                fontWeight: FontWeight.w700,
                              )),
                          Text(r.total,
                              style: t.bodyMedium?.copyWith(
                                color: AppTheme.textPrimary,
                                fontWeight: FontWeight.w700,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),

      // Tombol Cetak (placeholder)
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: 180,
        height: 50,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: AppTheme.primaryGradient, // ⬅️ pakai gradient dari AppTheme
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: AppTheme.shadowLight,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: () {
              // TODO: export/print laporan
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent, // ⬅️ transparan agar gradient terlihat
              shadowColor: Colors.transparent,      // ⬅️ hilangkan shadow bawaan
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: const Text(
              'Cetak',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
