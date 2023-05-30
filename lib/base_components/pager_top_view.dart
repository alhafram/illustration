import 'package:flutter/material.dart';
import 'package:page_controller/components/animated_assets.dart';
import 'package:page_controller/components/base_page_view.dart';
import 'package:page_controller/components/page_config.dart';
import 'package:page_controller/home_screen_provider.dart';
import 'package:provider/provider.dart';

class PagerTopView extends StatelessWidget {
  const PagerTopView({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<HomeScreenProvider>();
    return Stack(children: [
      ...provider.viewModels.map((e) {
        var config = PageConfig.bg(isShowing: provider.isSelected(e.id));
        return BasePageView(
            pageViewModel: provider.viewModels[e.id], config: config);
      }).toList(),
      FractionallySizedBox(
          widthFactor: 1,
          heightFactor: .5,
          child: AnimatedAssets(
              opacity: 1, cloudSeed: provider.selectedViewModel.cloudSeed))
    ]);
  }
}
