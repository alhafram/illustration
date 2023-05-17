import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Scaffold(body: Center(child: Text('Some details'))),
        onVerticalDragUpdate: (details) {
          int sensitivity = 8;
          if (details.delta.dy > sensitivity) {
            context.pop();
          }
        });
  }
}
