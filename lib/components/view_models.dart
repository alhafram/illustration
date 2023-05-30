import 'package:flutter/material.dart';

class PageBackgroundViewModel {
  final Color color;

  final PageTextureViewModel textureViewModel;
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

  PagePieceViewModel(
      {required this.fileName,
      required this.heightFactor,
      this.alignment = Alignment.center,
      this.minHeight,
      this.offset = Offset.zero,
      this.fractionalOffset,
      this.zoomAmt = 0,
      this.initialOffset = Offset.zero,
      this.initialScale = 1,
      this.dynamicHzOffset = 0});
}

class PageForegroundViewModel {
  final List<PagePieceViewModel> viewModels;

  PageForegroundViewModel({required this.viewModels});
}

class PageTextureViewModel {
  final Color? color;
  final double scale;
  final bool flipX;
  final bool flipY;
  final String path;
  final Tween<double> tween;

  PageTextureViewModel(this.path,
      {this.scale = 1,
      this.color,
      this.flipX = false,
      this.flipY = false,
      required this.tween});
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
