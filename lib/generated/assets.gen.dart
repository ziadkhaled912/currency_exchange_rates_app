/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class Assets {
  Assets._();

  /// File path: assets/flags/australia.png
  static const AssetGenImage flagsAustralia =
      AssetGenImage('assets/flags/australia.png');

  /// File path: assets/flags/bahrain.png
  static const AssetGenImage flagsBahrain =
      AssetGenImage('assets/flags/bahrain.png');

  /// File path: assets/flags/british.png
  static const AssetGenImage flagsBritish =
      AssetGenImage('assets/flags/british.png');

  /// File path: assets/flags/canada.png
  static const AssetGenImage flagsCanada =
      AssetGenImage('assets/flags/canada.png');

  /// File path: assets/flags/china.png
  static const AssetGenImage flagsChina =
      AssetGenImage('assets/flags/china.png');

  /// File path: assets/flags/european-union.png
  static const AssetGenImage flagsEuropeanUnion =
      AssetGenImage('assets/flags/european-union.png');

  /// File path: assets/flags/jordan.png
  static const AssetGenImage flagsJordan =
      AssetGenImage('assets/flags/jordan.png');

  /// File path: assets/flags/kuwait.png
  static const AssetGenImage flagsKuwait =
      AssetGenImage('assets/flags/kuwait.png');

  /// File path: assets/flags/libya.png
  static const AssetGenImage flagsLibya =
      AssetGenImage('assets/flags/libya.png');

  /// File path: assets/flags/oman.png
  static const AssetGenImage flagsOman = AssetGenImage('assets/flags/oman.png');

  /// File path: assets/flags/qatar.png
  static const AssetGenImage flagsQatar =
      AssetGenImage('assets/flags/qatar.png');

  /// File path: assets/flags/saudi-arabia.png
  static const AssetGenImage flagsSaudiArabia =
      AssetGenImage('assets/flags/saudi-arabia.png');

  /// File path: assets/flags/united-arab-emirates.png
  static const AssetGenImage flagsUnitedArabEmirates =
      AssetGenImage('assets/flags/united-arab-emirates.png');

  /// File path: assets/flags/united-states.png
  static const AssetGenImage flagsUnitedStates =
      AssetGenImage('assets/flags/united-states.png');

  /// File path: assets/fonts/Inter-Bold.ttf
  static const String fontsInterBold = 'assets/fonts/Inter-Bold.ttf';

  /// File path: assets/fonts/Inter-Medium.ttf
  static const String fontsInterMedium = 'assets/fonts/Inter-Medium.ttf';

  /// File path: assets/fonts/Inter-Regular.ttf
  static const String fontsInterRegular = 'assets/fonts/Inter-Regular.ttf';

  /// File path: assets/images/icons/close.svg
  static const SvgGenImage imagesIconsClose =
      SvgGenImage('assets/images/icons/close.svg');

  /// File path: assets/images/icons/facebook.svg
  static const SvgGenImage imagesIconsFacebook =
      SvgGenImage('assets/images/icons/facebook.svg');

  /// File path: assets/images/icons/file_icon.svg
  static const SvgGenImage imagesIconsFileIcon =
      SvgGenImage('assets/images/icons/file_icon.svg');

  /// File path: assets/images/icons/gold.png
  static const AssetGenImage imagesIconsGold =
      AssetGenImage('assets/images/icons/gold.png');

  /// File path: assets/images/icons/icon.svg
  static const SvgGenImage imagesIconsIcon =
      SvgGenImage('assets/images/icons/icon.svg');

  /// File path: assets/images/icons/instagram.svg
  static const SvgGenImage imagesIconsInstagram =
      SvgGenImage('assets/images/icons/instagram.svg');

  /// File path: assets/images/icons/linkedin.svg
  static const SvgGenImage imagesIconsLinkedin =
      SvgGenImage('assets/images/icons/linkedin.svg');

  /// File path: assets/images/icons/translate.svg
  static const SvgGenImage imagesIconsTranslate =
      SvgGenImage('assets/images/icons/translate.svg');

  /// File path: assets/images/icons/twitter.svg
  static const SvgGenImage imagesIconsTwitter =
      SvgGenImage('assets/images/icons/twitter.svg');

  /// File path: assets/images/icons/youtube.svg
  static const SvgGenImage imagesIconsYoutube =
      SvgGenImage('assets/images/icons/youtube.svg');

  /// File path: assets/images/no_wifi.png
  static const AssetGenImage imagesNoWifi =
      AssetGenImage('assets/images/no_wifi.png');

  /// File path: assets/images/sucess.png
  static const AssetGenImage imagesSucess =
      AssetGenImage('assets/images/sucess.png');

  /// File path: assets/images/warning.svg
  static const SvgGenImage imagesWarning =
      SvgGenImage('assets/images/warning.svg');

  /// List of all assets
  static List<dynamic> get values => [
        flagsAustralia,
        flagsBahrain,
        flagsBritish,
        flagsCanada,
        flagsChina,
        flagsEuropeanUnion,
        flagsJordan,
        flagsKuwait,
        flagsLibya,
        flagsOman,
        flagsQatar,
        flagsSaudiArabia,
        flagsUnitedArabEmirates,
        flagsUnitedStates,
        fontsInterBold,
        fontsInterMedium,
        fontsInterRegular,
        imagesIconsClose,
        imagesIconsFacebook,
        imagesIconsFileIcon,
        imagesIconsGold,
        imagesIconsIcon,
        imagesIconsInstagram,
        imagesIconsLinkedin,
        imagesIconsTranslate,
        imagesIconsTwitter,
        imagesIconsYoutube,
        imagesNoWifi,
        imagesSucess,
        imagesWarning
      ];
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme theme = const SvgTheme(),
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      theme: theme,
      colorFilter: colorFilter,
      color: color,
      colorBlendMode: colorBlendMode,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
