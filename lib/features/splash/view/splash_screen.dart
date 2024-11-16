import 'package:currency_exchange/core/presentation/theme/resources/values/app_colors.dart';
import 'package:currency_exchange/features/home_base/presentation/home_base_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  static const id = '/';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // wait for 1 seconds just to show the splash screen
    Future<void>.delayed(const Duration(seconds: 1), () {
      // ignore: use_build_context_synchronously
      context.go(HomeBasePage.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.primary,
    );
  }
}
