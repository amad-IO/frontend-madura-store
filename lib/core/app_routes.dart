import 'package:flutter/material.dart';
import '../ui/pages/LoginPage.dart';
import '../ui/pages/onBoarding.dart';
import '../ui/pages/dashboardPage.dart';

class AppRoutes {
  static const String onBoarding = '/';
  static const String login = '/login';
  static const String dashboard = '/dashboard';

  // halaman pertama
  static const String initial = onBoarding;

  // kalau kamu ingin tetap punya map statis (opsional)
  static Map<String, WidgetBuilder> get routes =>
      {
        onBoarding: (_) => const OnBoardingPage(),
        login: (_) => const LoginPage(),
        dashboard: (_) => const DashboardPage(),
      };

}
