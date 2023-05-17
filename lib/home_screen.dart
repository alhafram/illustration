import 'package:illustration/base_components/illustration_clouds_view.dart';
import 'package:illustration/base_components/illustration_foregrounds_view.dart';
import 'package:illustration/base_components/illustration_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(children: [
      IllustrationCloudsView(),
      IllustrationPageView(),
      IllustrationForegroundsView()
    ]).animate().fadeIn();
  }
}
