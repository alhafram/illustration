import 'dart:math';
import 'package:page_controller/home_screen_provider.dart';
import 'package:page_controller/asset_view_model.dart';
import 'package:page_controller/components/pager_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sized_context/sized_context.dart';

class PagerPiece extends StatelessWidget {
  const PagerPiece(
      {Key? key,
      required this.fileName,
      required this.heightFactor,
      this.alignment = Alignment.center,
      this.minHeight,
      this.offset = Offset.zero,
      this.fractionalOffset,
      this.zoomAmt = 0,
      this.initialOffset = Offset.zero,
      this.initialScale = 1,
      this.dynamicHzOffset = 0})
      : super(key: key);

  factory PagerPiece.withViewModel({required AssetViewModel viewModel}) {
    return PagerPiece(
        fileName: viewModel.fileName,
        heightFactor: viewModel.heightFactor,
        alignment: viewModel.alignment,
        minHeight: viewModel.minHeight,
        offset: viewModel.offset,
        fractionalOffset: viewModel.fractionalOffset,
        zoomAmt: viewModel.zoomAmt,
        initialOffset: viewModel.initialOffset,
        initialScale: viewModel.initialScale,
        dynamicHzOffset: viewModel.dynamicHzOffset);
  }

  final String fileName;

  final Alignment alignment;

  /// Will animate from this position to Offset.zero, eg is value is Offset(0, 100), the piece will slide up vertically 100px as it enters the screen
  final Offset initialOffset;

  /// Will animate from this scale to 1, eg if scale is .7, the piece will scale from .7 to 1.0 as it enters the screen.
  final double initialScale;

  /// % height, will be overridden by minHeight
  final double heightFactor;

  /// min height in pixels, piece will not be allowed to go below this height in px, unless it has to (available height is too small)
  final double? minHeight;

  /// px offset for this piece
  final Offset offset;

  /// offset based on a fraction of the piece size
  final Offset? fractionalOffset;

  /// The % amount that this object should scale up as the user drags their finger up the screen
  final double zoomAmt;

  /// Max px offset of the piece as the screen size grows horizontally
  final double dynamicHzOffset;

  @override
  Widget build(BuildContext context) {
    final builder = context.watch<PagerBuilderState>();
    final ipProvider = context.read<PagePieceProvider>();
    final imgPath = fileName;
    // Dynamically determine the aspect ratio of the image, so we can more easily position it
    if (ipProvider.aspectRatio == null) {
      ipProvider.aspectRatio =
          0; // indicates load has started, so we don't run twice
      ipProvider.load(fileName);
    }
    return Align(
        alignment: alignment,
        child: LayoutBuilder(
            key: ValueKey(ipProvider.aspectRatio),
            builder: (_, constraints) {
              final anim = builder.anim;
              final curvedAnim = Curves.easeOut.transform(anim.value);
              final config = builder.widget.config;
              Widget img = Image.asset(imgPath,
                  package: 'page_controller',
                  opacity: anim,
                  fit: BoxFit.fitHeight);
              // Add overflow box so image doesn't get clipped as we translate it around
              img = OverflowBox(maxWidth: 2500, child: img);

              final double introZoom = (initialScale - 1) * (1 - curvedAnim);

              /// Determine target height
              final double height =
                  max(minHeight ?? 0, constraints.maxHeight * heightFactor);

              /// Combine all the translations, initial + offset + dynamicHzOffset + fractionalOffset
              Offset finalTranslation = offset;
              // Initial
              if (initialOffset != Offset.zero) {
                finalTranslation += initialOffset * (1 - curvedAnim);
              }
              // Dynamic
              final dynamicOffsetAmt =
                  ((context.widthPx - 400) / 1100).clamp(0, 1);
              finalTranslation += Offset(dynamicOffsetAmt * dynamicHzOffset, 0);
              // Fractional
              final width = height * (ipProvider.aspectRatio ?? 0);
              if (fractionalOffset != null) {
                finalTranslation += Offset(fractionalOffset!.dx * width,
                    height * fractionalOffset!.dy);
              }
              Widget? content;
              if (ipProvider.uiImage != null) {
                content = Transform.translate(
                    offset: finalTranslation,
                    child: Transform.scale(
                        scale: 1 + (zoomAmt * config.zoom) + introZoom,
                        child: SizedBox(
                            height: height,
                            width: height * ipProvider.aspectRatio!,
                            child: img)));
              }

              return Stack(children: [
                if (ipProvider.uiImage != null) ...[content!]
              ]);
            }));
  }
}
