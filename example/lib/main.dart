import 'package:example/routes/app_routes.dart';
import 'package:flutter/material.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Flutter Animated Circle Example',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    ),
    initialRoute: AppRoutes.home,
    onGenerateRoute: AppRoutes.onGenerateRoute,
  );
}
