import 'package:currency_exchange/core/extensions/screen_util.dart';
import 'package:currency_exchange/features/home/data/enums/currency_enum.dart';
import 'package:currency_exchange/features/home/presentation/cubit/currency_cubit.dart';
import 'package:currency_exchange/features/home/presentation/widgets/dollar_history_card/dollar_history_card.dart';
import 'package:currency_exchange/features/home/presentation/widgets/dollar_rate_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key = const Key('HomePage')});

  static const String id = '/home';

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: const Key('HomeScreenRefreshIndicator'),
      onRefresh: () async {
        await context.read<CurrencyCubit>().retry();
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          key: const Key('HomeScreenColumn'),
          children: [
            BlocBuilder<CurrencyCubit, CurrencyState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const CircularProgressIndicator.adaptive(
                    key: Key('DollarRateCardLoading'),
                  );
                } else if (state.currencies != null) {
                  return DollarRateCard(
                    key: const Key('DollarRateCard'),
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
            const DollarHistoryCard(
              key: Key('DollarHistoryCard'),
            ),
          ],
        ),
      ),
    );
  }
}
