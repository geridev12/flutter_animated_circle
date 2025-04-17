import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_animated_circle/src/models/circle_segment.dart';

/// Configuration class for the CirclePainter.
///
/// This class defines the visual appearance and behavior of animated circles,
/// supporting both full circles and segmented circles with customizable colors,
/// stroke widths, and segment separations.
///
/// Two factory constructors are provided for common use cases:
/// - [CirclePainterConfig.full] for single-color circles
/// - [CirclePainterConfig.segmented] for multi-segment circles
/// (like pie charts)
///
/// Visual structure of the circle:
/// - The circle has an inner "fill" stroke and an outer "border" stroke
/// - Each segment can have different colors for both fill and border
/// - Optional separation between segments can be configured
/// - The entire circle can have a base background color
final class CirclePainterConfig {
  /// Private constructor used by the factory constructors.
  const CirclePainterConfig._({
    required this.segments,
    this.separatorAngle = 0.18,
    this.strokeWidth = 16.0,
    this.borderWidth = 20.0,
    this.baseColor = Colors.transparent,
  });

  /// Creates a segmented circle configuration with multiple
  /// segments of different colors.
  ///
  /// Use this constructor when you need a circle divided
  /// into multiple sections,
  /// such as for data visualization, pie charts, or
  /// segmented progress indicators.
  ///
  /// Parameters:
  /// * [segments] - Collection of [CircleSegment]
  /// objects that define each segment's
  /// appearance and size. Each segment has its own fill color,
  /// border color, and ratio.
  ///
  /// * [strokeWidth] - Width of the inner stroke/fill of the circle in logical pixels.
  ///   Controls the thickness of the main colored parts. Default is 16.0.
  ///
  /// * [borderWidth] - Width of the outer border/edge of the circle in logical pixels.
  ///   Creates a visual frame around each segment. Default is 20.0.
  ///
  /// * [baseColor] - Background color of the circle.
  // ignore: comment_references
  ///  This appears "behind" the segments and is visible when [progress]
  /// is less than 1.0. Default is transparent.
  ///
  /// Example:
  /// ```dart
  /// final config = CirclePainterConfig.segmented(
  ///   segments: [
  ///     CircleSegment(fillColor: Colors.blue, borderColor: Colors.darkBlue, ratio: 0.75),/
  ///     CircleSegment(fillColor: Colors.green, borderColor: Colors.darkGreen, ratio: 0.25),/
  ///   ],
  ///   strokeWidth: 18.0,
  ///   borderWidth: 22.0,
  /// );
  /// ```
  ///
  /// Important: The sum of all segment ratios must equal 1.0
  /// (representing a full circle).
  factory CirclePainterConfig.segmented({
    required Iterable<CircleSegment> segments,
    double strokeWidth = 16.0,
    double borderWidth = 20.0,
    Color baseColor = Colors.transparent,
  }) {
    assert(segments.isNotEmpty, 'Segments cannot be empty');
    assert(
      segments
              .fold<double>(0, (sum, segment) => sum + segment.ratio)
              .toStringAsFixed(2) ==
          '1.00',
      'Sum of all segment ratios must equal 1.0',
    );

    return CirclePainterConfig._(
      segments: segments,
      strokeWidth: strokeWidth,
      borderWidth: borderWidth,
      baseColor: baseColor,
    );
  }

  /// Creates a full circle configuration with a single color.
  ///
  /// Use this constructor for uniform circles
  /// such as simple progress indicators, loading spinners, or circular buttons.
  ///
  /// Parameters:
  /// * [fillColor] - Color of the inner stroke/fill of the circle. This is the
  ///   primary color that will be visible.
  ///
  /// * [borderColor] - Color of the outer border/edge of the circle. Typically a
  ///   darker or lighter shade of the fill color for visual depth.
  ///
  /// * [strokeWidth] - Width of the inner stroke/fill in logical pixels.
  ///   Default is 16.0.
  ///
  /// * [borderWidth] - Width of the outer border/edge in logical pixels.
  ///   Default is 20.0.
  ///
  /// * [baseColor] - Background color of the circle. Default is transparent.
  ///
  /// Example:
  /// ```dart
  /// final config = CirclePainterConfig.full(
  ///   fillColor: Colors.amber,
  ///   borderColor: Colors.amber.shade800,
  ///   strokeWidth: 14.0,
  /// );
  /// ```
  factory CirclePainterConfig.full({
    required Color fillColor,
    required Color borderColor,
    double strokeWidth = 16.0,
    double borderWidth = 20.0,
    Color baseColor = Colors.transparent,
  }) {
    return CirclePainterConfig._(
      segments: [
        CircleSegment(fillColor: fillColor, borderColor: borderColor, ratio: 1),
      ],
      separatorAngle: 0,
      strokeWidth: strokeWidth,
      borderWidth: borderWidth,
      baseColor: baseColor,
    );
  }

  /// List of segments that make up the circle.
  ///
  /// Each segment defines its own appearance through
  /// [CircleSegment] properties:
  /// - Fill color (inner stroke)
  /// - Border color (outer edge)
  /// - Ratio (proportion of the circle, from 0.0 to 1.0)
  final Iterable<CircleSegment> segments;

  /// Angle in radians that separates each segment.
  ///
  /// This creates visual spacing between adjacent segments.
  /// Default is 0.18 radians (approximately 10 degrees).
  /// Set to 0.0 to remove all separation between segments.
  final double separatorAngle;

  /// Width of the inner stroke/fill of the circle in logical pixels.
  ///
  /// This defines the thickness of the main colored part of the circle.
  /// Default is 16.0.
  final double strokeWidth;

  /// Width of the outer border/edge of the circle in logical pixels.
  ///
  /// This defines the thickness of the border around each segment.
  /// Default is 20.0.
  final double borderWidth;

  /// Background color of the circle.
  ///
  /// This color appears "behind" the segments and is visible:
  /// - In the spaces between segments (if separatorAngle > 0)
  /// - In the unfilled portion of the circle during animation
  ///
  /// Default is transparent (showing the widget's background).
  final Color baseColor;

  /// Creates a copy of this configuration with the specified fields replaced.
  ///
  /// [segments]: New list of segments.
  /// [strokeWidth]: New stroke width.
  /// [borderWidth]: New border width.
  /// [baseColor]: New background color.
  CirclePainterConfig copyWith({
    Iterable<CircleSegment>? segments,
    double? strokeWidth,
    double? borderWidth,
    Color? baseColor,
  }) {
    return CirclePainterConfig._(
      segments: segments ?? this.segments,
      separatorAngle: separatorAngle,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      borderWidth: borderWidth ?? this.borderWidth,
      baseColor: baseColor ?? this.baseColor,
    );
  }

  /// Creates a CirclePainter with the specified progress.
  ///
  /// [progress]: Value between 0.0 and 1.0
  /// that defines how much of the circle is drawn.
  CirclePainter createPainter(double progress) {
    return CirclePainter._(progress: progress, config: this);
  }
}

/// Custom painter that draws an animated circle or segmented circle.
///
/// This painter is used by the AnimatedCircleView widget to render the circle.
/// It supports both full circles and segmented circles,
///  with customizable colors, stroke widths, and segment separations.
///
/// Visual structure of the circle:
/// - The circle has an inner "fill" stroke and an outer "border" stroke
/// - Each segment can have different colors for both fill and border
/// - Optional separation between segments can be configured
/// - The entire circle can have a base background color
final class CirclePainter extends CustomPainter {
  /// Private constructor used by CirclePainterConfig.createPainter().
  const CirclePainter._({required this.progress, required this.config});

  /// Current progress of the animation, from 0.0 to 1.0.
  final double progress;

  /// Configuration for the circle's appearance.
  final CirclePainterConfig config;

  /// Creates a Paint object with the specified color and stroke settings.
  ///
  /// [color]: Color of the paint.
  /// [isBorder]: If true, uses borderWidth instead of strokeWidth.
  Paint _createPaint({required Color color, bool isBorder = false}) =>
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = isBorder ? config.borderWidth : config.strokeWidth
        ..color = color
        ..isAntiAlias = true
        ..strokeCap = StrokeCap.round;

  @override
  void paint(Canvas canvas, Size size) {
    final circleRadius =
        (math.min(size.width, size.height) - config.borderWidth * 2) / 2;
    final center = Offset(size.width / 2, size.height / 2);

    canvas.drawCircle(
      center,
      circleRadius,
      _createPaint(color: config.baseColor),
    );

    var startAngle = -math.pi / 2;
    const totalAngle = 2 * math.pi;

    for (final segment in config.segments) {
      final sweepAngle =
          (totalAngle * segment.ratio - config.separatorAngle) * progress;

      canvas
        ..drawArc(
          Rect.fromCircle(center: center, radius: circleRadius),
          startAngle,
          sweepAngle,
          false,
          _createPaint(color: segment.borderColor, isBorder: true),
        )
        ..drawArc(
          Rect.fromCircle(center: center, radius: circleRadius),
          startAngle,
          sweepAngle,
          false,
          _createPaint(color: segment.fillColor),
        );

      startAngle += sweepAngle + config.separatorAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CirclePainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.config.segments.length != config.segments.length;
}
