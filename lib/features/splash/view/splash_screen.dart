// ignore_for_file: use_build_context_synchronously

import 'package:currency_exchange/core/presentation/theme/resources/values/app_colors.dart';
import 'package:currency_exchange/features/auth/core/presentation/auth_cubit/auth_cubit.dart';
import 'package:currency_exchange/features/auth/login/presentation/pages/login_page.dart';
import 'package:currency_exchange/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      if (context.read<AuthCubit>().state.isAuthenticated) {
        context.go(HomePage.id);
      } else {
        context.go(LoginPage.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.primary,
    );
  }
}
