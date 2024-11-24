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

import '../features/auth/core/data/repository/auth_repository.dart' as _i842;
import '../features/auth/core/data/services/auth_services.dart' as _i16;
import '../features/auth/core/presentation/auth_cubit/auth_cubit.dart' as _i283;
import '../features/auth/login/presentation/cubit/login_cubit.dart' as _i596;
import '../features/auth/register/presentation/cubit/register_cubit.dart'
    as _i1063;
import '../features/home/data/repository/currency_repository.dart' as _i1023;
import '../features/home/data/services/currency_api_service.dart' as _i795;
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
    gh.lazySingleton<_i361.Dio>(() => appModule.dio);
    gh.lazySingleton<_i16.AuthServices>(() => _i16.AuthServicesImpl());
    gh.lazySingleton<_i795.CurrencyApiServices>(
        () => _i795.CurrencyApiServicesImpl(gh<_i361.Dio>()));
    gh.lazySingleton<_i1023.CurrencyRepository>(
        () => _i1023.CurrencyRepositoryImpl(gh<_i795.CurrencyApiServices>()));
    gh.factory<_i793.CurrencyCubit>(
        () => _i793.CurrencyCubit(gh<_i1023.CurrencyRepository>()));
    gh.lazySingleton<_i842.AuthRepository>(
        () => _i842.AuthRepositoryImpl(gh<_i16.AuthServices>()));
    gh.factory<_i283.AuthCubit>(
        () => _i283.AuthCubit(gh<_i842.AuthRepository>()));
    gh.factory<_i1063.RegisterCubit>(
        () => _i1063.RegisterCubit(gh<_i842.AuthRepository>()));
    gh.factory<_i596.LoginCubit>(
        () => _i596.LoginCubit(gh<_i842.AuthRepository>()));
    return this;
  }
}

class _$AppModule extends _i460.AppModule {}
