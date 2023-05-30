import 'package:flutter/material.dart';
import 'package:page_controller/pager_view.dart';
import 'package:page_controller/home_screen_provider.dart';
import 'package:provider/provider.dart';

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
    var provider = context.read<HomeScreenProvider>();
    provider.openDetails();
  }

  @override
  Widget build(BuildContext context) {
    return _swipeController
        .wrapGestureDetector(PagerWidget(swipeController: _swipeController));
  }
}
