import 'package:flutter/material.dart';

/// A widget that forces its descendants to be united into a single skeleton bone.
/// This is useful for grouping multiple small widgets (like a row of icons or text)
/// into one larger block.
class SkeletonUnite extends StatelessWidget {
  /// Creates a SkeletonUnite widget.
  const SkeletonUnite({
    required this.child,
    this.borderRadius,
    super.key,
  });

  /// The child widget containing descendants to unite.
  final Widget child;

  /// Optional border radius for the united bone.
  /// If null, a default radius will be used.
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
