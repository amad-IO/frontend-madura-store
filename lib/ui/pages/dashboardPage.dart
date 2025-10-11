import 'package:flutter/material.dart';
import '../../core/app_theme.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppTheme.primaryWhite,
      body: Stack(
        children: [
          // HEADER GRADIENT — lengkung besar kanan atas (sesuai gambar)
          _HeaderGradient(),

          // BODY SCROLLABLE
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(height: 48), // margin atas untuk header
              ),

              // Title di tengah: "Madura Store"
              SliverToBoxAdapter(
                child: Center(
                  child: Text(
                    'Madura Store',
                    style: text.headlineSmall?.copyWith(
                      color: AppTheme.primaryWhite,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 28)),

              // Kartu Owner yang menempel di bawah header
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _OwnerCard(
                    name: 'AZTECA CHELSY',
                    role: 'Owner',
                    imageUrl: 'https://picsum.photos/seed/owner/120/120',
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),

              // GRID PRODUK (kartu oranye seperti mockup)
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                        (context, i) => _ProductCard(product: _dummy[i]),
                    childCount: _dummy.length,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 20,
                    childAspectRatio: 0.70,
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 32)),
            ],
          ),

          // ICON MENU (hamburger) di kiri atas (di atas header)
          Positioned(
            top: 88,
            left: 24,
            child: _Hamburger(),
          ),
        ],
      ),
    );
  }
}

// ================== WIDGETS ==================

class _HeaderGradient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Header tinggi ~260 dengan lengkung kanan atas besar
    return Container(
      height: 260,
      decoration: const BoxDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(180),
          bottomLeft: Radius.circular(40),
        ),
      ),
    );
  }
}

class _Hamburger extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(10),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _Line(),
          _Line(),
          _Line(),
        ],
      ),
    );
  }
}

class _Line extends StatelessWidget {
  const _Line();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2.8,
      decoration: BoxDecoration(
        color: AppTheme.primaryWhite,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}

class _OwnerCard extends StatelessWidget {
  final String name;
  final String role;
  final String imageUrl;

  const _OwnerCard({
    required this.name,
    required this.role,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.accentOrange,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: AppTheme.shadowLight,
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(imageUrl, width: 64, height: 64, fit: BoxFit.cover),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name.toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: text.titleLarge?.copyWith(
                    color: AppTheme.primaryWhite,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  role,
                  style: text.titleMedium?.copyWith(
                    color: AppTheme.primaryWhite.withOpacity(0.95),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final _Product product;
  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.primaryOrange, // oranye kartu seperti mockup
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: AppTheme.shadowLight,
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gambar produk dengan sudut membulat dan tombol plus kecil
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.network(product.imageUrl, fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  right: 8,
                  bottom: 8,
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: const BoxDecoration(
                      color: AppTheme.primaryWhite,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.add, size: 18, color: AppTheme.primaryRed),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Nama produk (putih & tebal)
          Text(
            product.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: text.titleMedium?.copyWith(
              color: AppTheme.primaryWhite,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),

          // Rating baris kecil
          Row(
            children: [
              Icon(Icons.star_rounded, size: 16, color: AppTheme.warning),
              const SizedBox(width: 4),
              Text(
                '4,8( 542 )',
                style: text.labelMedium?.copyWith(
                  color: AppTheme.primaryWhite.withOpacity(0.9),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Harga (putih — mengikuti mockup)
          Text(
            '${product.price}',
            style: text.titleMedium?.copyWith(
              color: AppTheme.primaryWhite,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// ================== DATA DUMMY ==================

class _Product {
  final String name;
  final String imageUrl;
  final String price;
  const _Product({required this.name, required this.imageUrl, required this.price});
}

const _dummy = <_Product>[
  _Product(
    name: 'Air mineral',
    imageUrl: 'https://images.unsplash.com/photo-1523362628745-0c100150b504?q=80&w=800',
    price: '3000',
  ),
  _Product(
    name: 'Mie instan',
    imageUrl: 'https://images.unsplash.com/photo-1568605114967-8130f3a36994?q=80&w=800',
    price: '3500',
  ),
  _Product(
    name: 'Teh pucuk',
    imageUrl: 'https://images.unsplash.com/photo-1558640476-437a2b6436d2?q=80&w=800',
    price: '4000',
  ),
  _Product(
    name: 'Doritos',
    imageUrl: 'https://images.unsplash.com/photo-1613478223719-2ab802602423?q=80&w=800',
    price: '2000',
  ),
  _Product(
    name: 'Air mineral',
    imageUrl: 'https://images.unsplash.com/photo-1524592714635-4e6249bd9dbf?q=80&w=800',
    price: '3000',
  ),
  _Product(
    name: 'Nescafe',
    imageUrl: 'https://images.unsplash.com/photo-1498804103079-a6351b050096?q=80&w=800',
    price: '4000',
  ),
  _Product(
    name: 'Fanta',
    imageUrl: 'https://images.unsplash.com/photo-1551024601-bec78aea704b?q=80&w=800',
    price: '5000',
  ),
];
