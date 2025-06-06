import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_animated_circle/src/painters/circle_painter.dart';

/// A widget that displays an animated circle with configurable appearance and
/// behavior.
///
/// The circle animation can be triggered automatically
///  when the widget is built or
/// when it becomes visible in a scrollable view (using the provided
/// [scrollController]).
///
/// This widget allows for customization of the circle's appearance through
/// [circlePainterConfig], animation timing through [duration],
/// [fadeInDuration],
/// and [curve], and circle styling through [strokeWidth] and [borderWidth].
///
/// Example usage:
/// ```dart
/// AnimatedCircleView(
///   circlePainterConfig: CirclePainterConfig(
///     color: Colors.blue,
///     backgroundColor: Colors.grey.shade200,
///   ),
///   duration: Duration(milliseconds: 800),
///   strokeWidth: 12.0,
/// )
/// ```
class AnimatedCircleView extends StatefulWidget {
  /// Creates an animated circle view with the given configuration.
  ///
  /// The [circlePainterConfig] parameter is required to define the circle's
  /// appearance. Other parameters control animation behavior and styling.
  const AnimatedCircleView({
    required this.circlePainterConfig,
    this.scrollController,
    this.onAnimationCompleted,
    this.duration = const Duration(milliseconds: 600),
    this.fadeInDuration = const Duration(milliseconds: 200),
    this.curve = Curves.easeIn,
    this.strokeWidth = 16.0,
    this.borderWidth = 20.0,
    super.key,
  });

  /// Configuration for the circle painter that determines color, style,
  /// and other
  /// visual properties.
  ///
  /// This is the primary configuration object that controls how the circle
  /// will look.
  /// See [CirclePainterConfig] for all available options.
  final CirclePainterConfig circlePainterConfig;

  /// ScrollController that triggers animation when the widget becomes
  /// visible in the viewport.
  ///
  /// If provided, the animation will start automatically when
  /// a sufficient portion
  /// of the circle (30% by default) becomes visible in the viewport.
  ///
  /// If not provided, the animation starts immediately as soon
  /// as the widget is built.
  final ScrollController? scrollController;

  /// Callback function that is called when the animation completes.
  ///
  /// This is useful for triggering subsequent
  /// animations, state changes, or any
  /// actions that should happen after the circle animation finishes.
  final VoidCallback? onAnimationCompleted;

  // Animation timing parameters

  /// Duration of the circle drawing animation.
  ///
  /// Controls how long it takes for the circle to
  /// complete its drawing animation.
  /// Defaults to 600 milliseconds.
  final Duration duration;

  /// Duration of the fade-in effect when the circle becomes visible.
  ///
  /// Controls how quickly the circle fades into view once it's triggered.
  /// Defaults to 200 milliseconds.
  final Duration fadeInDuration;

  /// The curve to apply to the circle drawing animation.
  ///
  /// Controls the rate of change of the animation over time, allowing for
  /// various easing effects.
  /// Defaults to [Curves.easeIn].
  final Curve curve;

  // Circle appearance parameters

  /// Width of the circle's stroke.
  ///
  /// This overrides the strokeWidth in the [circlePainterConfig].
  /// Defaults to 16.0.
  final double strokeWidth;

  /// Width of the circle's border.
  ///
  /// This overrides the borderWidth in the [circlePainterConfig].
  /// Defaults to 20.0.
  final double borderWidth;

  @override
  State<AnimatedCircleView> createState() => _AnimatedCircleViewState();
}

class _AnimatedCircleViewState extends State<AnimatedCircleView>
    with SingleTickerProviderStateMixin {
  /// Controller for the circle drawing animation.
  late final AnimationController _animationController;

  /// Notifier that tracks whether the circle is currently
  /// visible in the viewport.
  /// Used to trigger animation and fade-in effects.
  late final ValueNotifier<bool> _isVisible = ValueNotifier<bool>(false);

  final GlobalKey _circleKey = GlobalKey<State<StatefulWidget>>();

  bool _hasAnimatedOnce = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    if (widget.scrollController == null) {
      _isVisible.value = true;
      _animationController.forward().then((_) {
        _hasAnimatedOnce = true;
        widget.onAnimationCompleted?.call();
      });
    } else {
      widget.scrollController!.addListener(_checkVisibility);
      WidgetsBinding.instance.addPostFrameCallback((_) => _checkVisibility());
    }
  }

  void _checkVisibility() {
    if (_hasAnimatedOnce) return;

    final context = _circleKey.currentContext;
    if (context == null) return;

    final box = context.findRenderObject() as RenderBox?;
    if (box == null) return;

    final position = box.localToGlobal(Offset.zero);
    final circleSize = box.size;
    final screenHeight = MediaQuery.of(context).size.height;

    final visibleTop = math.max(0, position.dy);
    final visibleBottom = math.min(
      screenHeight,
      position.dy + circleSize.height,
    );
    final visibleHeight = visibleBottom - visibleTop;

    final visibilityThreshold = circleSize.height * 0.3;
    final isVisible = visibleHeight > visibilityThreshold;

    if (isVisible && !_isVisible.value) {
      _isVisible.value = true;
      _animationController
        ..reset()
        ..forward().then((_) {
          _hasAnimatedOnce = true;
          widget.onAnimationCompleted?.call();
        });
    }
  }

  @override
  void dispose() {
    _isVisible.dispose();
    _animationController.dispose();
    widget.scrollController?.removeListener(_checkVisibility);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final animation = CurvedAnimation(
      parent: _animationController,
      curve: widget.curve,
    );

    final modifiedConfig = widget.circlePainterConfig.copyWith(
      strokeWidth: widget.strokeWidth,
      borderWidth: widget.borderWidth,
    );

    return ValueListenableBuilder<bool>(
      valueListenable: _isVisible,
      builder:
          (context, isVisible, child) => AnimatedOpacity(
            duration: widget.fadeInDuration,
            opacity: isVisible ? 1 : 0,
            child: child,
          ),
      child: AnimatedBuilder(
        animation: animation,
        builder:
            (context, _) => LayoutBuilder(
              builder: (context, constraints) {
                final size = math.min(
                  constraints.maxWidth,
                  constraints.maxHeight,
                );
                return RepaintBoundary(
                  key: _circleKey,
                  child: CustomPaint(
                    size: Size(size, size),
                    painter: modifiedConfig.createPainter(animation.value),
                  ),
                );
              },
            ),
      ),
    );
  }
}
