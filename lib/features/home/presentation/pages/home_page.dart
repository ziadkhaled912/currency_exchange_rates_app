import 'package:currency_exchange/core/extensions/screen_util.dart';
import 'package:currency_exchange/features/currency_rates/presentation/widgets/currency_card.dart';
import 'package:currency_exchange/features/home/data/enums/currency_enum.dart';
import 'package:currency_exchange/features/home/domain/entities/currency.dart';
import 'package:currency_exchange/features/home/presentation/cubit/currency_cubit.dart';
import 'package:currency_exchange/features/home/presentation/widgets/dollar_rate_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
          crossAxisAlignment: CrossAxisAlignment.start,
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
            SizedBox(height: 16.toHeight),
            const Text(
              'Currencies',
              key: Key('CurrencyExchangeText'),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12.toHeight),
            BlocBuilder<CurrencyCubit, CurrencyState>(
              builder: (context, state) {
                return Skeletonizer(
                  key: const Key('CurrencyExchangeLoading'),
                  enabled: state.isLoading,
                  child: ListView.separated(
                    itemCount: state.currencies?.length ?? 5,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (_, index) =>
                        SizedBox(height: 12.toHeight),
                    itemBuilder: (_, index) {
                      final currency = state.currencies?[index] ??
                          const Currency(
                            currencyEnum: CurrencyEnum.usd,
                            value: 0,
                          );
                      return CurrencyCard(
                        currency: currency.currencyEnum,
                        value: currency.value,
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
