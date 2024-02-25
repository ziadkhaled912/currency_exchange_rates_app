import 'package:currency_exchange/core/extenstions/context.dart';
import 'package:currency_exchange/core/extenstions/screen_util.dart';
import 'package:currency_exchange/core/presentation/theme/resources/values/app_colors.dart';
import 'package:currency_exchange/features/home/data/enums/currency.dart';
import 'package:flutter/material.dart';

class CurrencyCard extends StatelessWidget {
  const CurrencyCard({
    required this.currency,
    required this.value,
    super.key,
  });

  final CurrencyEnum currency;
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
            Container(
              width: 40.toWidth,
              height: 40.toWidth,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                currency.icon,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            SizedBox(width: 10.toWidth),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currency.code,
                    style: context.textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.mainText,
                      fontSize: 13.toFont,
                    ),
                  ),
                  SizedBox(height: 4.toHeight),
                  Text(
                    currency.name,
                    style: context.textTheme.labelSmall?.copyWith(
                      color: AppColors.mainText,
                      fontSize: 11.toFont,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              (1 / value).toStringAsFixed(2),
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
