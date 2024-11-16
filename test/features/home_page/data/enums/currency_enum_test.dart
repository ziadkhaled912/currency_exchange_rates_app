import 'package:currency_exchange/features/home/data/enums/currency_enum.dart';
import 'package:currency_exchange/generated/assets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'it should give the right enum when the code is given',
    () {
      // arrange
      const code = 'EGP';

      // act
      final currencyEnum = CurrencyEnum.values.firstWhere(
        (element) => element.code == code,
      );

      // assert
      expect(currencyEnum, CurrencyEnum.egp);
    },
  );

  test(
    'it should give the right code when the enum is given',
    () {
      // arrange
      const currencyEnum = CurrencyEnum.egp;

      // act
      final code = currencyEnum.code;

      // assert
      expect(code, 'EGP');
    },
  );

  test(
    'it should give the right icon when the enum is given',
    () {
      // arrange
      const currencyEnum = CurrencyEnum.usd;

      // act
      final icon = currencyEnum.icon;

      // assert
      expect(icon, Assets.flagsUnitedStates);
    },
  );

  test(
    'it should give the right name when the enum is given',
    () {
      // arrange
      const currencyEnum = CurrencyEnum.usd;

      // act
      final name = currencyEnum.name;

      // assert
      expect(name, 'United States Dollar');
    },
  );
}
