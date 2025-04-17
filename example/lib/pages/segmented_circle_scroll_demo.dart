import 'package:flutter/material.dart';
import 'package:flutter_animated_circle/flutter_animated_circle.dart';

class SegmentedCircleScrollDemo extends StatefulWidget {
  const SegmentedCircleScrollDemo({super.key});

  @override
  State<SegmentedCircleScrollDemo> createState() =>
      _SegmentedCircleScrollDemoState();
}

class _SegmentedCircleScrollDemoState extends State<SegmentedCircleScrollDemo> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Circle on Scroll'), elevation: 0),
    body: ListView(
      controller: _scrollController,
      children: [
        const SizedBox(height: 300),
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Scroll down to see the animation',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 400),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 60.0),
            child: SizedBox(
              height: 300,
              width: 300,
              child: AnimatedCircleView(
                scrollController: _scrollController,
                duration: const Duration(milliseconds: 600),
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
                      ratio: 0.2,
                    ),
                    CircleSegment(
                      fillColor: Colors.amber[300]!,
                      borderColor: Colors.amber[500]!,
                      ratio: 0.1,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 300),
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Animation complete!',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 300),
      ],
    ),
  );
}
