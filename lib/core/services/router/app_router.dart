import 'package:currency_exchange/features/auth/login/presentation/pages/login_page.dart';
import 'package:currency_exchange/features/auth/register/presentation/pages/register_page.dart';
import 'package:currency_exchange/features/currency_calculator/presentation/pages/currency_calculator_page.dart';
import 'package:currency_exchange/features/home/presentation/pages/home_page.dart';
import 'package:currency_exchange/features/home_base/presentation/home_base_page.dart';
import 'package:currency_exchange/features/settings/presentation/pages/settings_page.dart';
import 'package:currency_exchange/features/splash/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter router([
    String? initialLocation,
    List<GoRoute> routes = const [],
  ]) =>
      GoRouter(
        errorBuilder: (context, state) {
          return const Center(
            child: Text('Error 404'),
          );
        },
        initialLocation: initialLocation ?? SplashPage.id,
        routes: [
          ...routes,
          GoRoute(
            path: SplashPage.id,
            builder: (context, state) => const SplashPage(),
          ),
          GoRoute(
            path: LoginPage.id,
            builder: (context, state) => const LoginPage(),
          ),
          GoRoute(
            path: RegisterPage.id,
            builder: (context, state) => const RegisterPage(),
          ),
          ShellRoute(
            // path: HomeBasePage.id,
            builder: (context, state, child) => HomeBasePage(
              child: child,
            ),
            routes: [
              GoRoute(
                path: HomePage.id,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: HomePage()),
              ),
              GoRoute(
                path: CurrencyCalculatorPage.id,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: CurrencyCalculatorPage()),
              ),
              GoRoute(
                path: SettingsPage.id,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: SettingsPage()),
              ),
            ],
          ),
        ],
      );
}
