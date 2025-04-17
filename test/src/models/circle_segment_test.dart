import 'package:flutter/material.dart';
import 'package:flutter_animated_circle/src/models/circle_segment.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CircleSegment', () {
    test('creates instance with correct properties', () {
      const segment = CircleSegment(
        fillColor: Colors.blue,
        borderColor: Colors.red,
        ratio: 0.5,
      );

      expect(segment.fillColor, Colors.blue);
      expect(segment.borderColor, Colors.red);
      expect(segment.ratio, 0.5);
    });

    test('copyWith correctly replaces specified fields', () {
      const original = CircleSegment(
        fillColor: Colors.blue,
        borderColor: Colors.red,
        ratio: 0.5,
      );

      final copy1 = original.copyWith(fillColor: Colors.green);
      expect(copy1.fillColor, Colors.green);
      expect(copy1.borderColor, Colors.red);
      expect(copy1.ratio, 0.5);

      final copy2 = original.copyWith(borderColor: Colors.yellow, ratio: 0.8);
      expect(copy2.fillColor, Colors.blue);
      expect(copy2.borderColor, Colors.yellow);
      expect(copy2.ratio, 0.8);
    });

    test('equals operator works correctly', () {
      const segment1 = CircleSegment(
        fillColor: Colors.blue,
        borderColor: Colors.red,
        ratio: 0.5,
      );

      const segment2 = CircleSegment(
        fillColor: Colors.blue,
        borderColor: Colors.red,
        ratio: 0.5,
      );

      const segment3 = CircleSegment(
        fillColor: Colors.green,
        borderColor: Colors.red,
        ratio: 0.5,
      );

      expect(segment1 == segment2, isTrue);
      expect(segment1 == segment3, isFalse);
    });

    test('hashCode is consistent', () {
      const segment1 = CircleSegment(
        fillColor: Colors.blue,
        borderColor: Colors.red,
        ratio: 0.5,
      );

      const segment2 = CircleSegment(
        fillColor: Colors.blue,
        borderColor: Colors.red,
        ratio: 0.5,
      );

      expect(segment1.hashCode, segment2.hashCode);
    });

    test('toString returns correct representation', () {
      const segment = CircleSegment(
        fillColor: Colors.blue,
        borderColor: Colors.red,
        ratio: 0.5,
      );

      final stringRepresentation = segment.toString();
      expect(stringRepresentation, contains('CircleSegment'));
      expect(stringRepresentation, contains('fillColor:'));
      expect(stringRepresentation, contains('borderColor:'));
      expect(stringRepresentation, contains('ratio: 0.5'));
    });
  });
}
