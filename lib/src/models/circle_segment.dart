import 'package:flutter/material.dart';

/// Represents a segment of an animated circle with specific
/// appearance properties.
/// A segment is a portion of the circle with its own visual styling. Multiple
/// segments can be combined to create multi-colored circle animations, such as
/// progress indicators, pie charts, or donut charts.
///
/// Each segment is defined by:
/// - Fill color (inner stroke)
/// - Border color (outer stroke)
/// - Ratio (the proportion of the circle it occupies)
///
/// Example usage:
/// ```dart
/// final segments = [
///   CircleSegment(
///     fillColor: Colors.blue,
///     borderColor: Colors.blue.shade700,
///     ratio: 0.6, // 60% of the circle
///   ),
///   CircleSegment(
///     fillColor: Colors.grey,
///     borderColor: Colors.grey.shade700,
///     ratio: 0.4, // 40% of the circle
///   ),
/// ];
/// ```
@immutable
class CircleSegment {
  /// Creates a new CircleSegment.
  ///
  /// All parameters are required:
  ///
  /// * [fillColor] - The color used for the main inner stroke of this segment.
  ///   This is the primary visible color of the segment when drawn.
  ///
  /// * [borderColor] - The color used for the outer border/edge of this segment.
  ///   Creates a visual distinction between the segment and its background.
  ///
  /// * [ratio] - Defines what proportion of the circle this segment occupies,
  ///   expressed as a value between 0.0 and 1.0. For example:
  ///   - 0.25 means this segment takes up 25% of the circle (90° arc)
  ///   - 0.5 means this segment takes up 50% of the circle (180° arc)
  ///   - 1.0 means this segment occupies the entire circle (360° arc)
  ///
  /// Note: When using multiple segments, ensure their ratios sum to 1.0 (100%)
  /// to fill the complete circle without gaps or overlaps.
  const CircleSegment({
    required this.fillColor,
    required this.borderColor,
    required this.ratio,
  });

  /// Color of the inner stroke/fill of this segment.
  ///
  /// This is the primary color that represents the segment in the circle.
  /// For best visual results, pair this with a complementary [borderColor].
  final Color fillColor;

  /// Color of the outer border of this segment.
  ///
  /// This color creates a visual boundary for the segment and typically should
  /// be a darker or lighter shade of the [fillColor] for cohesive design.
  /// The border appears on the outer edge of the segment.
  final Color borderColor;

  /// Portion of the circle that this segment occupies (0.0 to 1.0).
  ///
  /// For example:
  /// - 0.25 means this segment takes up 25% of the circle (90° arc)
  /// - 0.5 means this segment takes up 50% of the circle (180° arc)
  /// - 1.0 means this segment occupies the entire circle (360° arc)
  ///
  /// Ensure the sum of all segment ratios in a circle equals 1.0
  /// for proper rendering.
  final double ratio;

  /// Creates a copy of this segment with the specified fields replaced with
  ///  new values.
  /// [fillColor]: New inner stroke color.
  /// [borderColor]: New outer border color.
  /// [ratio]: New ratio value.
  CircleSegment copyWith({
    Color? fillColor,
    Color? borderColor,
    double? ratio,
  }) {
    return CircleSegment(
      fillColor: fillColor ?? this.fillColor,
      borderColor: borderColor ?? this.borderColor,
      ratio: ratio ?? this.ratio,
    );
  }

  @override
  String toString() =>
      'CircleSegment(fillColor: $fillColor, borderColor: $borderColor, '
      'ratio: $ratio)';

  @override
  bool operator ==(covariant CircleSegment other) {
    if (identical(this, other)) return true;

    return other.fillColor == fillColor &&
        other.borderColor == borderColor &&
        other.ratio == ratio;
  }

  @override
  int get hashCode =>
      fillColor.hashCode ^ borderColor.hashCode ^ ratio.hashCode;
}
