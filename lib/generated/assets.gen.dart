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

class $AssetsAnimationsGen {
  const $AssetsAnimationsGen();

  /// File path: assets/animations/VPN_1.json
  String get vpn1 => 'assets/animations/VPN_1.json';

  /// File path: assets/animations/VPN_2.json
  String get vpn2 => 'assets/animations/VPN_2.json';

  /// File path: assets/animations/VPN_3.json
  String get vpn3 => 'assets/animations/VPN_3.json';

  /// List of all assets
  List<String> get values => [vpn1, vpn2, vpn3];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/Group 1.svg
  SvgGenImage get group1 => const SvgGenImage('assets/icons/Group 1.svg');

  /// File path: assets/icons/Home.svg
  SvgGenImage get home => const SvgGenImage('assets/icons/Home.svg');

  /// File path: assets/icons/Signal 1.svg
  SvgGenImage get signal1 => const SvgGenImage('assets/icons/Signal 1.svg');

  /// File path: assets/icons/Vector.svg
  SvgGenImage get vector => const SvgGenImage('assets/icons/Vector.svg');

  /// File path: assets/icons/add.svg
  SvgGenImage get add => const SvgGenImage('assets/icons/add.svg');

  /// File path: assets/icons/burrow_001.svg
  SvgGenImage get burrow001 => const SvgGenImage('assets/icons/burrow_001.svg');

  /// File path: assets/icons/incognito.svg
  SvgGenImage get incognito => const SvgGenImage('assets/icons/incognito.svg');

  /// File path: assets/icons/line.svg
  SvgGenImage get line => const SvgGenImage('assets/icons/line.svg');

  /// File path: assets/icons/premium.svg
  SvgGenImage get premium => const SvgGenImage('assets/icons/premium.svg');

  /// File path: assets/icons/pro.svg
  SvgGenImage get pro => const SvgGenImage('assets/icons/pro.svg');

  /// File path: assets/icons/pro_yelov.svg
  SvgGenImage get proYelov => const SvgGenImage('assets/icons/pro_yelov.svg');

  /// File path: assets/icons/profile.svg
  SvgGenImage get profile => const SvgGenImage('assets/icons/profile.svg');

  /// File path: assets/icons/rocket.svg
  SvgGenImage get rocket => const SvgGenImage('assets/icons/rocket.svg');

  /// File path: assets/icons/settings.svg
  SvgGenImage get settings => const SvgGenImage('assets/icons/settings.svg');

  /// File path: assets/icons/shield-check.svg
  SvgGenImage get shieldCheck =>
      const SvgGenImage('assets/icons/shield-check.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
        group1,
        home,
        signal1,
        vector,
        add,
        burrow001,
        incognito,
        line,
        premium,
        pro,
        proYelov,
        profile,
        rocket,
        settings,
        shieldCheck
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/Group 1371.png
  AssetGenImage get group1371 =>
      const AssetGenImage('assets/images/Group 1371.png');

  /// File path: assets/images/map.png
  AssetGenImage get map => const AssetGenImage('assets/images/map.png');

  /// File path: assets/images/world map.png
  AssetGenImage get worldMap =>
      const AssetGenImage('assets/images/world map.png');

  /// List of all assets
  List<AssetGenImage> get values => [group1371, map, worldMap];
}

class $AssetsWebpagesGen {
  const $AssetsWebpagesGen();

  /// File path: assets/webpages/index.html
  String get index => 'assets/webpages/index.html';

  /// List of all assets
  List<String> get values => [index];
}

class Assets {
  Assets._();

  static const $AssetsAnimationsGen animations = $AssetsAnimationsGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsWebpagesGen webpages = $AssetsWebpagesGen();
  static const String worldMap = 'assets/world_map.json';

  /// List of all assets
  List<String> get values => [worldMap];
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
