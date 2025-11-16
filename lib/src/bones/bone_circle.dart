import 'package:flutter/material.dart';
import 'bone.dart';

/// A bone shape that renders as a circle.
class BoneCircle extends Bone {
  const BoneCircle({
    super.radius,
    super.width,
    super.height,
  });

  @override
  Widget build(BuildContext context, Size size) {
    final effectiveSize = width != null && height != null
        ? (width! < height! ? width! : height!)
        : (size.width < size.height ? size.width : size.height);
    final diameter = radius != null ? radius! * 2 : effectiveSize;

    return SizedBox(
      width: diameter,
      height: diameter,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[300], // Will be overridden by shimmer
        ),
      ),
    );
  }
}

