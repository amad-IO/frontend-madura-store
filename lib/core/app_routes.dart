import 'package:flutter/material.dart';

// pages
import '../ui/pages/onBoarding.dart';
import '../ui/pages/LoginPage.dart';
import '../ui/pages/registerPage.dart';
import '../ui/pages/ForgotPasswordPage.dart';
import '../ui/pages/forgotOTP.dart';
import '../ui/pages/dashboardPage.dart';
import '../ui/pages/TambahToko.dart';
import '../ui/pages/laporanPenjualan.dart';
import '../ui/pages/editProdukPage.dart';
import '../data/models/product.dart';
import '../ui/pages/tambahPenggunaPage.dart';

class AppRoutes {
  // route names
  static const String onBoarding = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgot = '/forgot';
  static const String forgotOTP = '/forgot-otp';
  static const String dashboard = '/dashboard';
  static const String tambahToko = '/tambah-toko';
  static const String laporanPenjualan = '/laporan-penjualan';
  static const String editProduk = '/edit-produk';
  static const String tambahPengguna    = '/tambah-pengguna';

  // halaman pertama
  static const String initial = onBoarding;

  // routes map
  static Map<String, WidgetBuilder> get routes => {
    onBoarding: (_) => const OnBoardingPage(),
    login: (_) => const LoginPage(),
    register: (_) => const RegisterPage(),
    forgot: (_) => const ForgotPasswordPage(),
    forgotOTP: (_) => ForgotOTPPage(),
    dashboard: (_) => const DashboardPage(),
    tambahToko: (_) => const TambahToko(),
    laporanPenjualan: (_) => const LaporanPenjualanPage(),
    editProduk: (_) => const EditProdukPage(),
    tambahPengguna:     (_) => const TambahPenggunaPage(),





  };
}
