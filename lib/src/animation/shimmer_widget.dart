import 'package:flutter/material.dart';
import 'animation_config.dart';
import 'shimmer_painter.dart';

/// Widget that applies shimmer animation to its child.
class ShimmerWidget extends StatefulWidget {
  const ShimmerWidget({
    required this.child,
    required this.config,
    required this.theme,
    super.key,
  });

  final Widget child;
  final AnimationConfig config;
  final ThemeData theme;

  @override
  State<ShimmerWidget> createState() => _ShimmerWidgetState();
}

class _ShimmerWidgetState extends State<ShimmerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.config.speed,
      vsync: this,
    );

    if (widget.config.loop) {
      _controller.repeat();
    } else {
      _controller.repeat(count: widget.config.loopCount);
    }

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    );
  }

  @override
  void didUpdateWidget(ShimmerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.config.speed != widget.config.speed) {
      _controller.duration = widget.config.speed;
    }
    if (oldWidget.config.loop != widget.config.loop ||
        oldWidget.config.loopCount != widget.config.loopCount) {
      _controller.stop();
      if (widget.config.loop) {
        _controller.repeat();
      } else {
        _controller.repeat(count: widget.config.loopCount);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.config.type == AnimationType.pulse) {
      return AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Opacity(
            opacity: 0.5 + (_animation.value * 0.5), // Fade between 0.5 and 1.0
            child: child,
          );
        },
        child: widget.child,
      );
    }

    return CustomPaint(
      painter: ShimmerPainter(
        animation: _animation,
        config: widget.config,
        theme: widget.theme,
      ),
      child: widget.child,
    );
  }
}


