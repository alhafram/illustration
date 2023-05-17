import 'package:flutter/material.dart';
import 'package:illustration/home_screen_provider.dart';
import 'package:illustration/illustrations/base_illustration.dart';
import 'package:illustration/illustrations/illustration_config.dart';
import 'package:provider/provider.dart';

import '../home_screen.dart';

class IllustrationPageView extends StatelessWidget {
  const IllustrationPageView({super.key, required this.swipeController});

  final VerticalSwipeController swipeController;

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<HomeScreenProvider>();
    return ExcludeSemantics(
        child: PageView.builder(
            controller: PageController(
                viewportFraction: 1, initialPage: provider.count * 9999),
            onPageChanged: (value) => provider.changeCurrentId(value),
            itemBuilder: (_, index) {
              final viewModel = provider.viewModels[index % provider.count];
              bool isShowing = provider.isSelected(viewModel.id);
              return swipeController.buildListener(
                builder: (swipeAmt, _, child) {
                  final config = IllustrationConfig.mg(
                    isShowing: isShowing,
                    zoom: .05 * swipeAmt,
                  );
                  return BaseIllustration(
                      illustrationViewModel: viewModel, config: config);
                },
              );
              // final config =
              //     IllustrationConfig.mg(isShowing: isShowing, zoom: .05);
              // return BaseIllustration(
              //     illustrationViewModel: viewModel, config: config);
            }));
  }
}
