import 'package:flutter/material.dart';
import 'package:illustration/home_screen_provider.dart';
import 'package:illustration/illustrations/base_illustration.dart';
import 'package:illustration/illustrations/illustration_config.dart';
import 'package:provider/provider.dart';

class IllustrationPageView extends StatelessWidget {
  const IllustrationPageView({super.key});

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
              final config =
                  IllustrationConfig.mg(isShowing: isShowing, zoom: .05);
              return BaseIllustration(
                  illustrationViewModel: viewModel, config: config);
            }));
  }
}
