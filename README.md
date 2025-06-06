# Flutter Animated Circle

[![Pub Package](https://img.shields.io/pub/v/flutter_animated_circle.svg)](https://pub.dev/packages/flutter_animated_circle)
[![Pub Points](https://img.shields.io/pub/points/flutter_animated_circle)](https://pub.dev/packages/flutter_animated_circle/score)
[![Platform Support](https://img.shields.io/badge/platform-android%20%7C%20ios%20%7C%20web%20%7C%20windows%20%7C%20macos%20%7C%20linux-blue.svg)](https://pub.dev/packages/flutter_animated_circle)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A production-ready Flutter package that provides beautiful, customizable animated circular widgets with smooth animations and extensive configuration options. Perfect for creating progress indicators, pie charts, data visualizations, and engaging UI elements.

<p align="center">
  <img src="doc/showcase.gif" alt="Flutter Animated Circle Showcase" width="400"/>
</p>

## 🎯 Key Features

- **🎨 Full Circle Animation**: Smooth, customizable circular progress indicators with configurable timing
- **📊 Segmented Circles**: Multi-colored segments ideal for pie charts, data visualization, and progress tracking
- **🔄 Scroll-Triggered Animation**: Intelligent viewport detection with automatic animation triggering
- **⚙️ Extensive Customization**: Granular control over colors, stroke widths, borders, spacing, and timing
- **🚀 Performance Optimized**: Efficient rendering with RepaintBoundary and optimized painters
- **📱 Cross-Platform**: Full support for Android, iOS, Web, Windows, macOS, and Linux
- **🎭 Animation Curves**: Support for all Flutter animation curves and custom easing functions

## 🚀 Getting Started

### Installation

Add `flutter_animated_circle` to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_animated_circle: ^0.0.2
```

Then run:

```bash
flutter pub get
```

### Import

```dart
import 'package:flutter_animated_circle/flutter_animated_circle.dart';
```

## 📖 Usage Examples

### Basic Usage

#### Simple Progress Circle

```dart
AnimatedCircleView(
  circlePainterConfig: CirclePainterConfig.full(
    fillColor: Colors.blue,
    borderColor: Colors.blue.shade800,
    strokeWidth: 16.0,
    borderWidth: 20.0,
  ),
  duration: const Duration(milliseconds: 800),
)
```

#### Multi-Segment Data Visualization

```dart
AnimatedCircleView(
  circlePainterConfig: CirclePainterConfig.segmented(
    segments: [
      CircleSegment(
        fillColor: Colors.blue, 
        borderColor: Colors.blue.shade800,
        ratio: 0.6, // 60% of the circle
      ),
      CircleSegment(
        fillColor: Colors.green, 
        borderColor: Colors.green.shade800,
        ratio: 0.4, // 40% of the circle
      ),
    ],
    strokeWidth: 16.0,
    borderWidth: 20.0,
  ),
  duration: const Duration(milliseconds: 800),
)
```

### Advanced Features

#### Scroll-Triggered Animation

Automatically animate circles when they become visible during scrolling:

```dart
class ScrollableCircles extends StatefulWidget {
  @override
  State<ScrollableCircles> createState() => _ScrollableCirclesState();
}

class _ScrollableCirclesState extends State<ScrollableCircles> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: 10,
      itemBuilder: (context, index) {
        return Container(
          height: 400,
          padding: const EdgeInsets.all(20),
          child: AnimatedCircleView(
            circlePainterConfig: CirclePainterConfig.full(
              fillColor: Colors.amber,
              borderColor: Colors.amber.shade800,
            ),
            scrollController: _scrollController,
            duration: const Duration(milliseconds: 600),
            onAnimationCompleted: () {
              print('Circle $index animation completed!');
            },
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
```

#### Complex Multi-Segment Circle with Custom Styling

```dart
AnimatedCircleView(
  circlePainterConfig: CirclePainterConfig.segmented(
    segments: [
      CircleSegment(
        fillColor: Colors.red.shade400, 
        borderColor: Colors.red.shade700, 
        ratio: 0.25
      ),
      CircleSegment(
        fillColor: Colors.blue.shade400, 
        borderColor: Colors.blue.shade700, 
        ratio: 0.25
      ),
      CircleSegment(
        fillColor: Colors.green.shade400, 
        borderColor: Colors.green.shade700, 
        ratio: 0.25
      ),
      CircleSegment(
        fillColor: Colors.purple.shade400, 
        borderColor: Colors.purple.shade700, 
        ratio: 0.25
      ),
    ],
    separatorAngle: 0.05, // 5-degree gaps between segments
    baseColor: Colors.grey.shade200, // Background color
    strokeWidth: 18.0,
    borderWidth: 22.0,
  ),
  duration: const Duration(milliseconds: 1200),
  fadeInDuration: const Duration(milliseconds: 300),
  curve: Curves.easeInOutCubic,
  onAnimationCompleted: () {
    print("Multi-segment animation completed!");
  },
)
```

## 📋 API Reference

### AnimatedCircleView

The main widget for displaying animated circles.

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `circlePainterConfig` | `CirclePainterConfig` | **required** | Configuration for circle appearance and segments |
| `scrollController` | `ScrollController?` | `null` | Enables scroll-triggered animation when provided |
| `onAnimationCompleted` | `VoidCallback?` | `null` | Callback fired when animation completes |
| `duration` | `Duration` | `600ms` | Duration of the circle drawing animation |
| `fadeInDuration` | `Duration` | `200ms` | Duration of fade-in effect |
| `curve` | `Curve` | `Curves.easeIn` | Animation curve for drawing animation |
| `strokeWidth` | `double` | `16.0` | Width of circle's inner stroke |
| `borderWidth` | `double` | `20.0` | Width of circle's outer border |

### CirclePainterConfig

Configuration class that defines the visual appearance of circles.

#### CirclePainterConfig.full()

Creates a single-color circle configuration.

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `fillColor` | `Color` | **required** | Color of the circle's fill |
| `borderColor` | `Color` | **required** | Color of the circle's border |
| `strokeWidth` | `double` | `16.0` | Width of the inner stroke |
| `borderWidth` | `double` | `20.0` | Width of the outer border |
| `baseColor` | `Color` | `Colors.transparent` | Background color |

#### CirclePainterConfig.segmented()

Creates a multi-segment circle configuration.

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `segments` | `Iterable<CircleSegment>` | **required** | List of circle segments |
| `strokeWidth` | `double` | `16.0` | Width of segment strokes |
| `borderWidth` | `double` | `20.0` | Width of segment borders |
| `baseColor` | `Color` | `Colors.transparent` | Background color |
| `separatorAngle` | `double` | `0.18` | Angle between segments (radians) |

### CircleSegment

Defines individual segments in a multi-segment circle.

| Property | Type | Description |
|----------|------|-------------|
| `fillColor` | `Color` | Color of the segment's fill |
| `borderColor` | `Color` | Color of the segment's border |
| `ratio` | `double` | Portion of circle (0.0 to 1.0) |

**Important**: The sum of all segment ratios must equal 1.0.

## 🎨 Design Patterns & Use Cases

### Progress Indicators

```dart
// Simple progress bar alternative
AnimatedCircleView(
  circlePainterConfig: CirclePainterConfig.full(
    fillColor: Theme.of(context).primaryColor,
    borderColor: Theme.of(context).primaryColor.withOpacity(0.3),
  ),
)
```

### Data Visualization

```dart
// Pie chart for statistics
AnimatedCircleView(
  circlePainterConfig: CirclePainterConfig.segmented(
    segments: [
      CircleSegment(fillColor: Colors.blue, borderColor: Colors.blue.shade700, ratio: 0.45),   // 45%
      CircleSegment(fillColor: Colors.green, borderColor: Colors.green.shade700, ratio: 0.30), // 30%
      CircleSegment(fillColor: Colors.orange, borderColor: Colors.orange.shade700, ratio: 0.25), // 25%
    ],
  ),
)
```

### Loading Indicators

```dart
// Elegant loading spinner
AnimatedCircleView(
  circlePainterConfig: CirclePainterConfig.full(
    fillColor: Colors.blue.withOpacity(0.7),
    borderColor: Colors.blue,
    strokeWidth: 8.0,
    borderWidth: 12.0,
  ),
  duration: const Duration(milliseconds: 1000),
  curve: Curves.easeInOut,
)
```

## 🔧 Performance Considerations

- **Efficient Rendering**: Uses `RepaintBoundary` for optimized painting
- **Memory Management**: Automatic cleanup of animation controllers and listeners
- **Viewport Optimization**: Scroll-triggered animations only activate when visible
- **Smooth Animations**: Hardware-accelerated animations using Flutter's animation framework

## 🐛 Troubleshooting

### Common Issues

**Segments don't add up to full circle**
```dart
// ❌ This will throw an assertion error
CirclePainterConfig.segmented(
  segments: [
    CircleSegment(ratio: 0.5, ...),
    CircleSegment(ratio: 0.3, ...), // Total = 0.8, not 1.0
  ],
);

// ✅ Correct usage
CirclePainterConfig.segmented(
  segments: [
    CircleSegment(ratio: 0.7, ...),
    CircleSegment(ratio: 0.3, ...), // Total = 1.0
  ],
);
```

**Animation not triggering with scroll controller**
- Ensure the `ScrollController` is properly attached to your scrollable widget
- Check that the circle widget is actually within the scrollable area
- Verify that at least 30% of the circle is visible before animation triggers

**Performance issues with many circles**
- Use `RepaintBoundary` around individual circles when rendering many
- Consider using `ListView.builder` instead of `ListView` for better performance
- Implement lazy loading for large datasets

## 📱 Example App

This package includes a comprehensive example application demonstrating all features:

```bash
cd example
flutter run
```

The example showcases:
- **Full Circle Demo**: Basic circular progress indicators
- **Segmented Circle Demo**: Multi-colored data visualization
- **Scroll Demo**: Scroll-triggered animations
- **Performance Demo**: Multiple circles with optimized rendering

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guide](CONTRIBUTING.md) for details.

### Development Setup

1. **Fork the repository**
2. **Clone your fork**:
   ```bash
   git clone https://github.com/yourusername/flutter_animated_circle.git
   cd flutter_animated_circle
   ```
3. **Install dependencies**:
   ```bash
   flutter pub get
   cd example && flutter pub get
   ```
4. **Run tests**:
   ```bash
   flutter test
   ```
5. **Run the example**:
   ```bash
   cd example && flutter run
   ```

### Code Quality

This project maintains high code quality standards:
- **Linting**: Uses `very_good_analysis` for strict code analysis
- **Testing**: Comprehensive test coverage for all components
- **Documentation**: Extensive inline documentation and examples
- **Type Safety**: Full null safety support

## 🔄 Migration Guide

### From v0.0.1 to v0.0.2

No breaking changes. This release adds:
- Enhanced documentation
- Additional usage examples
- Performance improvements
- Better error handling

## 📊 Changelog

See [CHANGELOG.md](CHANGELOG.md) for a detailed list of changes in each version.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🌟 Support

- **Documentation**: Comprehensive API documentation and examples
- **Issues**: Report bugs and request features on [GitHub Issues](https://github.com/geridev12/flutter_animated_circle/issues)
- **Discussions**: Join the community on [GitHub Discussions](https://github.com/geridev12/flutter_animated_circle/discussions)

## 🏆 Acknowledgments

- Built with ❤️ by the Flutter community
- Inspired by modern UI design principles
- Thanks to all contributors and users

---

<p align="center">
  <strong>Made with Flutter 💙</strong>
</p>
