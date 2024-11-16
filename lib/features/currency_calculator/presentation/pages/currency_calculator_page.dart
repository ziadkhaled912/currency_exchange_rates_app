import 'package:currency_exchange/features/currency_calculator/presentation/cubit/currency_calculator_cubit.dart';
import 'package:currency_exchange/features/currency_calculator/presentation/widgets/currency_calculator.dart';
import 'package:currency_exchange/features/home/presentation/cubit/currency_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrencyCalculatorPage extends StatelessWidget {
  const CurrencyCalculatorPage({super.key, this.currencyCubit});

  static const String id = '/currencyCalculator';

  final CurrencyCubit? currencyCubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<CurrencyCubit, CurrencyState>(
              bloc: currencyCubit,
              builder: (context, state) {
                if (state.isLoading) {
                  return const CircularProgressIndicator.adaptive();
                } else if (state.currencies != null) {
                  return BlocProvider(
                    create: (context) => CurrencyCalculatorCubit(
                      state.currencies!,
                    ),
                    child: CurrencyCalculator(
                      currencies: state.currencies!,
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
