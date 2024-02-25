import 'package:auto_route/auto_route.dart';
import 'package:currency_exchange/core/services/router/routes.dart';
import 'package:currency_exchange/features/currency_calculator/presentation/pages/currency_calculator_page.dart';
import 'package:currency_exchange/features/currency_rates/presentation/pages/currency_rates_page.dart';
import 'package:currency_exchange/features/gold_rates/presentation/pages/gold_rates_page.dart';
import 'package:currency_exchange/features/home/presentation/pages/home_page.dart';
import 'package:currency_exchange/features/home_base/presentation/home_base_page.dart';
import 'package:injectable/injectable.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
@singleton
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: HomeBaseRoute.page,
          path: Routes.homeBasePage.name,
          children: <AutoRoute>[
            AutoRoute(
              page: HomeRoute.page,
              path: Routes.homePage.name,
            ),
            AutoRoute(
              page: CurrencyRatesRoute.page,
              path: Routes.currencyRates.name,
            ),
            AutoRoute(
              page: GoldRatesRoute.page,
              path: Routes.goldRates.name,
            ),
            AutoRoute(
              page: CurrencyCalculatorRoute.page,
              path: Routes.currencyCalculator.name,
            ),
          ],
        ),
      ];
}
