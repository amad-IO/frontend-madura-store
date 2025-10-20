
import 'package:flutter/material.dart';
import '../../core/app_theme.dart';

/// Model sederhana untuk menampung data transaksi.
/// Nanti diganti dengan data dari backend.
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

class LaporanPenjualanPage extends StatelessWidget {
  const LaporanPenjualanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;

    // Contoh data; gantilah dengan fetch dari backend/API nanti.
    final reports = [
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

    return Scaffold(
      backgroundColor: AppTheme.primaryCream,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(180),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(50)),
          child: Container(
            decoration: const BoxDecoration(
              gradient: AppTheme.primaryGradient,
            ),
            child: SafeArea(
              child: Column(
                children: [
                  // Baris pertama: tombol back dan judul dipisahkan
                  SizedBox(
                    height: 60,
                    child: Stack(
                      children: [
                        // tombol back di kiri
                        Positioned(
                          left: 16,
                          top: 12,
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: AppTheme.primaryCream,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        // judul di tengah
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Text(
                              'Laporan Penjualan',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Baris kedua: kolom pencarian
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),  // beri sedikit margin bawah
                      width: MediaQuery.of(context).size.width * 0.6, // atur lebar sesuai kebutuhan (misal 60% dari lebar layar)
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 8),
                          const Icon(Icons.search, size: 18, color: AppTheme.textSubtle),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Cari...',
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: AppTheme.textSubtle),
                                border: InputBorder.none,
                              ),
                              onChanged: (value) {
                                // TODO: filter daftar laporan berdasarkan kata kunci
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
        itemCount: reports.length,
        itemBuilder: (context, index) {
          final report = reports[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Baris tanggal & total
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      report.date,
                      style: t.titleMedium?.copyWith(
                        color: AppTheme.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      report.total,
                      style: t.titleMedium?.copyWith(
                        color: AppTheme.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              // Kartu laporan
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
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
                    // Header kasir
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'KASIR',
                            style: t.bodyMedium?.copyWith(color: AppTheme.textSubtle),
                          ),
                          Text(
                            report.cashier,
                            style: t.bodyMedium?.copyWith(color: AppTheme.textSubtle),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 0),
                    // Daftar item penjualan
                    ...report.items.map((item) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                item.name,
                                style: t.bodyMedium?.copyWith(color: AppTheme.textPrimary),
                              ),
                            ),
                            Text(
                              item.qty,
                              style: t.bodySmall?.copyWith(color: AppTheme.textSubtle),
                            ),
                            const SizedBox(width: 16),
                            Text(
                              item.price,
                              style: t.bodySmall?.copyWith(color: AppTheme.textPrimary),
                            ),
                          ],
                        ),
                      );
                    }),
                    const Divider(height: 0),
                    // Total
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'TOTAL',
                            style: t.bodyMedium?.copyWith(
                              color: AppTheme.textPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            report.total,
                            style: t.bodyMedium?.copyWith(
                              color: AppTheme.textPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
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
      // Tombol Cetak (selaras dengan tema)
      floatingActionButton: SizedBox(
        width: 160,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryRed,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
          onPressed: () {
            // TODO: implementasi fungsi cetak / ekspor
          },
          child: const Text('Cetak'),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
