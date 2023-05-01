import 'dart:async';
import 'package:illustration/assets.dart';
import 'package:illustration/illustrations/context_utils.dart';
import 'package:flutter/material.dart';
import 'package:rnd/rnd.dart';
import 'package:sized_context/sized_context.dart';
export 'package:rnd/rnd.dart';

class AnimatedClouds extends StatefulWidget {
  const AnimatedClouds(
      {Key? key,
      this.enableAnimations = true,
      required this.opacity,
      required this.cloudSeed,
      this.cloudSize = 500})
      : super(key: key);
  final bool enableAnimations;
  final double opacity;
  final int cloudSeed;
  final double cloudSize;
  @override
  State<AnimatedClouds> createState() => _AnimatedCloudsState();
}

class _AnimatedCloudsState extends State<AnimatedClouds>
    with SingleTickerProviderStateMixin {
  late List<_Cloud> _clouds = [];
  List<_Cloud> _oldClouds = [];
  late final AnimationController _anim = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1500));

  @override
  void initState() {
    super.initState();
    scheduleMicrotask(() {
      setState(() => _clouds = _getClouds());
    });
    _showClouds();
  }

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant AnimatedClouds oldWidget) {
    if (oldWidget.hashCode != widget.hashCode) {
      _oldClouds = _clouds;
      _clouds = _getClouds();
      _showClouds();
    }
    super.didUpdateWidget(oldWidget);
  }

  void _showClouds() {
    widget.enableAnimations ? _anim.forward(from: 0) : _anim.value = 1;
  }

  @override
  Widget build(BuildContext context) {
    Widget buildCloud(_Cloud c,
        {required bool isOld, required int startOffset}) {
      final stOffset = _clouds.indexOf(c) % 2 == 0 ? -startOffset : startOffset;
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
                              ..._oldClouds.map((c) =>
                                  buildCloud(c, isOld: true, startOffset: 1000))
                            ],
                            ..._clouds.map((c) =>
                                buildCloud(c, isOld: false, startOffset: 1000))
                          ]);
                    }))));
  }

  List<_Cloud> _getClouds() {
    Size size = ContextUtils.getSize(context) ?? Size(context.widthPx, 400);
    rndSeed = widget.cloudSeed;
    return List<_Cloud>.generate(3, (index) {
      return _Cloud(
          Offset(rnd.getDouble(-200, size.width - 100),
              rnd.getDouble(50, size.height - 50)),
          scale: rnd.getDouble(.7, 1),
          flipX: rnd.getBool(),
          flipY: rnd.getBool(),
          opacity: widget.opacity,
          size: widget.cloudSize);
    }).toList();
  }
}

class _Cloud extends StatelessWidget {
  const _Cloud(this.pos,
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
      child: Image.asset(ImagePaths.cloud,
          package: 'illustration',
          opacity: AlwaysStoppedAnimation(.4 * opacity),
          width: size * scale,
          fit: BoxFit.fitWidth));
}
