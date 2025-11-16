import 'package:flutter/material.dart';
import 'bone.dart';

/// A bone shape that renders as a rectangle.
class BoneRect extends Bone {
  const BoneRect({
    super.width,
    super.height,
    super.radius,
    super.customShape,
  });

  @override
  Widget build(BuildContext context, Size size) {
    final effectiveWidth = width ?? size.width;
    final effectiveHeight = height ?? size.height;

    return SizedBox(
      width: effectiveWidth,
      height: effectiveHeight,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 0),
          color: Colors.grey[300], // Will be overridden by shimmer
          shape: customShape != null ? BoxShape.rectangle : BoxShape.rectangle,
        ),
      ),
    );
  }
}

