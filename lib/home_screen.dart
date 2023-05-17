import 'package:illustration/base_components/illustration_clouds_view.dart';
import 'package:illustration/base_components/illustration_foregrounds_view.dart';
import 'package:illustration/base_components/illustration_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

part 'vertical_swipe_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key, required this.swipeController});

  final VerticalSwipeController swipeController;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      IllustrationCloudsView(),
      IllustrationPageView(swipeController: swipeController),
      IllustrationForegroundsView(swipeController: swipeController),
    ]).animate().fadeIn();
  }
}
