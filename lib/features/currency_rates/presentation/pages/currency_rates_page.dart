import 'package:auto_route/auto_route.dart';
import 'package:currency_exchange/core/extenstions/context.dart';
import 'package:currency_exchange/core/extenstions/screen_util.dart';
import 'package:currency_exchange/core/presentation/theme/resources/values/app_colors.dart';
import 'package:currency_exchange/features/currency_rates/presentation/widgets/currency_card.dart';
import 'package:currency_exchange/features/home/presentation/cubit/currency_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class CurrencyRatesPage extends StatelessWidget {
  const CurrencyRatesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await context.read<CurrencyCubit>().retry();
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 34),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Currency',
                    style: context.textTheme.labelSmall?.copyWith(
                      color: AppColors.mainText,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Text(
                  'Price',
                  style: context.textTheme.labelSmall?.copyWith(
                    color: AppColors.mainText,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<CurrencyCubit, CurrencyState>(
              builder: (context, state) {
                if (state.currencies != null) {
                  return ListView.separated(
                    padding: const EdgeInsets.only(
                      left: 24,
                      right: 24,
                      bottom: 16,
                    ),
                    itemCount: state.currencies!.length,
                    separatorBuilder: (_, index) =>
                        SizedBox(height: 12.toHeight),
                    itemBuilder: (_, index) {
                      final currency = state.currencies![index];
                      return CurrencyCard(
                        currency: currency.currencyEnum,
                        value: currency.value,
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
