import 'package:flutter/material.dart';
import 'bone.dart';

/// A bone shape that mimics an icon (typically square with rounded corners).
class BoneIcon extends Bone {
  const BoneIcon({
    this.size = 24.0,
    super.radius,
  }) : super(
          width: size,
          height: size,
        );

  /// Size of the icon (both width and height).
  final double size;

  @override
  Widget build(BuildContext context, Size size) {
    return SizedBox(
      width: this.size,
      height: this.size,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 4.0),
          color: Colors.grey[300], // Will be overridden by shimmer
        ),
      ),
    );
  }
}

