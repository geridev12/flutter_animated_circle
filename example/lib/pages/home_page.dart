import 'package:example/routes/app_routes.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: const Text('Animated Circle'),
    ),
    body: Column(
      spacing: 10,
      children: [
        const SizedBox(height: 10),
        IconTextButton(
          text: 'Full Circle',
          onPressed: () => Navigator.pushNamed(context, AppRoutes.fullCircle),
        ),
        IconTextButton(
          text: 'Segmented Circle',
          onPressed:
              () => Navigator.pushNamed(context, AppRoutes.segmentedCircle),
        ),
        IconTextButton(
          text: 'Circle on Scroll',
          onPressed:
              () =>
                  Navigator.pushNamed(context, AppRoutes.segmentedCircleScroll),
        ),
      ],
    ),
  );
}

class IconTextButton extends StatelessWidget {
  const IconTextButton({
    required this.text,
    required this.onPressed,
    super.key,
  });

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(text),
      trailing: IconButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        icon: const Icon(Icons.arrow_forward_ios, size: 20),
      ),
    );
  }
}
