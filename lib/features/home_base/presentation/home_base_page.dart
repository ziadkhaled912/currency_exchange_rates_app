import 'package:currency_exchange/core/extensions/context.dart';
import 'package:currency_exchange/core/presentation/theme/resources/values/app_colors.dart';
import 'package:currency_exchange/di/injection_container.dart';
import 'package:currency_exchange/features/currency_calculator/presentation/pages/currency_calculator_page.dart';
import 'package:currency_exchange/features/home/data/enums/currency_enum.dart';
import 'package:currency_exchange/features/home/data/models/request_models/latest_rates_request_model.dart';
import 'package:currency_exchange/features/home/presentation/cubit/currency_cubit.dart';
import 'package:currency_exchange/features/home/presentation/pages/home_page.dart';
import 'package:currency_exchange/features/settings/presentation/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomeBasePage extends StatelessWidget {
  const HomeBasePage({
    required this.child,
    super.key,
    this.blocProviders,
  });

  static const String id = '/home';

  final Widget child;
  final List<BlocProvider>? blocProviders;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: blocProviders ??
          [
            BlocProvider(
              create: (context) => locator<CurrencyCubit>()
                ..getLatestRates(LatestRatesRequestModel(
                  baseCurrency: CurrencyEnum.egp,
                  currencies: CurrencyEnum.values
                      .where((element) => element != CurrencyEnum.egp)
                      .toList(),
                )),
            ),
          ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          title: Text(
            'Gold Today',
            style: context.textTheme.titleSmall?.copyWith(
              color: Colors.white,
              fontSize: 18.sp,
            ),
          ),
        ),
        backgroundColor: AppColors.paleGrey,
        body: SafeArea(
          top: _currentIndex(context) != 0,
          bottom: _currentIndex(context) != 0,
          child: Container(
            child: child,
          ),
        ),
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: _currentIndex(context),
          onTap: (index) => _onItemTapped(context, index),
          backgroundColor: AppColors.primary,
          selectedItemColor: Colors.white,
          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          items: [
            /// Home
            SalomonBottomBarItem(
              icon: const Icon(Icons.home),
              title: const Text('Home'),
              // selectedColor: Colors.purple,
            ),

            SalomonBottomBarItem(
              icon: const Icon(Icons.calculate_outlined),
              title: const Text('Calculator'),
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.settings),
              title: const Text('Settings'),
            ),
          ],
        ),
      ),
    );
  }

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    if (location.startsWith(CurrencyCalculatorPage.id)) {
      return 1;
    } else if (location.startsWith(SettingsPage.id)) {
      return 2;
    }
    return 0;
  }

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(HomePage.id);
        break;
      case 1:
        context.go(CurrencyCalculatorPage.id);
        break;
      case 2:
        context.go(SettingsPage.id);
        break;
    }
  }
}
