import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'bones/bone.dart';
import 'bones/bone_text.dart';
import 'bones/bone_circle.dart';
import 'bones/bone_rect.dart';
import 'bones/bone_icon.dart';

/// Analyzes a widget tree and generates skeleton bones.
class SkeletonTreeAnalyzer {
  /// Analyzes the given widget and generates a list of bones.
  static List<Bone> analyzeWidget(Widget widget) {
    final bones = <Bone>[];
    _analyzeWidgetRecursive(widget, bones);
    return bones;
  }

  static void _analyzeWidgetRecursive(Widget widget, List<Bone> bones) {
    if (widget is Text) {
      final text = widget.data ?? '';
      final words = text.split(' ').length;
      bones.add(BoneText(
        words: words > 0 ? words : 1,
        lines: text.split('\n').length,
      ));
    } else if (widget is Icon) {
      bones.add(BoneIcon(size: widget.size ?? 24.0));
    } else if (widget is Image) {
      bones.add(BoneRect(radius: 8.0));
    } else if (widget is Container) {
      if (widget.decoration is BoxDecoration) {
        final decoration = widget.decoration as BoxDecoration?;
        final borderRadius = decoration?.borderRadius;
        final radius = borderRadius is BorderRadius
            ? borderRadius.topLeft.x
            : (decoration?.shape == BoxShape.circle ? null : 0.0);
        bones.add(BoneRect(
          width: (widget.constraints as BoxConstraints?)?.maxWidth,
          height: (widget.constraints as BoxConstraints?)?.maxHeight,
          radius: radius,
        ));
      }
    } else if (widget is Card) {
      bones.add(BoneRect(radius: 12.0));
    } else if (widget is ListTile) {
      if (widget.leading != null) {
        bones.add(BoneCircle(radius: 20.0));
      }
      if (widget.title != null) {
        bones.add(BoneText(words: 3));
      }
      if (widget.subtitle != null) {
        bones.add(BoneText(words: 2, lines: 1));
      }
    } else if (widget is Row || widget is Column) {
      // For Row/Column, analyze children
      if (widget is Row) {
        final children = (widget as Row).children;
        for (final child in children) {
          _analyzeWidgetRecursive(child, bones);
        }
      } else if (widget is Column) {
        final children = (widget as Column).children;
        for (final child in children) {
          _analyzeWidgetRecursive(child, bones);
        }
      }
    } else if (widget is Builder || widget is StatelessWidget || widget is StatefulWidget) {
      // For generic widgets, create a default bone
      bones.add(BoneRect(radius: 4.0));
    }
  }

  /// Analyzes a render object and extracts size information.
  static Size? getSizeFromRenderObject(RenderObject? renderObject) {
    if (renderObject is RenderBox) {
      return renderObject.size;
    }
    return null;
  }
}

