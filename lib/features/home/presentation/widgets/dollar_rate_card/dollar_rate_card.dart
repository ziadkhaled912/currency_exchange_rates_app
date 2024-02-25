import 'package:currency_exchange/core/extenstions/context.dart';
import 'package:currency_exchange/core/extenstions/screen_util.dart';
import 'package:currency_exchange/core/presentation/theme/resources/values/app_colors.dart';
import 'package:currency_exchange/features/home/presentation/widgets/home_card.dart';
import 'package:currency_exchange/generated/assets.dart';
import 'package:flutter/material.dart';

class DollarRateCard extends StatelessWidget {
  const DollarRateCard({super.key, required this.currency});

  final double currency;

  @override
  Widget build(BuildContext context) {
    return HomeCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                Assets.flagsUnitedStates,
                width: 24.toWidth,
              ),
              SizedBox(width: 8.toWidth),
              Text(
                "USD / EGP",
                style: context.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.toHeight),
          Text(
            "Today USD in Egypt",
            style: context.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.secondText,
              fontSize: 12.toFont,
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                currency.toStringAsFixed(2),
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
