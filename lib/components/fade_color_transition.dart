import 'package:flutter/material.dart';

class FadeColorTransition extends StatelessWidget {
  const FadeColorTransition(
      {Key? key, required this.animation, required this.color})
      : super(key: key);
  final Animation<double> animation;
  final Color color;

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
      animation: animation,
      builder: (_, __) => Container(color: color.withOpacity(animation.value)));
}
