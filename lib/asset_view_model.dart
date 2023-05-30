import 'package:flutter/material.dart';

class AssetViewModel {
  final String fileName;

  final Alignment alignment;
  final Offset initialOffset;
  final double initialScale;
  final double heightFactor;
  final Offset? fractionalOffset;
  final double zoomAmt;
  final double dynamicHzOffset;
  final double? minHeight;
  final Offset offset;

  final Color? color;
  final bool flipX;
  final bool flipY;
  Tween<double> tween;

  AssetViewModel(
      {required this.fileName,
      this.heightFactor = 0.0,
      this.alignment = Alignment.center,
      this.minHeight,
      this.offset = Offset.zero,
      this.fractionalOffset,
      this.zoomAmt = 0,
      this.initialOffset = Offset.zero,
      this.initialScale = 1,
      this.dynamicHzOffset = 0,
      this.color,
      this.flipX = false,
      this.flipY = false,
      Tween<double>? tween})
      : tween = tween ?? Tween(begin: 0, end: 1);
}

class PageViewModel {
  final int id;
  final PageType pageType;
  final Color bgColor;
  final int animatedAssetSeed;

  final Color color;
  final AssetViewModel textureViewModel;
  final AssetViewModel backgroundViewModel;

  final Offset? offset; // Translate

  final Clip? clipBehavior; // ClipRect

  final double? heightFactor; // FractionallySizedBox
  final Alignment? alignment;

  final AssetViewModel middlegroundViewModel;

  final List<AssetViewModel> foregroundViewModels;

  PageViewModel(
      {required this.id,
      required this.pageType,
      required this.bgColor,
      required this.animatedAssetSeed,
      this.color = Colors.black,
      required this.textureViewModel,
      required this.backgroundViewModel,
      this.offset,
      this.clipBehavior,
      this.heightFactor,
      this.alignment,
      required this.middlegroundViewModel,
      required this.foregroundViewModels});
}

enum PageType {
  fallAsleep,
  feelBetter,
  reduceStress,
  calmDown,
  feelRelaxed,
  beCreative,
  anotherType
}
