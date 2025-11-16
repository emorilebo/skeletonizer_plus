import 'package:flutter/material.dart';
import 'animation_config.dart';

/// Custom painter that draws the shimmer effect over skeleton bones.
class ShimmerPainter extends CustomPainter {
  ShimmerPainter({
    required this.animation,
    required this.config,
    required this.theme,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final AnimationConfig config;
  final ThemeData theme;

  @override
  void paint(Canvas canvas, Size size) {
    final baseColor = config.baseColor ??
        (theme.brightness == Brightness.dark
            ? Colors.grey[800]!
            : Colors.grey[300]!);
    final highlightColor = config.highlightColor ??
        (theme.brightness == Brightness.dark
            ? Colors.grey[700]!
            : Colors.grey[100]!);

    // Create gradient based on direction
    final gradient = _createGradient(size, baseColor, highlightColor);

    // Draw base color
    final basePaint = Paint()..color = baseColor;
    canvas.drawRect(Offset.zero & size, basePaint);

    // Draw shimmer gradient
    final shimmerPaint = Paint()
      ..shader = gradient.createShader(
        Rect.fromLTWH(0, 0, size.width, size.height),
      );

    // Calculate shimmer position based on animation value
    final shimmerRect = _calculateShimmerRect(size);
    canvas.drawRect(shimmerRect, shimmerPaint);
  }

  Gradient _createGradient(Size size, Color base, Color highlight) {
    switch (config.direction) {
      case ShimmerDirection.ltr:
        return LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            base,
            highlight,
            base,
          ],
          stops: const [0.0, 0.5, 1.0],
        );
      case ShimmerDirection.rtl:
        return LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: [
            base,
            highlight,
            base,
          ],
          stops: const [0.0, 0.5, 1.0],
        );
      case ShimmerDirection.topDown:
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            base,
            highlight,
            base,
          ],
          stops: const [0.0, 0.5, 1.0],
        );
      case ShimmerDirection.bottomUp:
        return LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            base,
            highlight,
            base,
          ],
          stops: const [0.0, 0.5, 1.0],
        );
    }
  }

  Rect _calculateShimmerRect(Size size) {
    final progress = animation.value;
    final shimmerWidth = size.width * 0.3;

    switch (config.direction) {
      case ShimmerDirection.ltr:
        return Rect.fromLTWH(
          (size.width + shimmerWidth) * progress - shimmerWidth,
          0,
          shimmerWidth,
          size.height,
        );
      case ShimmerDirection.rtl:
        return Rect.fromLTWH(
          size.width - (size.width + shimmerWidth) * progress,
          0,
          shimmerWidth,
          size.height,
        );
      case ShimmerDirection.topDown:
        return Rect.fromLTWH(
          0,
          (size.height + shimmerWidth) * progress - shimmerWidth,
          size.width,
          shimmerWidth,
        );
      case ShimmerDirection.bottomUp:
        return Rect.fromLTWH(
          0,
          size.height - (size.height + shimmerWidth) * progress,
          size.width,
          shimmerWidth,
        );
    }
  }

  @override
  bool shouldRepaint(ShimmerPainter oldDelegate) {
    return oldDelegate.animation != animation ||
        oldDelegate.config != config ||
        oldDelegate.theme != theme;
  }
}

