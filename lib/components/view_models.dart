import 'package:flutter/material.dart';

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

class PageViewModel {
  final int id;
  final Type pageType;
  final Color bgColor;
  final int cloudSeed;

  final Color color;
  final PagePieceViewModel textureViewModel;
  final PagePieceViewModel backgroundViewModel;

  final Offset? offset; // Translate

  final Clip? clipBehavior; // ClipRect

  final double? heightFactor; // FractionallySizedBox
  final Alignment? alignment;

  final PagePieceViewModel middlegroundViewModel;

  final List<PagePieceViewModel> foregroundViewModels;

  PageViewModel(
      {required this.id,
      required this.pageType,
      required this.bgColor,
      required this.cloudSeed,
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

enum Type {
  fallAsleep,
  feelBetter,
  reduceStress,
  calmDown,
  feelRelaxed,
  beCreative,
  anotherType
}
