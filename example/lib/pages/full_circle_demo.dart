import 'package:flutter/material.dart';
import 'package:flutter_animated_circle/flutter_animated_circle.dart';

class FullCircleDemo extends StatelessWidget {
  const FullCircleDemo({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Full Circle'), elevation: 0),
    body: Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60.0),
        child: SizedBox(
          height: 300,
          width: 300,
          child: AnimatedCircleView(
            circlePainterConfig: CirclePainterConfig.full(
              fillColor: Colors.cyan[300]!,
              borderColor: Colors.cyan[500]!,
            ),
          ),
        ),
      ),
    ),
  );
}
