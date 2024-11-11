// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../core/services/router/app_router.dart' as _i120;
import '../features/gold_rates/data/repository/gold_repository.dart' as _i919;
import '../features/gold_rates/data/services/gold_rates_api_services.dart'
    as _i1044;
import '../features/gold_rates/presentation/cubit/gold_price_cubit.dart'
    as _i803;
import '../features/home/data/repository/currency_repository.dart' as _i1023;
import '../features/home/data/services/currency_api_service.dart' as _i268;
import '../features/home/presentation/cubit/currency_cubit.dart' as _i793;
import 'app_module.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    gh.singleton<_i120.AppRouter>(() => _i120.AppRouter());
    gh.lazySingleton<_i361.Dio>(() => appModule.dio);
    gh.lazySingleton<_i268.CurrencyApiServices>(
        () => _i268.CurrencyApiServices(gh<_i361.Dio>()));
    gh.lazySingleton<_i1044.GoldRatesApiServices>(
        () => _i1044.GoldRatesApiServices(gh<_i361.Dio>()));
    gh.lazySingleton<_i1023.CurrencyRepository>(
        () => _i1023.CurrencyRepository(gh<_i268.CurrencyApiServices>()));
    gh.lazySingleton<_i919.GoldRepository>(
        () => _i919.GoldRepository(gh<_i1044.GoldRatesApiServices>()));
    gh.factory<_i803.GoldPriceCubit>(
        () => _i803.GoldPriceCubit(gh<_i919.GoldRepository>()));
    gh.factory<_i793.CurrencyCubit>(
        () => _i793.CurrencyCubit(gh<_i1023.CurrencyRepository>()));
    return this;
  }
}

class _$AppModule extends _i460.AppModule {}
