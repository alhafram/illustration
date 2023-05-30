import 'package:flutter/material.dart';
import 'package:page_controller/home_screen_provider.dart';
import 'package:page_controller/components/base_page_view.dart';
import 'package:page_controller/components/page_config.dart';
import 'package:page_controller/pager_view.dart';
import 'package:provider/provider.dart';

class PagerView extends StatelessWidget {
  const PagerView({super.key, required this.swipeController});

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
                final config =
                    PageConfig.mg(isShowing: isShowing, zoom: .05 * swipeAmt);
                return BasePageView(pageViewModel: viewModel, config: config);
              });
            }));
  }
}
