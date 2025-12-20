import 'package:flutter/material.dart';

/// A widget that prevents its child from being skeletonized.
/// The child will be rendered as is, even when skeletonizer is enabled.
class SkeletonIgnore extends StatelessWidget {
  /// Creates a SkeletonIgnore widget.
  const SkeletonIgnore({
    required this.child,
    super.key,
  });

  /// The child widget to ignore.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
