import 'package:example/pages/full_circle_demo.dart';
import 'package:example/pages/home_page.dart';
import 'package:example/pages/segmented_circle_demo.dart';
import 'package:example/pages/segmented_circle_scroll_demo.dart';
import 'package:flutter/material.dart';

final class AppRoutes {
  const AppRoutes._();

  static const String home = '/';
  static const String fullCircle = '/full-circle';
  static const String segmentedCircle = '/segmented-circle';
  static const String segmentedCircleScroll = '/segmented-circle-scroll';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case fullCircle:
        return MaterialPageRoute(builder: (_) => const FullCircleDemo());
      case segmentedCircle:
        return MaterialPageRoute(builder: (_) => const SegmentedCircleDemo());
      case segmentedCircleScroll:
        return MaterialPageRoute(
          builder: (_) => const SegmentedCircleScrollDemo(),
        );
      default:
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ),
        );
    }
  }
}
