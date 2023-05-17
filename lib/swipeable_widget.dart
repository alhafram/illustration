import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:illustration/home_screen.dart';

class SwipeableWidget extends StatefulWidget {
  SwipeableWidget({Key? key}) : super(key: key);

  @override
  State<SwipeableWidget> createState() => SwipeableWidgetState();
}

class SwipeableWidgetState extends State<SwipeableWidget>
    with SingleTickerProviderStateMixin {
  late final VerticalSwipeController _swipeController =
      VerticalSwipeController(this, _showDetailsPage);

  void _showDetailsPage() async {
    context.push('/details');
    await Future.delayed(100.ms);
  }

  @override
  Widget build(BuildContext context) {
    return _swipeController
        .wrapGestureDetector(HomeScreen(swipeController: _swipeController));
  }
}
