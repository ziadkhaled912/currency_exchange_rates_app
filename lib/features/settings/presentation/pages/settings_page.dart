import 'package:currency_exchange/core/presentation/theme/resources/values/app_colors.dart';
import 'package:currency_exchange/features/auth/core/presentation/auth_cubit/auth_cubit.dart';
import 'package:currency_exchange/features/auth/login/presentation/pages/login_page.dart';
import 'package:currency_exchange/features/settings/presentation/widgets/user_settings_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const String id = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile
            const UserSettingsCard(),
            // Logout
            TextButton.icon(
              onPressed: () {
                context.read<AuthCubit>().logout();
                context.go(LoginPage.id);
              },
              label: const Text(
                'Logout',
                style: TextStyle(
                  color: AppColors.errorColor,
                ),
              ),
              icon: const Icon(
                Icons.logout,
                color: AppColors.errorColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
