import 'package:currency_exchange/core/extensions/context.dart';
import 'package:currency_exchange/core/extensions/screen_util.dart';
import 'package:currency_exchange/core/presentation/theme/resources/values/app_colors.dart';
import 'package:currency_exchange/di/injection_container.dart';
import 'package:currency_exchange/features/currency_calculator/presentation/pages/currency_calculator_page.dart';
import 'package:currency_exchange/features/currency_rates/presentation/pages/currency_rates_page.dart';
import 'package:currency_exchange/features/gold_rates/data/models/gold_price_request_model.dart';
import 'package:currency_exchange/features/gold_rates/presentation/cubit/gold_price_cubit.dart';
import 'package:currency_exchange/features/gold_rates/presentation/pages/gold_rates_page.dart';
import 'package:currency_exchange/features/home/data/enums/currency_enum.dart';
import 'package:currency_exchange/features/home/data/models/request_models/latest_rates_request_model.dart';
import 'package:currency_exchange/features/home/presentation/cubit/currency_cubit.dart';
import 'package:currency_exchange/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            BlocProvider(
              create: (context) => locator<GoldPriceCubit>()
                ..getGoldPrice(
                  GoldPriceRequestModel(),
                ),
            ),
          ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          title: Text(
            'Gold Today',
            style: context.textTheme.titleSmall?.copyWith(
              color: Colors.white,
              fontSize: 18.toFont,
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
          margin: const EdgeInsets.all(16),
          items: [
            /// Home
            SalomonBottomBarItem(
              icon: const Icon(Icons.home),
              title: const Text('Home'),
              // selectedColor: Colors.purple,
            ),

            SalomonBottomBarItem(
              icon: const Icon(Icons.currency_exchange),
              title: const Text('Currencies'),
              // selectedColor: Colors.pink,
            ),

            SalomonBottomBarItem(
              icon: const Icon(Icons.grid_goldenratio),
              title: const Text('Gold'),
              // selectedColor: Colors.orange,
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.calculate_outlined),
              title: const Text('Calculator'),
              // selectedColor: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    if (location.startsWith(CurrencyRatesPage.id)) {
      return 1;
    } else if (location.startsWith(GoldRatesPage.id)) {
      return 2;
    } else if (location.startsWith(CurrencyCalculatorPage.id)) {
      return 3;
    }
    return 0;
  }

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(HomePage.id);
        break;
      case 1:
        context.go(CurrencyRatesPage.id);
        break;
      case 2:
        context.go(GoldRatesPage.id);
        break;
      case 3:
        context.go(CurrencyCalculatorPage.id);
        break;
    }
  }
}
