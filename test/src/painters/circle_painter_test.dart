import 'package:flutter/material.dart';
import 'package:flutter_animated_circle/src/models/circle_segment.dart';
import 'package:flutter_animated_circle/src/painters/circle_painter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CirclePainterConfig', () {
    test('full constructor creates config with one segment', () {
      final config = CirclePainterConfig.full(
        fillColor: Colors.red,
        borderColor: Colors.black,
        strokeWidth: 10,
        borderWidth: 15,
        baseColor: Colors.grey,
      );

      expect(config.segments.length, 1);
      expect(config.segments.first.fillColor, Colors.red);
      expect(config.segments.first.borderColor, Colors.black);
      expect(config.segments.first.ratio, 1);
      expect(config.strokeWidth, 10);
      expect(config.borderWidth, 15);
      expect(config.baseColor, Colors.grey);
      expect(config.separatorAngle, 0);
    });

    test('segmented constructor creates config with multiple segments', () {
      const segments = [
        CircleSegment(
          fillColor: Colors.red,
          borderColor: Colors.black,
          ratio: 0.7,
        ),
        CircleSegment(
          fillColor: Colors.blue,
          borderColor: Colors.green,
          ratio: 0.3,
        ),
      ];

      final config = CirclePainterConfig.segmented(
        segments: segments,
        strokeWidth: 12,
        borderWidth: 18,
        baseColor: Colors.grey,
      );

      expect(config.segments, segments);
      expect(config.strokeWidth, 12);
      expect(config.borderWidth, 18);
      expect(config.baseColor, Colors.grey);
      expect(config.separatorAngle, 0.18);
    });

    test(
      'segmented constructor throws assertion error when segments are empty',
      () {
        expect(
          () => CirclePainterConfig.segmented(segments: []),
          throwsAssertionError,
        );
      },
    );

    test('segmented constructor throws assertion error when segment '
        'ratios do not sum to 1.0', () {
      const segments = [
        CircleSegment(
          fillColor: Colors.red,
          borderColor: Colors.black,
          ratio: 0.7,
        ),
        CircleSegment(
          fillColor: Colors.blue,
          borderColor: Colors.green,
          ratio: 0.2,
        ),
      ];

      expect(
        () => CirclePainterConfig.segmented(segments: segments),
        throwsAssertionError,
      );
    });

    test('copyWith returns new instance with updated properties', () {
      final config = CirclePainterConfig.full(
        fillColor: Colors.red,
        borderColor: Colors.black,
      );

      const newSegments = [
        CircleSegment(
          fillColor: Colors.green,
          borderColor: Colors.blue,
          ratio: 1,
        ),
      ];

      final updated = config.copyWith(
        segments: newSegments,
        strokeWidth: 20,
        borderWidth: 25,
        baseColor: Colors.yellow,
      );

      expect(updated.segments, newSegments);
      expect(updated.strokeWidth, 20);
      expect(updated.borderWidth, 25);
      expect(updated.baseColor, Colors.yellow);
      expect(updated.separatorAngle, config.separatorAngle);
    });

    test('createPainter returns CirclePainter with correct properties', () {
      final config = CirclePainterConfig.full(
        fillColor: Colors.red,
        borderColor: Colors.black,
      );

      final painter = config.createPainter(0.5);

      expect(painter, isA<CirclePainter>());
      expect(painter.progress, 0.5);
      expect(painter.config, config);
    });
  });

  group('CirclePainter', () {
    test('shouldRepaint returns true when progress changes', () {
      final config = CirclePainterConfig.full(
        fillColor: Colors.red,
        borderColor: Colors.black,
      );

      final painter1 = config.createPainter(0.5);
      final painter2 = config.createPainter(0.7);

      expect(painter1.shouldRepaint(painter2), true);
    });

    test('shouldRepaint returns true when segment count changes', () {
      final config1 = CirclePainterConfig.segmented(
        segments: const [
          CircleSegment(
            fillColor: Colors.red,
            borderColor: Colors.black,
            ratio: 1,
          ),
        ],
      );

      final config2 = CirclePainterConfig.segmented(
        segments: const [
          CircleSegment(
            fillColor: Colors.red,
            borderColor: Colors.black,
            ratio: 0.5,
          ),
          CircleSegment(
            fillColor: Colors.blue,
            borderColor: Colors.green,
            ratio: 0.5,
          ),
        ],
      );

      final painter1 = config1.createPainter(0.5);
      final painter2 = config2.createPainter(0.5);

      expect(painter1.shouldRepaint(painter2), true);
    });

    test('shouldRepaint returns false when only colors change', () {
      final config1 = CirclePainterConfig.full(
        fillColor: Colors.red,
        borderColor: Colors.black,
      );

      final config2 = CirclePainterConfig.full(
        fillColor: Colors.blue,
        borderColor: Colors.green,
      );

      final painter1 = config1.createPainter(0.5);
      final painter2 = config2.createPainter(0.5);

      expect(painter1.shouldRepaint(painter2), false);
    });
  });
}
