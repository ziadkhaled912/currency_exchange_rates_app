import 'package:currency_exchange/core/extensions/context.dart';
import 'package:currency_exchange/core/extensions/screen_util.dart';
import 'package:currency_exchange/core/presentation/theme/resources/values/app_colors.dart';
import 'package:currency_exchange/features/home/domain/entities/currency.dart';
import 'package:flutter/material.dart';

class CurrencyDropDown extends StatelessWidget {
  const CurrencyDropDown({
    required this.currencies,
    required this.onChanged,
    required this.label,
    this.selectedCurrency,
    super.key,
    this.dropDownKey,
  });

  final List<Currency> currencies;
  final void Function(Currency) onChanged;
  final String label;
  final Currency? selectedCurrency;
  final Key? dropDownKey;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: context.textTheme.labelSmall?.copyWith(
            color: AppColors.mainText,
            fontSize: 12.toFont,
          ),
        ),
        SizedBox(height: 8.toHeight),
        SizedBox(
          width: double.infinity,
          child: DropdownButton(
            key: dropDownKey,
            hint: Text(
              'Select the currency',
              style: context.textTheme.labelSmall?.copyWith(
                color: AppColors.secondText,
                fontSize: 12.toFont,
              ),
            ),
            value: selectedCurrency,
            items: currencies
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(
                      e.currencyEnum.name,
                      style: context.textTheme.labelSmall?.copyWith(
                        color: AppColors.mainText,
                        fontSize: 12.toFont,
                      ),
                    ),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value != null) {
                onChanged(value);
              }
            },
          ),
        ),
      ],
    );
  }
}
