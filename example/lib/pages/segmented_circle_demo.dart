import 'package:flutter/material.dart';
import 'package:flutter_animated_circle/flutter_animated_circle.dart';

class SegmentedCircleDemo extends StatelessWidget {
  const SegmentedCircleDemo({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Animated Circle'), elevation: 0),
    body: Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60.0),
        child: SizedBox(
          height: 300,
          width: 300,
          child: AnimatedCircleView(
            circlePainterConfig: CirclePainterConfig.segmented(
        
              segments: [
                CircleSegment(
                  
                  fillColor: Colors.blue[300]!,
                  borderColor: Colors.blue[500]!,
                  ratio: 0.7,
                ),
                CircleSegment(
                  fillColor: Colors.teal[400]!,
                  borderColor: Colors.teal[600]!,
                  ratio: 0.1,
                ),
                CircleSegment(
                  fillColor: Colors.amber[300]!,
                  borderColor: Colors.amber[500]!,
                  ratio: 0.1,
                ),
                CircleSegment(
                  fillColor: Colors.purple[300]!,
                  borderColor: Colors.purple[500]!,
                  ratio: 0.1,
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
