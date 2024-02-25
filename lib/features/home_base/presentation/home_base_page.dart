import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:currency_exchange/core/extenstions/context.dart';
import 'package:currency_exchange/core/extenstions/screen_util.dart';
import 'package:currency_exchange/core/presentation/theme/resources/values/app_colors.dart';
import 'package:currency_exchange/core/services/router/app_router.dart';
import 'package:currency_exchange/di/injection_container.dart';
import 'package:currency_exchange/features/gold_rates/data/models/gold_price_request_model.dart';
import 'package:currency_exchange/features/gold_rates/presentation/cubit/gold_price_cubit.dart';
import 'package:currency_exchange/features/home/data/enums/currency.dart';
import 'package:currency_exchange/features/home/data/models/request_models/latest_rates_request_model.dart';
import 'package:currency_exchange/features/home/presentation/cubit/currency_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

@RoutePage()
class HomeBasePage extends StatelessWidget {
  const HomeBasePage({super.key});

  static const String id = '/';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
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
      child: AutoTabsRouter(
        routes: const [
          HomeRoute(),
          CurrencyRatesRoute(),
          GoldRatesRoute(),
          CurrencyCalculatorRoute(),
        ],
        builder: (context, child) {
          final tabsRouter = AutoTabsRouter.of(context);
          int selectedIndex = tabsRouter.activeIndex;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.primary,
              title: Text(
                'Gold Today',
                style: context.textTheme.titleSmall?.copyWith(
                  color: Colors.white,
                  fontSize: 18.toFont,
                ),
              ),
              // actions: [
              //   IconButton(
              //     onPressed: () {},
              //     icon: const Icon(
              //       Icons.language,
              //     ),
              //     color: Colors.white,
              //   ),
              // ],
            ),
            backgroundColor: AppColors.paleGrey,
            body: SafeArea(
              top: selectedIndex != 0,
              bottom: selectedIndex != 0,
              child: Container(
                  // color: AppColors.colorFFFFFF,
                  child: child),
            ),
            bottomNavigationBar: SalomonBottomBar(
              currentIndex: selectedIndex,
              onTap: tabsRouter.setActiveIndex,
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
          );
        },
      ),
    );
  }
}
