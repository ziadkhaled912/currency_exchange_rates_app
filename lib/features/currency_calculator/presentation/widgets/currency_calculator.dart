import 'package:currency_exchange/core/extensions/context.dart';
import 'package:currency_exchange/core/extensions/screen_util.dart';
import 'package:currency_exchange/core/presentation/theme/resources/values/app_colors.dart';
import 'package:currency_exchange/features/home/domain/entities/currency.dart';
import 'package:currency_exchange/features/home/presentation/widgets/home_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CurrencyCalculator extends StatefulWidget {
  const CurrencyCalculator({required this.dollarRate, super.key});

  final List<Currency> dollarRate;

  @override
  State<CurrencyCalculator> createState() => _CurrencyCalculatorState();
}

class _CurrencyCalculatorState extends State<CurrencyCalculator> {
  double? _result;
  Currency? _selectedCurrency;

  @override
  Widget build(BuildContext context) {
    return HomeCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Please select the currency',
            style: context.textTheme.labelSmall?.copyWith(
              color: AppColors.mainText,
              fontSize: 12.toFont,
            ),
          ),
          SizedBox(height: 8.toHeight),
          SizedBox(
            width: double.infinity,
            child: DropdownButton(
              key: const Key('CurrencyDropdown'),
              hint: Text(
                'Select the currency',
                style: context.textTheme.labelSmall?.copyWith(
                  color: AppColors.secondText,
                  fontSize: 12.toFont,
                ),
              ),
              value: _selectedCurrency,
              items: widget.dollarRate
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
                if (value is Currency) {
                  setState(() {
                    _selectedCurrency = value;
                  });
                }
              },
            ),
          ),
          SizedBox(height: 12.toHeight),
          Text(
            'Enter the value (EGP)',
            style: context.textTheme.labelSmall?.copyWith(
              color: AppColors.mainText,
              fontSize: 12.toFont,
            ),
          ),
          SizedBox(height: 8.toHeight),
          TextField(
            key: const Key('CurrencyTextField'),
            onChanged: _onValueChanged,
            style: context.textTheme.labelSmall?.copyWith(
              color: AppColors.mainText,
            ),
            onTapOutside: (_) => FocusScope.of(context).unfocus(),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: InputDecoration(
              hintText: 'Enter the value',
              contentPadding: const EdgeInsets.all(14),
              hintStyle: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(color: AppColors.secondText, fontSize: 12.toFont),
              // suffixIcon: suffix,
              // prefixIcon: prefix,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: AppColors.darkBlueGrey,
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: AppColors.darkBlueGrey,
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: AppColors.darkBlueGrey,
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: AppColors.darkBlueGrey,
                ),
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
          SizedBox(height: 16.toHeight),
          if(_result != null)
          Column(
            key: const Key('CurrencyResultColumn'),
            children: [
              Text(
                _result!.toStringAsFixed(2),
                key: const Key('CurrencyResult'),
                style: context.textTheme.bodySmall?.copyWith(
                  fontSize: 18.toFont,
                  color: AppColors.darkBlueGrey,
                ),
              ),
              SizedBox(
                height: 3.toHeight,
                width: double.infinity,
              ),
              if(_selectedCurrency != null)
              Text(
                _selectedCurrency!.currencyEnum.code,
                key: const Key('CurrencyResultCurrency'),
                style: context.textTheme.labelSmall?.copyWith(
                  fontSize: 12.toFont,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onValueChanged(String value) {
    if (_selectedCurrency != null) {
      if ((double.tryParse(value) ?? 0) > 0) {
        setState(() {
          _result = double.parse(value) * _selectedCurrency!.value;
        });
      } else {
        setState(() {
          _result = 0;
        });
      }
    }
  }
}
