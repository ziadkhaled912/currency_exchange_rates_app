import 'package:currency_exchange/core/extenstions/context.dart';
import 'package:currency_exchange/core/extenstions/screen_util.dart';
import 'package:currency_exchange/core/presentation/theme/resources/values/app_colors.dart';
import 'package:currency_exchange/features/home/presentation/widgets/home_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CurrencyCalculator extends StatefulWidget {
  const CurrencyCalculator({required this.dollarRate, super.key});

  final double dollarRate;

  @override
  State<CurrencyCalculator> createState() => _CurrencyCalculatorState();
}

class _CurrencyCalculatorState extends State<CurrencyCalculator> {
  double _result = 0;

  @override
  Widget build(BuildContext context) {
    return HomeCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Enter the value',
            style: context.textTheme.labelSmall?.copyWith(
              color: AppColors.mainText,
              fontSize: 12.toFont,
            ),
          ),
          SizedBox(height: 8.toHeight),
          TextField(
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
          Column(
            children: [
              Text(
                _result.toStringAsFixed(2),
                style: context.textTheme.bodySmall?.copyWith(
                  fontSize: 18.toFont,
                  color: AppColors.darkBlueGrey,
                ),
              ),
              SizedBox(
                height: 3.toHeight,
                width: double.infinity,
              ),
              Text(
                'EGP',
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
    setState(() {
      _result = double.parse(value) * widget.dollarRate;
    });
  }
}
