import 'dart:async';
import 'dart:developer';

import 'package:currency_exchange/core/data/api_manager/api_manager.dart';
import 'package:currency_exchange/core/presentation/app.dart';
import 'package:currency_exchange/di/injection_container.dart';
import 'package:currency_exchange/flavor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  AppFlavor.instance.flavor = Flavor.production;
  bootstrap();
}

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap() async {
  BindingBase.debugZoneErrorsAreFatal = false;

  WidgetsFlutterBinding.ensureInitialized();

  BaseRequestDefaults.instance.baseUrl = AppFlavor.instance.baseUrl;
  // Init dependency
  configureDependencies();
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  Bloc.observer = const AppBlocObserver();

  await runZonedGuarded(
        () async {
          WidgetsFlutterBinding.ensureInitialized();

          runApp(
      const App(),
    );
        },
        (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
