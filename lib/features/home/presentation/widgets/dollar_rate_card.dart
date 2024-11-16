import 'package:currency_exchange/core/extensions/context.dart';
import 'package:currency_exchange/core/extensions/screen_util.dart';
import 'package:currency_exchange/core/presentation/theme/resources/values/app_colors.dart';
import 'package:currency_exchange/features/home/presentation/widgets/home_card.dart';
import 'package:currency_exchange/generated/assets.dart';
import 'package:flutter/material.dart';

class DollarRateCard extends StatelessWidget {
  const DollarRateCard({
    required this.currency,
    super.key,
  });

  final double currency;

  @override
  Widget build(BuildContext context) {
    return HomeCard(
      key: const Key('DollarRateHomeCard'),
      child: Column(
        key: const Key('DollarRateCardColumn'),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            key: const Key('DollarRateCardRow'),
            children: [
              Image.asset(
                Assets.flagsUnitedStates,
                key: const Key('DollarRateCardFlag'),
                width: 24.toWidth,
              ),
              SizedBox(width: 8.toWidth),
              Text(
                'USD / EGP',
                key: const Key('DollarRateCardCurrencyText'),
                style: context.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.toHeight),
          Text(
            'Today USD in Egypt',
            key: const Key('DollarRateCardBodyText'),
            style: context.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.secondText,
              fontSize: 12.toFont,
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: FittedBox(
              child: Text(
                currency.toStringAsFixed(2),
                key: const Key('DollarRateCardCurrencyValue'),
                style: const TextStyle(
                  color: AppColors.darkBlueGrey,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
