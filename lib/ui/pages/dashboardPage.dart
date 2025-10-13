import 'package:flutter/material.dart';
import '../../core/app_theme.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppTheme.primaryCream,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ======== HEADER GRADIENT ========
              Container(
                width: double.infinity,
                height: 240,
                decoration: const BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: 20,
                      left: 24,
                      child: Icon(Icons.menu_rounded, color: Colors.white, size: 28),
                    ),
                    Text(
                      "Madura Store",
                      style: t.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  ],
                ),
              ),

              // ======== PROFILE CARD ========
              Transform.translate(
                offset: const Offset(0, -50),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.accentOrange,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: AppTheme.shadowLight,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: const NetworkImage("https://picsum.photos/200"),
                        backgroundColor: Colors.white,
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "AZTECA CHELSY",
                            style: t.titleLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Owner",
                            style: t.titleMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // ======== PRODUCT GRID ========
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _ProductGrid(),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

// ======== PRODUCT GRID ========
class _ProductGrid extends StatelessWidget {
  final List<Map<String, dynamic>> products = [
    {
      'name': 'Air mineral',
      'price': 3000,
      'rating': 4.8,
      'image': 'https://picsum.photos/200/200?1',
    },
    {
      'name': 'Mie instan',
      'price': 3500,
      'rating': 4.8,
      'image': 'https://picsum.photos/200/200?2',
    },
    {
      'name': 'Teh pucuk',
      'price': 4000,
      'rating': 4.8,
      'image': 'https://picsum.photos/200/200?3',
    },
    {
      'name': 'Doritos',
      'price': 2000,
      'rating': 4.8,
      'image': 'https://picsum.photos/200/200?4',
    },
    {
      'name': 'Snickers',
      'price': 3000,
      'rating': 4.8,
      'image': 'https://picsum.photos/200/200?5',
    },
    {
      'name': 'Nescafe',
      'price': 4000,
      'rating': 4.8,
      'image': 'https://picsum.photos/200/200?6',
    },
  ];

  _ProductGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: 0.78,
      ),
      itemBuilder: (context, i) {
        final item = products[i];
        return Container(
          decoration: BoxDecoration(
            color: AppTheme.primaryOrange,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: AppTheme.shadowLight,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // image
              Expanded(
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      child: Image.network(item['image'], fit: BoxFit.cover, width: double.infinity),
                    ),
                    Positioned(
                      right: 6,
                      bottom: 6,
                      child: Container(
                        height: 26,
                        width: 26,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.add, color: AppTheme.primaryRed, size: 18),
                      ),
                    ),
                  ],
                ),
              ),

              // details
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['name'],
                      style: t.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.yellow, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          '${item['rating']} (542)',
                          style: t.labelMedium?.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${item['price']}',
                      style: t.titleSmall?.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
