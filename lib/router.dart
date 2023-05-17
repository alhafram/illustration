import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:illustration/details_screen.dart';
import 'package:illustration/swipeable_widget.dart';

final appRouter = GoRouter(routes: [
  ShellRoute(
      builder: (context, router, navigator) {
        return KeyedSubtree(child: navigator);
      },
      routes: [
        AppRoute('/home', (s) => SwipeableWidget()),
        AppRoute('/details', (_) => const DetailsScreen(), useFade: true)
      ])
]);

class AppRoute extends GoRoute {
  AppRoute(String path, Widget Function(GoRouterState s) builder,
      {List<GoRoute> routes = const [], this.useFade = false})
      : super(
          path: path,
          routes: routes,
          pageBuilder: (context, state) {
            final pageContent = Scaffold(
              body: builder(state),
              resizeToAvoidBottomInset: false,
            );
            if (useFade) {
              return CustomTransitionPage(
                key: state.pageKey,
                child: pageContent,
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
              );
            }
            return CupertinoPage(child: pageContent);
          },
        );
  final bool useFade;
}
