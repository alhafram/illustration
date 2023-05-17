import 'package:illustration/base_components/bottom_center.dart';
import 'package:flutter/material.dart';
import 'package:illustration/home_screen.dart';
import 'package:illustration/home_screen_provider.dart';
import 'package:illustration/illustrations/base_illustration.dart';
import 'package:illustration/illustrations/illustration_config.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

class IllustrationForegroundsView extends StatelessWidget {
  IllustrationForegroundsView({super.key, required this.swipeController});

  final VerticalSwipeController swipeController;

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<HomeScreenProvider>();
    Widget buildSwipeableBgGradient(Color fgColor) {
      return swipeController.buildListener(
          builder: (swipeAmt, isPointerDown, _) {
        return IgnorePointer(
            child: FractionallySizedBox(
                heightFactor: .6,
                child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    fgColor.withOpacity(0),
                    fgColor.withOpacity(.5 +
                        fgColor.opacity * .25 +
                        (isPointerDown ? .05 : 0) +
                        swipeAmt * .20)
                  ],
                  stops: const [0, 1],
                )))));
      });
    }

    Color gradientColor = provider.selectedViewModel.bgColor;
    return Stack(children: [
      BottomCenter(
          child: buildSwipeableBgGradient(gradientColor.withOpacity(.65))),
      ...provider.viewModels.map((e) {
        return swipeController.buildListener(builder: (swipeAmt, _, child) {
          final config = IllustrationConfig.fg(
            isShowing: provider.isSelected(e.id),
            // zoom: .4 * (_swipeOverride ?? swipeAmt),
            zoom: .4 * swipeAmt,
          );
          return Animate(
              effects: const [FadeEffect()],
              onPlay: _handleFadeAnimInit,
              child: IgnorePointer(
                  child: BaseIllustration(
                      illustrationViewModel: provider.viewModels[e.id],
                      config: config)));
        });
      }).toList(),
      // ...provider.viewModels.map((e) {
      //   final config = IllustrationConfig.fg(
      //       isShowing: provider.isSelected(e.id), zoom: .4);
      //   return Animate(
      //       effects: const [FadeEffect()],
      //       child: IgnorePointer(
      //           child: BaseIllustration(
      //               illustrationViewModel: provider.viewModels[e.id],
      //               config: config)));
      // }).toList(),
      BottomCenter(child: buildSwipeableBgGradient(gradientColor))
    ]);
  }

  final _fadeAnims = <AnimationController>[];

  void _handleFadeAnimInit(AnimationController controller) {
    _fadeAnims.add(controller);
    controller.value = 1;
  }
}
