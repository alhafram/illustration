import 'package:flutter/material.dart';

class PageBackgroundViewModel {
  final Color color;

  final PagePieceViewModel textureViewModel;
  final PagePieceViewModel pagePieceViewModel;

  PageBackgroundViewModel(
      {required this.color,
      required this.textureViewModel,
      required this.pagePieceViewModel});
}

class PageMiddlegroundViewModel {
  // Move params to common VM
  final Offset? offset; // Translate

  final Clip? clipBehavior; // ClipRect

  final double? heightFactor; // FractionallySizedBox
  final Alignment? alignment;

  final PagePieceViewModel pagePieceViewModel;

  PageMiddlegroundViewModel(
      {this.offset,
      this.clipBehavior,
      this.heightFactor,
      this.alignment,
      required this.pagePieceViewModel});
}

class PagePieceViewModel {
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

  PagePieceViewModel(
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

class PageForegroundViewModel {
  final List<PagePieceViewModel> viewModels;

  PageForegroundViewModel({required this.viewModels});
}

class PageViewModel {
  final int id;
  final Type pageType;
  final Color bgColor;
  final int cloudSeed;
  final PageBackgroundViewModel backgroundViewModel;
  final PageMiddlegroundViewModel middlegroundViewModel;
  final PageForegroundViewModel pageForegroundViewModel;

  PageViewModel(
      {required this.id,
      required this.pageType,
      required this.bgColor,
      required this.cloudSeed,
      required this.backgroundViewModel,
      required this.middlegroundViewModel,
      required this.pageForegroundViewModel});
}

enum Type {
  fallAsleep,
  feelBetter,
  reduceStress,
  calmDown,
  feelRelaxed,
  beCreative,
  anotherType
}
