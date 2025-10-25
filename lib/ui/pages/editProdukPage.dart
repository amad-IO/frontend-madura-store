// lib/ui/pages/editProdukPage.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/app_theme.dart';
import '../../state/product_controller.dart';
import '../../data/models/product.dart';

class EditProdukPage extends StatefulWidget {
  const EditProdukPage({super.key});

  @override
  State<EditProdukPage> createState() => _EditProdukPageState();
}

class _EditProdukPageState extends State<EditProdukPage> {
  final TextEditingController _searchC = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProductController>(
      // Provider dibuat DI SINI, jadi jangan pakai context.read di luar/ sebelum build.
      create: (_) => ProductController(),
      child: Scaffold(
        backgroundColor: AppTheme.primaryCream,
        body: SafeArea(
          child: Column(
            children: [
              // ===== HEADER GRADIENT + SEARCH =====
              _HeaderArea(
                title: 'Produk',
                searchController: _searchC,
                onBack: () => Navigator.pop(context),
                onChanged: (q) => setState(() => _query = q.trim().toLowerCase()),
              ),

              // ===== TABEL LIST =====
              Expanded(
                child: Consumer<ProductController>(
                  builder: (context, ctrl, _) {
                    final all = ctrl.items;
                    final items = _query.isEmpty
                        ? all
                        : all.where((p) {
                      final nama = p.name.toLowerCase();
                      final kategori = (p.category ?? '').toLowerCase();
                      return nama.contains(_query) || kategori.contains(_query);
                    }).toList();

                    if (items.isEmpty) {
                      return _EmptyState(onRefresh: () {});
                    }

                    return Column(
                      children: [
                        const _TableHeaderStrip(),
                        Expanded(
                          child: ListView.separated(
                            padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
                            itemCount: items.length,
                            separatorBuilder: (_, __) => const Divider(
                              color: AppTheme.border,
                              thickness: 1,
                              height: 16,
                            ),
                            itemBuilder: (_, i) {
                              final p = items[i];
                              return _ProductRow(
                                product: p,
                                onEdit: () => _openFormProduk(context, product: p),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              // ===== TOMBOL TAMBAH =====
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                child: _PrimaryGradientButton(
                  label: 'Tambah barang',
                  onTap: () => _openFormProduk(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Form tambah/edit produk (bottom sheet)
  void _openFormProduk(BuildContext context, {Product? product}) {
    final isEdit = product != null;

    final nameC  = TextEditingController(text: product?.name ?? '');
    final priceC = TextEditingController(text: product?.price.toString() ?? '');
    final stockC = TextEditingController(text: product?.stock.toString() ?? '');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.primaryWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        final t = Theme.of(ctx).textTheme;
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 44,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppTheme.border,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(isEdit ? 'Edit Produk' : 'Tambah Produk', style: t.titleLarge),
              const SizedBox(height: 12),

              TextField(
                controller: nameC,
                decoration: const InputDecoration(
                  labelText: 'Nama produk',
                  hintText: 'Masukkan nama produk',
                ),
              ),
              const SizedBox(height: 12),

              TextField(
                controller: priceC,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Harga',
                  hintText: 'cth: 3000',
                ),
              ),
              const SizedBox(height: 12),

              TextField(
                controller: stockC,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Stok',
                  hintText: 'cth: 20',
                ),
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text('Batal'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        final nama  = nameC.text.trim();
                        final harga = int.tryParse(priceC.text.trim()) ?? 0;
                        final stok  = int.tryParse(stockC.text.trim()) ?? 0;
                        if (nama.isEmpty) return;

                        final ctrl = context.read<ProductController>();

                        if (isEdit) {
                          ctrl.update(Product(
                            id: product!.id,
                            name: nama,
                            price: harga,
                            stock: stok,
                            rating: product.rating,
                            imageUrl: product.imageUrl,
                            category: product.category,
                          ));
                        } else {
                          final newId = 'p${DateTime.now().millisecondsSinceEpoch}';
                          ctrl.add(Product(
                            id: newId,
                            name: nama,
                            price: harga,
                            stock: stok,
                            rating: 0,
                            imageUrl: '',
                            category: '',
                          ));
                        }

                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              isEdit ? 'Produk diperbarui' : 'Produk ditambahkan',
                              style: t.bodyMedium?.copyWith(color: AppTheme.primaryWhite),
                            ),
                          ),
                        );
                      },
                      child: Text(isEdit ? 'Simpan' : 'Tambah'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    ).whenComplete(() {
      nameC.dispose();
      priceC.dispose();
      stockC.dispose();
    });
  }
}

/// Header gradient seperti desain: ada tombol back, judul, dan search box.
class _HeaderArea extends StatelessWidget {
  final String title;
  final TextEditingController searchController;
  final VoidCallback onBack;
  final ValueChanged<String>? onChanged;

  const _HeaderArea({
    required this.title,
    required this.searchController,
    required this.onBack,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final topPad = MediaQuery.of(context).padding.top;

    return Container(
      padding: EdgeInsets.only(top: topPad + 16, left: 16, right: 16, bottom: 16),
      decoration: const BoxDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          // Row back + title center
          Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: onBack,
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  color: AppTheme.primaryWhite,
                ),
              ),
              Text(
                title,
                style: t.headlineSmall?.copyWith(
                  color: AppTheme.primaryWhite,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Search box
          TextField(
            controller: searchController,
            onChanged: onChanged,
            decoration: const InputDecoration(
              hintText: 'Cari',
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ],
      ),
    );
  }
}

/// Strip header tabel: Produk | Harga | Stok dengan bayangan halus di bawahnya.
class _TableHeaderStrip extends StatelessWidget {
  const _TableHeaderStrip();

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: const BoxDecoration(
        color: AppTheme.primaryCream,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowLight,
            blurRadius: 32.4,
            offset: Offset(0, 4),
            spreadRadius: 3,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Text(
              'Produk',
              style: t.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              'Harga',
              style: t.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Stok',
              textAlign: TextAlign.right,
              style: t.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(width: 44), // ruang untuk tombol Edit
        ],
      ),
    );
  }
}

/// Baris produk sesuai desain, dengan tombol "Edit" merah di kanan.
class _ProductRow extends StatelessWidget {
  final Product product;
  final VoidCallback onEdit;

  const _ProductRow({
    required this.product,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 6,
          child: Text(
            product.name,
            style: t.bodyMedium?.copyWith(color: AppTheme.textPrimary),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            product.price.toString(),
            style: t.bodyMedium?.copyWith(color: AppTheme.textPrimary),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            product.stock.toString(),
            textAlign: TextAlign.right,
            style: t.bodyMedium?.copyWith(color: AppTheme.textPrimary),
          ),
        ),
        const SizedBox(width: 8),
        InkWell(
          onTap: onEdit,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.edit_outlined, size: 18, color: AppTheme.primaryRed),
                const SizedBox(width: 4),
                Text(
                  'Edit',
                  style: t.bodySmall?.copyWith(
                    color: AppTheme.primaryRed,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Empty state sederhana.
class _EmptyState extends StatelessWidget {
  final VoidCallback onRefresh;

  const _EmptyState({required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Belum ada produk', style: t.titleMedium),
            const SizedBox(height: 8),
            Text(
              'Tambahkan produk pertama kamu dengan tombol di bawah.',
              style: t.bodySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            OutlinedButton(onPressed: onRefresh, child: const Text('Muat ulang')),
          ],
        ),
      ),
    );
  }
}

/// Tombol gradient utama (sesuai desain "Tambah barang")
class _PrimaryGradientButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _PrimaryGradientButton({
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Ink(
        decoration: const BoxDecoration(
          gradient: AppTheme.primaryGradient,
          borderRadius: BorderRadius.all(Radius.circular(18)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
        child: Center(
          child: Text(
            label,
            style: t.titleMedium?.copyWith(
              color: AppTheme.primaryWhite,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
