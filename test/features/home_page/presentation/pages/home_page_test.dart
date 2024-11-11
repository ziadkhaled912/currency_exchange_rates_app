import 'package:currency_exchange/core/presentation/cubits/language_cubit/language_cubit.dart';
import 'package:currency_exchange/features/home/presentation/cubit/currency_cubit.dart';
import 'package:currency_exchange/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/test_utils.dart';
import '../../../../mock/cubits/mock_currency_cubit.dart';
import '../../../../mock/cubits/mock_language_cubit.dart' as language_cubit;

void main() {
  final currencyCubit = MockCurrencyCubit();
  final languageCubit = language_cubit.MockLanguageCubit();

  Widget homePage() => makeTestableWidget(
        child: const HomePage(),
        blocProvider: [
          BlocProvider<CurrencyCubit>(
            create: (_) => currencyCubit,
          ),
          BlocProvider<LanguageCubit>(
            create: (_) => languageCubit,
          ),
        ],
      );

  setUpAll(() {
    language_cubit.setupWhenListen(languageCubit);
  });

  group('HomePage Initial state Test', () {
    setUpAll(() {
      setupWhenListen(currencyCubit);
    });
    testWidgets(
      'HomePage render correctly',
      (tester) async {
        await pumpLocalizedWidget(tester, homePage());
        expect(find.byKey(const Key('HomeScreenRefreshIndicator')),
            findsOneWidget);
        expect(find.byKey(const Key('HomeScreenColumn')), findsOneWidget);
        expect(find.byKey(const Key('DollarRateCard')), findsOneWidget);
        expect(find.byKey(const Key('DollarHistoryCard')), findsOneWidget);
      },
    );
  });
}
