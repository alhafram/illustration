import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:illustration/home_screen.dart';

class HomeScreenSwipeableWidget extends StatefulWidget {
  HomeScreenSwipeableWidget({Key? key}) : super(key: key);

  @override
  State<HomeScreenSwipeableWidget> createState() =>
      HomeScreenSwipeableWidgetState();
}

class HomeScreenSwipeableWidgetState extends State<HomeScreenSwipeableWidget>
    with SingleTickerProviderStateMixin {
  late final VerticalSwipeController _swipeController =
      VerticalSwipeController(this, _showDetailsPage);

  void _showDetailsPage() {
    context.push('/details');
  }

  @override
  Widget build(BuildContext context) {
    return _swipeController
        .wrapGestureDetector(HomeScreen(swipeController: _swipeController));
  }
}
