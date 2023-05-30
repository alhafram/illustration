import 'package:page_controller/components/view_models.dart';
import 'package:flutter/material.dart';

class PagerTexture extends StatelessWidget {
  const PagerTexture(this.path,
      {Key? key,
      this.scale = 1,
      this.color,
      this.flipX = false,
      this.flipY = false,
      this.opacity})
      : super(key: key);
  final Color? color;
  final double scale;
  final bool flipX;
  final bool flipY;
  final String path;
  final Animation<double>? opacity;

  factory PagerTexture.withViewModel(
      {required PageTextureViewModel viewModel,
      required Animation<double> opacity}) {
    return PagerTexture(viewModel.path,
        scale: viewModel.scale,
        color: viewModel.color,
        flipX: viewModel.flipX,
        flipY: viewModel.flipY,
        opacity: opacity);
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
      animation: opacity ?? const AlwaysStoppedAnimation(1),
      builder: (context, child) => ClipRect(
          child: Transform.scale(
              scaleX: scale * (flipX ? -1 : 1),
              scaleY: scale * (flipY ? -1 : 1),
              child: Image.asset(path,
                  repeat: ImageRepeat.repeat,
                  package: 'page_controller',
                  fit: BoxFit.contain,
                  alignment: Alignment.topCenter,
                  color: color,
                  opacity: opacity,
                  cacheWidth: 2048))));
}
