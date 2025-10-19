// lib/ui/pages/TambahToko.dart
import 'package:flutter/material.dart';
import '../../core/app_theme.dart';

class TambahToko extends StatelessWidget {
  const TambahToko({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 10),
          _TokoCard(
            namaToko: "Toko Cute",
            alamat: "Jln. Ahmad Yani nomor 13",
            kasir: "Aisyah",
            onEdit: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Edit Toko Cute')),
              );
            },
          ),
          _TokoCard(
            namaToko: "Toko Madura 1",
            alamat: "Jln. Jarwo nomor 5",
            kasir: "Chelsy",
            onEdit: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Edit Toko Madura 1')),
              );
            },
          ),
          _TokoCard(
            namaToko: "Toko Madura 2",
            alamat: "Jln. Ketintang nomor 17",
            kasir: "Alief",
            onEdit: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Edit Toko Madura 2')),
              );
            },
          ),
          const SizedBox(height: 30),

          // Tombol Tambah Toko
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Tambah Toko baru...')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryOrange,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                textStyle: t.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
                padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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

class _TokoCard extends StatelessWidget {
  final String namaToko;
  final String alamat;
  final String kasir;
  final VoidCallback? onEdit;

  const _TokoCard({
    required this.namaToko,
    required this.alamat,
    required this.kasir,
    this.onEdit,
  });

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
        boxShadow: const [
          BoxShadow(
            color: AppTheme.shadowLight,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Nama Toko:', style: t.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 2),
          Text(namaToko, style: t.bodyMedium?.copyWith(color: AppTheme.textSubtle)),
          const SizedBox(height: 8),
          Text('Alamat:', style: t.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 2),
          Text(alamat, style: t.bodyMedium?.copyWith(color: AppTheme.textSubtle)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nama Kasir:', style: t.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 2),
                  Text(kasir, style: t.bodyMedium?.copyWith(color: AppTheme.textSubtle)),
                ],
              ),
              ElevatedButton(
                onPressed: onEdit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryRed,
                  foregroundColor: Colors.white,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  textStyle: t.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                child: const Text('Edit'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
