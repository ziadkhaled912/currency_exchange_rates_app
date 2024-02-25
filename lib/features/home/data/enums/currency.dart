import 'package:currency_exchange/generated/assets.dart';

enum CurrencyEnum {
  egp('EGP'),
  usd('USD'),
  eur('EUR'),
  sar('SAR'),
  aed('AED'),
  qar('QAR'),
  kwd('KWD'),
  jod('JOD'),
  omr('OMR'),
  bhd('BHD'),
  lyd('LYD'),
  aud('AUD'),
  gbp('GBP'),
  cad('CAD'),
  cny('CNY');

  const CurrencyEnum(this.code);

  final String code;

  String get icon {
    switch (this) {
      case CurrencyEnum.egp:
      return '';
      case CurrencyEnum.usd:
      return Assets.flagsUnitedStates;
      case CurrencyEnum.eur:
        return Assets.flagsEuropeanUnion;
      case CurrencyEnum.sar:
        return Assets.flagsSaudiArabia;
      case CurrencyEnum.aed:
        return Assets.flagsUnitedArabEmirates;
      case CurrencyEnum.qar:
        return Assets.flagsQatar;
      case CurrencyEnum.kwd:
        return Assets.flagsKuwait;
      case CurrencyEnum.jod:
        return Assets.flagsJordan;
      case CurrencyEnum.omr:
        return Assets.flagsOman;
      case CurrencyEnum.bhd:
        return Assets.flagsBahrain;
      case CurrencyEnum.lyd:
        return Assets.flagsLibya;
      case CurrencyEnum.aud:
        return Assets.flagsAustralia;
      case CurrencyEnum.gbp:
        return Assets.flagsBritish;
      case CurrencyEnum.cad:
        return Assets.flagsCanada;
      case CurrencyEnum.cny:
        return Assets.flagsChina;
    }
  }

  String get name {
    switch (this) {
      case CurrencyEnum.egp:
        return '';
      case CurrencyEnum.usd:
        return 'United States Dollar';
      case CurrencyEnum.eur:
        return 'Euro';
      case CurrencyEnum.sar:
        return 'Saudi Riyal';
      case CurrencyEnum.aed:
        return 'Emirates Dirham';
      case CurrencyEnum.qar:
        return 'Qatari Riyal';
      case CurrencyEnum.kwd:
        return 'Kuwaiti Dinar';
      case CurrencyEnum.jod:
        return 'Jordanian Dinar';
      case CurrencyEnum.omr:
        return 'Omani Riyal';
      case CurrencyEnum.bhd:
        return 'Bahranini Dinar';
      case CurrencyEnum.lyd:
        return 'Libyan Dinar';
      case CurrencyEnum.aud:
        return 'Australian Dollar';
      case CurrencyEnum.gbp:
        return 'British Pound';
      case CurrencyEnum.cad:
        return 'Canadian Dollar';
      case CurrencyEnum.cny:
        return 'Chinese yuan';
    }
  }
}
