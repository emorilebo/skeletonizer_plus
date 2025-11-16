import 'package:flutter/material.dart';
import 'animation/animation_config.dart';
import 'animation/shimmer_widget.dart';
import 'bones/bone.dart';
import 'skeleton_tree_analyzer.dart';

/// Sliver version of SkeletonizerPlus for use in CustomScrollView.
class SliverSkeletonizerPlus extends StatelessWidget {
  /// Creates a SliverSkeletonizerPlus that automatically generates bones from child.
  const SliverSkeletonizerPlus({
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

  /// Creates a SliverSkeletonizerPlus with custom bone layout.
  const SliverSkeletonizerPlus.custom({
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

  /// Creates a SliverSkeletonizerPlus with full animation config.
  const SliverSkeletonizerPlus.withConfig({
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
  Widget build(BuildContext context) {
    if (!enabled) {
      return child ?? const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    final theme = this.theme ?? Theme.of(context);
    final animationConfig = _getAnimationConfig(context);
    final bones = this.bones ?? _generateBones();

    if (bones.isEmpty) {
      return child ?? const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    return SliverToBoxAdapter(
      child: Stack(
        children: [
          if (child != null)
            Opacity(
              opacity: 0.0,
              child: child!,
            ),
          Positioned.fill(
            child: ClipRect(
              child: _SliverSkeletonBonesWidget(
                bones: bones,
                animationConfig: animationConfig,
                theme: theme,
                optimizeForPerformance: optimizeForPerformance,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Bone> _generateBones() {
    if (child != null) {
      return SkeletonTreeAnalyzer.analyzeWidget(child!);
    }
    return [];
  }

  AnimationConfig _getAnimationConfig(BuildContext context) {
    if (animationConfig != null) {
      return animationConfig!;
    }

    return AnimationConfig(
      speed: speed ?? const Duration(milliseconds: 1200),
      baseColor: baseColor,
      highlightColor: highlightColor,
      direction: direction ?? ShimmerDirection.ltr,
      loop: loop ?? true,
      loopCount: loopCount,
    );
  }
}

class _SliverSkeletonBonesWidget extends StatelessWidget {
  const _SliverSkeletonBonesWidget({
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

