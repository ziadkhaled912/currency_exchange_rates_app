import 'package:currency_exchange/core/extensions/context.dart';
import 'package:currency_exchange/core/extensions/validators.dart';
import 'package:currency_exchange/core/presentation/theme/resources/values/app_colors.dart';
import 'package:currency_exchange/features/currency_calculator/presentation/cubit/currency_calculator_cubit.dart';
import 'package:currency_exchange/features/currency_calculator/presentation/widgets/currency_drop_down.dart';
import 'package:currency_exchange/features/home/domain/entities/currency.dart';
import 'package:currency_exchange/features/home/presentation/widgets/home_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CurrencyCalculator extends StatefulWidget {
  const CurrencyCalculator({required this.currencies, super.key});

  final List<Currency> currencies;

  @override
  State<CurrencyCalculator> createState() => _CurrencyCalculatorState();
}

class _CurrencyCalculatorState extends State<CurrencyCalculator> {
  @override
  Widget build(BuildContext context) {
    return HomeCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BlocBuilder<CurrencyCalculatorCubit, CurrencyCalculatorState>(
                      buildWhen: (previous, current) =>
                          previous.firstSelectedCurrency != current.firstSelectedCurrency,
                      builder: (context, state) {
                        return CurrencyDropDown(
                          dropDownKey: const Key('FromCurrencyDropdown'),
                          label: 'From',
                          currencies: widget.currencies,
                          selectedCurrency: state.firstSelectedCurrency,
                          onChanged: (value) {
                            context
                                .read<CurrencyCalculatorCubit>()
                                .setFirstSelectedCurrency(value);
                          },
                        );
                      },
                    ),
                    SizedBox(height: 12.h),
                    BlocBuilder<CurrencyCalculatorCubit, CurrencyCalculatorState>(
                      buildWhen: (previous, current) =>
                          previous.secondSelectedCurrency !=
                          current.secondSelectedCurrency,
                      builder: (context, state) {
                        return CurrencyDropDown(
                          dropDownKey: const Key('ToCurrencyDropdown'),
                          label: 'To',
                          currencies: widget.currencies,
                          selectedCurrency: state.secondSelectedCurrency,
                          onChanged: (value) {
                            context
                                .read<CurrencyCalculatorCubit>()
                                .setSecondSelectedCurrency(value);
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.w),
              IconButton(
                key: const Key('SwapCurrencyButton'),
                onPressed: () {
                  context.read<CurrencyCalculatorCubit>().swapCurrencies();
                },
                icon: const Icon(
                  Icons.swap_vert,
                  color: AppColors.darkBlueGrey,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            'Amount',
            style: context.textTheme.labelSmall?.copyWith(
              color: AppColors.mainText,
              fontSize: 12.sp,
            ),
          ),
          SizedBox(height: 8.h),
          TextFormField(
            key: const Key('CurrencyTextField'),
            onChanged: (value) {
              context.read<CurrencyCalculatorCubit>().setAmount(value);
            },
            style: context.textTheme.labelSmall?.copyWith(
              color: AppColors.mainText,
            ),
            onTapOutside: (_) => FocusScope.of(context).unfocus(),
            keyboardType: TextInputType.number,
            validator: validateAmount,
                autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              hintText: 'Enter the amount',
              contentPadding: const EdgeInsets.all(14),
              hintStyle: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(color: AppColors.secondText, fontSize: 12.sp),
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
          SizedBox(height: 16.h),
          BlocBuilder<CurrencyCalculatorCubit, CurrencyCalculatorState>(
            buildWhen: (previous, current) => previous.result != current.result,
            builder: (context, state) {
              if (state.result == null) {
                return const SizedBox.shrink();
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                key: const Key('CurrencyResultColumn'),
                children: [
                  Text(
                    // ignore: lines_longer_than_80_chars
                    '${state.amount} ${state.firstSelectedCurrency?.currencyEnum.code} =',
                    key: const Key('CurrencyResultInput'),
                    style: context.textTheme.bodySmall?.copyWith(
                      fontSize: 12.sp,
                      color: AppColors.darkBlueGrey,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    // ignore: lines_longer_than_80_chars
                    '${state.result?.toStringAsFixed(2)} ${state.secondSelectedCurrency?.currencyEnum.code}',
                    key: const Key('CurrencyResult'),
                    style: context.textTheme.bodySmall?.copyWith(
                      fontSize: 18.sp,
                      color: AppColors.darkBlueGrey,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  String? validateAmount(String? value) {
    if (value == null || !value.validateAmount()) {
      return 'Please enter valid amount';
    }
    return null;
  }
}
