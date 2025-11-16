import 'package:flutter/material.dart';
import 'animation/animation_config.dart';
import 'animation/shimmer_widget.dart';
import 'bones/bone.dart';
import 'skeleton_tree_analyzer.dart';

/// Main widget that wraps a child and displays skeleton loading state.
class SkeletonizerPlus extends StatefulWidget {
  /// Creates a SkeletonizerPlus that automatically generates bones from child.
  const SkeletonizerPlus({
    required this.child,
    this.enabled = true,
    this.baseColor,
    this.highlightColor,
    this.speed = const Duration(milliseconds: 1200),
    this.direction = ShimmerDirection.ltr,
    this.loop = true,
    this.loopCount,
    this.clipToBounds = true,
    this.optimizeForPerformance = false,
    this.theme,
    super.key,
  }) : bones = null,
       animationConfig = null;

  /// Creates a SkeletonizerPlus with custom bone layout.
  const SkeletonizerPlus.custom({
    required this.bones,
    this.enabled = true,
    this.baseColor,
    this.highlightColor,
    this.speed = const Duration(milliseconds: 1200),
    this.direction = ShimmerDirection.ltr,
    this.loop = true,
    this.loopCount,
    this.clipToBounds = true,
    this.optimizeForPerformance = false,
    this.theme,
    super.key,
  }) : child = null,
       animationConfig = null;

  /// Creates a SkeletonizerPlus with full animation config.
  const SkeletonizerPlus.withConfig({
    required this.child,
    this.enabled = true,
    this.animationConfig,
    this.clipToBounds = true,
    this.optimizeForPerformance = false,
    this.theme,
    super.key,
  }) : baseColor = null,
       highlightColor = null,
       speed = null,
       direction = null,
       loop = null,
       loopCount = null,
       bones = null;

  final Widget? child;
  final List<Bone>? bones;
  final bool enabled;
  final Color? baseColor;
  final Color? highlightColor;
  final Duration? speed;
  final ShimmerDirection? direction;
  final bool? loop;
  final int? loopCount;
  final bool clipToBounds;
  final bool optimizeForPerformance;
  final ThemeData? theme;
  final AnimationConfig? animationConfig;

  @override
  State<SkeletonizerPlus> createState() => _SkeletonizerPlusState();
}

class _SkeletonizerPlusState extends State<SkeletonizerPlus> {
  List<Bone>? _generatedBones;

  @override
  void initState() {
    super.initState();
    if (widget.bones == null && widget.child != null) {
      _generateBones();
    }
  }

  @override
  void didUpdateWidget(SkeletonizerPlus oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.child != oldWidget.child && widget.bones == null) {
      _generateBones();
    }
  }

  void _generateBones() {
    if (widget.child != null) {
      _generatedBones = SkeletonTreeAnalyzer.analyzeWidget(widget.child!);
    }
  }

  AnimationConfig _getAnimationConfig(BuildContext context) {
    if (widget.animationConfig != null) {
      return widget.animationConfig!;
    }

    return AnimationConfig(
      speed: widget.speed ?? const Duration(milliseconds: 1200),
      baseColor: widget.baseColor,
      highlightColor: widget.highlightColor,
      direction: widget.direction ?? ShimmerDirection.ltr,
      loop: widget.loop ?? true,
      loopCount: widget.loopCount,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) {
      return widget.child ?? const SizedBox.shrink();
    }

    final theme = widget.theme ?? Theme.of(context);
    final animationConfig = _getAnimationConfig(context);
    final bones = widget.bones ?? _generatedBones ?? [];

    if (bones.isEmpty) {
      return widget.child ?? const SizedBox.shrink();
    }

    Widget skeletonWidget = _SkeletonBonesWidget(
      bones: bones,
      animationConfig: animationConfig,
      theme: theme,
      optimizeForPerformance: widget.optimizeForPerformance,
    );

    if (widget.optimizeForPerformance) {
      skeletonWidget = RepaintBoundary(child: skeletonWidget);
    }

    if (widget.clipToBounds) {
      skeletonWidget = ClipRect(child: skeletonWidget);
    }

    return Stack(
      children: [
        if (widget.child != null)
          Opacity(
            opacity: 0.0,
            child: widget.child,
          ),
        Positioned.fill(child: skeletonWidget),
      ],
    );
  }
}

class _SkeletonBonesWidget extends StatelessWidget {
  const _SkeletonBonesWidget({
    required this.bones,
    required this.animationConfig,
    required this.theme,
    required this.optimizeForPerformance,
  });

  final List<Bone> bones;
  final AnimationConfig animationConfig;
  final ThemeData theme;
  final bool optimizeForPerformance;

  @override
  Widget build(BuildContext context) {
    final baseColor = animationConfig.baseColor ??
        (theme.brightness == Brightness.dark
            ? Colors.grey[800]!
            : Colors.grey[300]!);

    return ShimmerWidget(
      config: animationConfig,
      theme: theme,
      child: _BoneLayoutWidget(
        bones: bones,
        optimizeForPerformance: optimizeForPerformance,
        baseColor: baseColor,
      ),
    );
  }
}

class _BoneLayoutWidget extends StatelessWidget {
  const _BoneLayoutWidget({
    required this.bones,
    required this.optimizeForPerformance,
    required this.baseColor,
  });

  final List<Bone> bones;
  final bool optimizeForPerformance;
  final Color baseColor;

  @override
  Widget build(BuildContext context) {
    if (bones.isEmpty) {
      return const SizedBox.shrink();
    }

    // For custom bones, render them in a column
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: bones.map((bone) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: _BoneWidget(
            bone: bone,
            baseColor: baseColor,
          ),
        );
      }).toList(),
    );
  }
}

class _BoneWidget extends StatelessWidget {
  const _BoneWidget({
    required this.bone,
    required this.baseColor,
  });

  final Bone bone;
  final Color baseColor;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(
          bone.width ?? constraints.maxWidth,
          bone.height ?? 20.0,
        );
        return ColorFiltered(
          colorFilter: ColorFilter.mode(
            baseColor,
            BlendMode.srcATop,
          ),
          child: bone.build(context, size),
        );
      },
    );
  }
}

