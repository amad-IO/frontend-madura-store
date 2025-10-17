import 'package:flutter/material.dart';
import '../ui/pages/LoginPage.dart';
import '../ui/pages/onBoarding.dart';
import '../ui/pages/dashboardPage.dart';
import '../ui/pages/registerPage.dart';
import '../ui/pages/ForgotPasswordPage.dart';

class AppRoutes {
  static const String onBoarding = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgot = '/forgot';
  static const String dashboard = '/dashboard';

  // halaman pertama
  static const String initial = onBoarding;

  // kalau kamu ingin tetap punya map statis (opsional)
  static Map<String, WidgetBuilder> get routes =>
      {
        onBoarding: (_) => const OnBoardingPage(),
        login: (_) => const LoginPage(),
        register: (_) => const RegisterPage(),
        forgot: (_) => const ForgotPasswordPage(),
        dashboard: (_) => const DashboardPage(),
      };

}
