// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../core/data/api_manager/api_manager.dart' as _i7;
import '../core/data/api_manager/api_manager_implementation.dart' as _i5;
import '../core/services/router/app_router.dart' as _i3;
import '../features/gold_rates/data/repository/gold_repository.dart' as _i8;
import '../features/gold_rates/presentation/cubit/gold_price_cubit.dart'
    as _i10;
import '../features/home/data/repository/currency_repository.dart' as _i6;
import '../features/home/presentation/cubit/currency_cubit.dart' as _i9;
import 'app_module.dart' as _i11;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    gh.singleton<_i3.AppRouter>(_i3.AppRouter());
    gh.lazySingleton<_i4.Dio>(() => appModule.dio);
    gh.lazySingleton<_i5.APIsManager>(() => _i5.APIsManager(gh<_i4.Dio>()));
    gh.lazySingleton<_i6.CurrencyRepository>(
        () => _i6.CurrencyRepository(gh<_i7.APIsManager>()));
    gh.lazySingleton<_i8.GoldRepository>(
        () => _i8.GoldRepository(gh<_i7.APIsManager>()));
    gh.factory<_i9.CurrencyCubit>(
        () => _i9.CurrencyCubit(gh<_i6.CurrencyRepository>()));
    gh.factory<_i10.GoldPriceCubit>(
        () => _i10.GoldPriceCubit(gh<_i8.GoldRepository>()));
    return this;
  }
}

class _$AppModule extends _i11.AppModule {}
