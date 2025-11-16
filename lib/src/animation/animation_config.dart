import 'package:flutter/material.dart';

/// Direction of the shimmer animation.
enum ShimmerDirection {
  /// Left to right.
  ltr,

  /// Right to left.
  rtl,

  /// Top to bottom.
  topDown,

  /// Bottom to top.
  bottomUp,
}

/// Configuration for skeleton shimmer animation.
class AnimationConfig {
  const AnimationConfig({
    this.speed = const Duration(milliseconds: 1200),
    this.baseColor,
    this.highlightColor,
    this.direction = ShimmerDirection.ltr,
    this.loop = true,
    this.loopCount,
  }) : assert(
          loop || loopCount != null,
          'If loop is false, loopCount must be provided',
        );

  /// Animation speed/duration for one shimmer cycle.
  final Duration speed;

  /// Base color of the skeleton (darker).
  final Color? baseColor;

  /// Highlight color of the shimmer (lighter).
  final Color? highlightColor;

  /// Direction of the shimmer animation.
  final ShimmerDirection direction;

  /// Whether to loop infinitely.
  final bool loop;

  /// Number of loops if loop is false.
  final int? loopCount;

  /// Creates a copy with modified fields.
  AnimationConfig copyWith({
    Duration? speed,
    Color? baseColor,
    Color? highlightColor,
    ShimmerDirection? direction,
    bool? loop,
    int? loopCount,
  }) {
    return AnimationConfig(
      speed: speed ?? this.speed,
      baseColor: baseColor ?? this.baseColor,
      highlightColor: highlightColor ?? this.highlightColor,
      direction: direction ?? this.direction,
      loop: loop ?? this.loop,
      loopCount: loopCount ?? this.loopCount,
    );
  }
}

