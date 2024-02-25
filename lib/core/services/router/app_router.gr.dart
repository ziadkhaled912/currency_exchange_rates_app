// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    CurrencyCalculatorRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CurrencyCalculatorPage(),
      );
    },
    CurrencyRatesRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CurrencyRatesPage(),
      );
    },
    GoldRatesRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const GoldRatesPage(),
      );
    },
    HomeBaseRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeBasePage(),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomePage(),
      );
    },
  };
}

/// generated route for
/// [CurrencyCalculatorPage]
class CurrencyCalculatorRoute extends PageRouteInfo<void> {
  const CurrencyCalculatorRoute({List<PageRouteInfo>? children})
      : super(
          CurrencyCalculatorRoute.name,
          initialChildren: children,
        );

  static const String name = 'CurrencyCalculatorRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CurrencyRatesPage]
class CurrencyRatesRoute extends PageRouteInfo<void> {
  const CurrencyRatesRoute({List<PageRouteInfo>? children})
      : super(
          CurrencyRatesRoute.name,
          initialChildren: children,
        );

  static const String name = 'CurrencyRatesRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [GoldRatesPage]
class GoldRatesRoute extends PageRouteInfo<void> {
  const GoldRatesRoute({List<PageRouteInfo>? children})
      : super(
          GoldRatesRoute.name,
          initialChildren: children,
        );

  static const String name = 'GoldRatesRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomeBasePage]
class HomeBaseRoute extends PageRouteInfo<void> {
  const HomeBaseRoute({List<PageRouteInfo>? children})
      : super(
          HomeBaseRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeBaseRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
