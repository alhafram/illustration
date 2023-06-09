import 'package:page_controller/components/page_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PagerBuilder extends StatefulWidget {
  const PagerBuilder({
    Key? key,
    required this.config,
    required this.fgBuilder,
    required this.mgBuilder,
    required this.bgBuilder,
  }) : super(key: key);
  final List<Widget> Function(BuildContext context, Animation<double> animation)
      fgBuilder;
  final List<Widget> Function(BuildContext context, Animation<double> animation)
      mgBuilder;
  final List<Widget> Function(BuildContext context, Animation<double> animation)
      bgBuilder;
  final PageConfig config;

  @override
  State<PagerBuilder> createState() => PagerBuilderState();
}

class PagerBuilderState extends State<PagerBuilder>
    with SingleTickerProviderStateMixin {
  late final anim = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 600) * .75)
    ..addListener(() => setState(() {}));

  bool get isShowing => widget.config.isShowing;
  @override
  void initState() {
    super.initState();
    if (isShowing) anim.forward(from: 0);
  }

  @override
  void dispose() {
    anim.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant PagerBuilder oldWidget) {
    if (isShowing != oldWidget.config.isShowing) {
      isShowing ? anim.forward(from: 0) : anim.reverse(from: 1);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (anim.value == 0 && widget.config.enableAnims) {
      return const SizedBox.expand();
    }
    Animation<double> animation =
        widget.config.enableAnims ? anim : const AlwaysStoppedAnimation(1);

    return Provider<PagerBuilderState>.value(
        value: this,
        child: Stack(key: ValueKey(animation.value == 0), children: [
          if (widget.config.enableBg) ...widget.bgBuilder(context, animation),
          if (widget.config.enableMg) ...widget.mgBuilder(context, animation),
          if (widget.config.enableFg) ...widget.fgBuilder(context, animation)
        ]));
  }
}
