import 'package:flutter/material.dart';
import 'core/app_theme.dart';
import 'core/app_routes.dart';

void main() {
  runApp(const KasirMaduraApp());
}

class KasirMaduraApp extends StatelessWidget {
  const KasirMaduraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kasir Madura',
      theme: AppTheme.theme,// bisa ThemeMode.system
      initialRoute: AppRoutes.initial,
        routes: AppRoutes.routes,
      themeAnimationDuration: const Duration(milliseconds: 300),
    );
  }
}
