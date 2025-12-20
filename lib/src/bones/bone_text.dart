import 'package:flutter/material.dart';
import 'bone.dart';

/// A bone shape that mimics text with multiple words.
class BoneText extends Bone {
  const BoneText({
    this.words = 1,
    this.wordSpacing = 8.0,
    this.lineHeight = 16.0,
    this.lineSpacing = 4.0,
    this.lines = 1,
    super.width,
    super.height,
    super.radius,
    this.fontSize,
    this.style,
  });

  /// Number of words per line.
  final int words;

  /// Spacing between words.
  final double wordSpacing;

  /// Height of each text line.
  final double lineHeight;

  /// Spacing between lines.
  final double lineSpacing;

  /// Number of lines.
  final int lines;

  /// Optional font size to override lineHeight inference.
  final double? fontSize;

  /// Optional text style.
  final TextStyle? style;

  @override
  Widget build(BuildContext context, Size size) {
    final effectiveWidth = width ?? size.width;
    final effectiveHeight = height ?? (lines * lineHeight + (lines - 1) * lineSpacing);
    final wordWidth = (effectiveWidth - (words - 1) * wordSpacing) / words;

    return SizedBox(
      width: effectiveWidth,
      height: effectiveHeight,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          lines,
          (lineIndex) => Padding(
            padding: EdgeInsets.only(
              bottom: lineIndex < lines - 1 ? lineSpacing : 0,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                words,
                (wordIndex) => Padding(
                  padding: EdgeInsets.only(
                    right: wordIndex < words - 1 ? wordSpacing : 0,
                  ),
                  child: Container(
                    width: wordWidth,
                    height: lineHeight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radius ?? 4.0),
                      color: Colors.grey[300], // Will be overridden by shimmer
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

