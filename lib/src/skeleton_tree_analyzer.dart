import 'package:flutter/material.dart';
import 'bones/bone.dart';
import 'bones/bone_text.dart';
import 'bones/bone_circle.dart';
import 'bones/bone_rect.dart';
import 'bones/bone_icon.dart';
import 'widgets/skeleton_ignore.dart';
import 'widgets/skeleton_unite.dart';

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
      final lines = text.split('\n').length;
      final style = widget.style;
      bones.add(BoneText(
        words: words > 0 ? words : 1,
        lines: lines > 0 ? lines : 1,
        fontSize: style?.fontSize,
        style: style,
      ),);
    } else if (widget is SkeletonIgnore) {
      bones.add(BoneWidget(child: widget.child));
    } else if (widget is SkeletonUnite) {
       bones.add(BoneRect(
        radius: widget.borderRadius is BorderRadius 
            ? (widget.borderRadius as BorderRadius).topLeft.x 
            : 8.0,
        // Unite implies we treat the whole subtree as one block. 
        // Ideally we would measure it, but here we might rely on the BoneRect 
        // taking the size of the container or being flexible.
        // For now, let's treat it as a generic block.
      ));
    } else if (widget is Icon) {
      bones.add(const BoneIcon(size: 24.0));
    } else if (widget is Image) {
      bones.add(const BoneRect(radius: 8.0));
    } else if (widget is Container) {
      if (widget.decoration is BoxDecoration) {
        final decoration = widget.decoration as BoxDecoration?;
        final borderRadius = decoration?.borderRadius;
        final radius = borderRadius is BorderRadius
            ? borderRadius.topLeft.x
            : (decoration?.shape == BoxShape.circle ? null : 0.0);
        bones.add(BoneRect(
          width: widget.constraints?.maxWidth,
          height: widget.constraints?.maxHeight,
          radius: radius,
        ),);
      }
    } else if (widget is Card) {
      bones.add(const BoneRect(radius: 12.0));
    } else if (widget is ListTile) {
      if (widget.leading != null) {
        bones.add(const BoneCircle(radius: 20.0));
      }
      if (widget.title != null) {
        bones.add(const BoneText(words: 3));
      }
      if (widget.subtitle != null) {
        bones.add(const BoneText(words: 2, lines: 1));
      }
    } else if (widget is Row) {
      // For Row, analyze children
      for (final child in widget.children) {
        _analyzeWidgetRecursive(child, bones);
      }
    } else if (widget is Column) {
      // For Column, analyze children
      for (final child in widget.children) {
        _analyzeWidgetRecursive(child, bones);
      }
    } else if (widget is Builder || widget is StatelessWidget || widget is StatefulWidget) {
      // For generic widgets, create a default bone
      bones.add(const BoneRect(radius: 4.0));
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

