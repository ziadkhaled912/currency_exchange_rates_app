import 'package:currency_exchange/core/extenstions/context.dart';
import 'package:currency_exchange/core/extenstions/screen_util.dart';
import 'package:currency_exchange/core/presentation/theme/resources/values/app_colors.dart';
import 'package:currency_exchange/generated/assets.dart';
import 'package:flutter/material.dart';

class GoldPriceCard extends StatelessWidget {
  const GoldPriceCard({
    super.key,
    required this.type,
    required this.value,
  });

  final String type;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            SizedBox(
              width: 40.toWidth,
              child: Image.asset(
                Assets.iconsGold,
                width: 40.toWidth,
              ),
            ),
            SizedBox(width: 10.toWidth),
            Expanded(
              child: Text(
                type,
                style: context.textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.mainText,
                  fontSize: 13.toFont,
                ),
              ),
            ),
            Text(
              value.toStringAsFixed(2),
              style: context.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 15.toFont,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
