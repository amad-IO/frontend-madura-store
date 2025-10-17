import 'package:flutter/material.dart';

// pages
import '../ui/pages/onBoarding.dart';
import '../ui/pages/LoginPage.dart';
import '../ui/pages/registerPage.dart';
import '../ui/pages/ForgotPasswordPage.dart';
import '../ui/pages/forgotOTP.dart';        // pastikan file & class: ForgotOTPPage
import '../ui/pages/dashboardPage.dart';
import '../ui/pages/TambahToko.dart';       // pastikan class: TambahToko

class AppRoutes {
  // route names
  static const String onBoarding = '/';
  static const String login      = '/login';
  static const String register   = '/register';
  static const String forgot     = '/forgot';
  static const String forgotOTP  = '/forgot-otp';   // <-- TAMBAHKAN INI
  static const String dashboard  = '/dashboard';
  static const String tambahToko = '/tambah-toko';  // <-- lowerCamelCase

  // halaman pertama
  static const String initial = onBoarding;

  // routes map
  static Map<String, WidgetBuilder> get routes => {
    onBoarding: (_) => const OnBoardingPage(),
    login: (_)      => const LoginPage(),
    register: (_)   => const RegisterPage(),
    forgot: (_)     => const ForgotPasswordPage(),
    forgotOTP: (_)  => const ForgotOTPPage(),   // <-- sekarang terdefinisi
    dashboard: (_)  => const DashboardPage(),
    tambahToko: (_) => Tambahtoko(),      // <-- sesuaikan nama class
  };
}
