import 'package:flutter/material.dart';

/// Base class for all skeleton bone shapes.
abstract class Bone {
  const Bone({
    this.width,
    this.height,
    this.radius,
    this.customShape,
  });

  /// Optional fixed width. If null, width is inferred from child.
  final double? width;

  /// Optional fixed height. If null, height is inferred from child.
  final double? height;

  /// Optional border radius for rounded rectangles.
  final double? radius;

  /// Custom shape path. If provided, this overrides default shape rendering.
  final Path? customShape;

  /// Creates a widget representation of this bone.
  Widget build(BuildContext context, Size size);
}



/// A bone that renders an actual widget.
/// Used for SkeletonIgnore to keep the original widget visible in the skeleton stack.
class BoneWidget extends Bone {
  const BoneWidget({
    required this.child,
    super.width,
    super.height,
  });

  final Widget child;

  @override
  Widget build(BuildContext context, Size size) {
    return SizedBox(
      width: width ?? size.width,
      height: height ?? size.height,
      child: child,
    );
  }
}
