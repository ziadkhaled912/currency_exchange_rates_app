import 'package:auto_route/annotations.dart';
import 'package:currency_exchange/core/extenstions/screen_util.dart';
import 'package:currency_exchange/features/home/data/enums/currency.dart';
import 'package:currency_exchange/features/home/presentation/cubit/currency_cubit.dart';
import 'package:currency_exchange/features/home/presentation/widgets/dollar_history_card/dollar_history_card.dart';
import 'package:currency_exchange/features/home/presentation/widgets/dollar_rate_card/dollar_rate_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await context.read<CurrencyCubit>().retry();
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            BlocBuilder<CurrencyCubit, CurrencyState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const CircularProgressIndicator.adaptive();
                } else if (state.currencies != null) {
                  return DollarRateCard(
                    currency: 1 /
                        (state.currencies
                                ?.firstWhere(
                                  (element) =>
                                      element.currencyEnum == CurrencyEnum.usd,
                                )
                                .value ??
                            0),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            SizedBox(height: 12.toHeight),
            const DollarHistoryCard(),
          ],
        ),
      ),
    );
  }
}
