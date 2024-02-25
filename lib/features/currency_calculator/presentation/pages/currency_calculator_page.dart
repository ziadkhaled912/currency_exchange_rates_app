import 'package:auto_route/annotations.dart';
import 'package:currency_exchange/features/currency_calculator/presentation/widgets/currency_calculator.dart';
import 'package:currency_exchange/features/home/data/enums/currency.dart';
import 'package:currency_exchange/features/home/presentation/cubit/currency_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class CurrencyCalculatorPage extends StatelessWidget {
  const CurrencyCalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        children: [
          BlocBuilder<CurrencyCubit, CurrencyState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const CircularProgressIndicator.adaptive();
              } else if (state.currencies != null) {
                return CurrencyCalculator(
                  dollarRate: 1 / (state.currencies!.firstWhere(
                    (element) => element.currencyEnum == CurrencyEnum.usd,
                  ).value),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
