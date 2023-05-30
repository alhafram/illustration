import 'dart:async';
import 'package:page_controller/components/context_utils.dart';
import 'package:flutter/material.dart';
import 'package:page_controller/image_paths.dart';
import 'package:rnd/rnd.dart';
import 'package:sized_context/sized_context.dart';
export 'package:rnd/rnd.dart';

class AnimatedAssets extends StatefulWidget {
  const AnimatedAssets(
      {Key? key,
      this.enableAnimations = true,
      required this.opacity,
      required this.animatedAssetSeed,
      this.animatedAssetSize = 500})
      : super(key: key);
  final bool enableAnimations;
  final double opacity;
  final int animatedAssetSeed;
  final double animatedAssetSize;
  @override
  State<AnimatedAssets> createState() => AnimatedAssetsState();
}

class AnimatedAssetsState extends State<AnimatedAssets>
    with SingleTickerProviderStateMixin {
  late List<AnimatedAsset> _animatedAssets = [];
  List<AnimatedAsset> _oldAnimatedAssets = [];
  late final AnimationController _anim = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1500));

  @override
  void initState() {
    super.initState();
    scheduleMicrotask(() {
      setState(() => _animatedAssets = _getAnimatedAssets());
    });
    _showAnimatedAssets();
  }

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant AnimatedAssets oldWidget) {
    if (oldWidget.hashCode != widget.hashCode) {
      _oldAnimatedAssets = _animatedAssets;
      _animatedAssets = _getAnimatedAssets();
      _showAnimatedAssets();
    }
    super.didUpdateWidget(oldWidget);
  }

  void _showAnimatedAssets() {
    widget.enableAnimations ? _anim.forward(from: 0) : _anim.value = 1;
  }

  @override
  Widget build(BuildContext context) {
    Widget buildAnimatedAsset(AnimatedAsset c,
        {required bool isOld, required int startOffset}) {
      final stOffset =
          _animatedAssets.indexOf(c) % 2 == 0 ? -startOffset : startOffset;
      double curvedValue = Curves.easeOut.transform(_anim.value);
      return Positioned(
          top: c.pos.dy,
          left: isOld
              ? c.pos.dx - stOffset * curvedValue
              : c.pos.dx + stOffset * (1 - curvedValue),
          child: Opacity(
              opacity: isOld ? 1 - _anim.value : _anim.value, child: c));
    }

    return RepaintBoundary(
        child: ClipRect(
            child: OverflowBox(
                child: AnimatedBuilder(
                    animation: _anim,
                    builder: (_, __) {
                      return Stack(
                          clipBehavior: Clip.hardEdge,
                          key: ValueKey(widget.hashCode),
                          children: [
                            if (_anim.value != 1) ...[
                              ..._oldAnimatedAssets.map((c) =>
                                  buildAnimatedAsset(c,
                                      isOld: true, startOffset: 1000))
                            ],
                            ..._animatedAssets.map((c) => buildAnimatedAsset(c,
                                isOld: false, startOffset: 1000))
                          ]);
                    }))));
  }

  List<AnimatedAsset> _getAnimatedAssets() {
    Size size = ContextUtils.getSize(context) ?? Size(context.widthPx, 400);
    rndSeed = widget.animatedAssetSeed;
    return List<AnimatedAsset>.generate(3, (index) {
      return AnimatedAsset(
          Offset(rnd.getDouble(-200, size.width - 100),
              rnd.getDouble(50, size.height - 50)),
          scale: rnd.getDouble(.7, 1),
          flipX: rnd.getBool(),
          flipY: rnd.getBool(),
          opacity: widget.opacity,
          size: widget.animatedAssetSize);
    }).toList();
  }
}

class AnimatedAsset extends StatelessWidget {
  const AnimatedAsset(this.pos,
      {this.scale = 1,
      this.flipX = false,
      this.flipY = false,
      required this.opacity,
      required this.size});

  final Offset pos;
  final double scale;
  final bool flipX;
  final bool flipY;
  final double opacity;
  final double size;

  @override
  Widget build(BuildContext context) => Transform.scale(
      scaleX: scale * (flipX ? -1 : 1),
      scaleY: scale * (flipY ? -1 : 1),
      child: Image.asset(ImagePaths.animatedAsset,
          package: 'page_controller',
          opacity: AlwaysStoppedAnimation(.4 * opacity),
          width: size * scale,
          fit: BoxFit.fitWidth));
}
