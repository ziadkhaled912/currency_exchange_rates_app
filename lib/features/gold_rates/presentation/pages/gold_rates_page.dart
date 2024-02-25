import 'package:auto_route/annotations.dart';
import 'package:currency_exchange/core/extenstions/context.dart';
import 'package:currency_exchange/core/extenstions/screen_util.dart';
import 'package:currency_exchange/core/extenstions/widgets_list_utils.dart';
import 'package:currency_exchange/core/presentation/theme/resources/values/app_colors.dart';
import 'package:currency_exchange/features/gold_rates/presentation/cubit/gold_price_cubit.dart';
import 'package:currency_exchange/features/gold_rates/presentation/widgets/gold_price_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class GoldRatesPage extends StatelessWidget {
  const GoldRatesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await context.read<GoldPriceCubit>().retry();
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
                    'Gram',
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
            child: BlocBuilder<GoldPriceCubit, GoldPriceState>(
              builder: (context, state) {
                if(state.isLoading) {
                  return const CircularProgressIndicator.adaptive();
                }
                if (state.responseModel != null) {
                  return ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    children: [
                      if(state.responseModel!.priceGram24K != null)
                      GoldPriceCard(
                        type: '24 Karat Gold',
                        value: state.responseModel!.priceGram24K!,
                      ),
                      if(state.responseModel!.priceGram22K != null)
                        GoldPriceCard(
                          type: '22 Karat Gold',
                          value: state.responseModel!.priceGram22K!,
                        ),
                      if(state.responseModel!.priceGram21K != null)
                        GoldPriceCard(
                          type: '21 Karat Gold',
                          value: state.responseModel!.priceGram21K!,
                        ),
                      if(state.responseModel!.priceGram18K != null)
                        GoldPriceCard(
                          type: '18 Karat Gold',
                          value: state.responseModel!.priceGram18K!,
                        ),
                      if(state.responseModel!.priceGram14K != null)
                        GoldPriceCard(
                          type: '14 Karat Gold',
                          value: state.responseModel!.priceGram14K!,
                        ),
                      if(state.responseModel!.priceGram10K != null)
                        GoldPriceCard(
                          type: '10 Karat Gold',
                          value: state.responseModel!.priceGram10K!,
                        ),
                    ].addSeparator(SizedBox(height: 12.toHeight)),
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
