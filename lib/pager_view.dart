import 'package:page_controller/base_components/pager_top_view.dart';
import 'package:page_controller/base_components/pager_foreground_view.dart';
import 'package:page_controller/base_components/pager_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

part 'vertical_swipe_controller.dart';

class PagerWidget extends StatelessWidget {
  PagerWidget({super.key, required this.swipeController});

  final VerticalSwipeController swipeController;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      PagerTopView(),
      PagerView(swipeController: swipeController),
      PagerForegroundView(swipeController: swipeController),
    ]).animate().fadeIn();
  }
}
