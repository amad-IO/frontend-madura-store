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
import '../ui/pages/setNewPassword.dart';
import '../ui/pages/TambahEditProduk.dart';
import '../ui/pages/checkoutPage.dart';

class AppRoutes {
  // route names
  static const String onBoarding = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgot = '/forgot';
  static const String forgotOTP = '/forgot-otp';
  static const String setNewPassword = '/set-new-password';
  static const String dashboard = '/dashboard';
  static const String tambahToko = '/tambah-toko';
  static const String laporanPenjualan = '/laporan-penjualan';
  static const String editProduk = '/edit-produk';
  static const String tambahPengguna    = '/tambah-pengguna';
  static const String checkoutPage = '/checkout';

  // halaman pertama
  static const String initial = onBoarding;

  // routes map
  static Map<String, WidgetBuilder> get routes => {
    onBoarding: (_) => const OnBoardingPage(),
    login: (_) => const LoginPage(),
    register: (_) => const RegisterPage(),
    forgot: (_) => const ForgotPasswordPage(),
    forgotOTP: (_) => const ForgotOTPPage(),
    setNewPassword: (_) => const SetNewPasswordPage(),
    dashboard: (_) => const DashboardPage(),
    tambahToko: (_) => const TambahToko(),
    laporanPenjualan: (_) => const LaporanPenjualanPage(),
    editProduk: (_) => const EditProdukPage(),
    '/tambah-edit-produk': (_) => const TambahEditProduk(),
    tambahPengguna:     (_) => const TambahPenggunaPage(),
    checkoutPage: (_) => const CheckoutPage(),






  };
}
