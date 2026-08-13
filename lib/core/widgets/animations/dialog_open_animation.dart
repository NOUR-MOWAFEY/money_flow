import 'package:flutter/material.dart';

class DialogOpenAnimation extends StatefulWidget {
  const DialogOpenAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 280),
    this.beginScale = 0.6,
    this.slideOffset = 12.0,
    this.curve = Curves.easeOutBack,
    this.fadeCurve = Curves.easeOut,
    this.controller,
  });

  final Widget child;
  final Duration duration;
  final double beginScale;
  final double slideOffset;
  final Curve curve;
  final Curve fadeCurve;
  final DialogOpenAnimationController? controller;

  @override
  State<DialogOpenAnimation> createState() => _DialogOpenAnimationState();
}

class DialogOpenAnimationController {
  AnimationController? _controller;

  void _attach(AnimationController controller) => _controller = controller;

  Future<void> reverse() async {
    await _controller?.reverse();
  }

  Future<void> forward() async {
    await _controller?.forward();
  }
}

class _DialogOpenAnimationState extends State<DialogOpenAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: widget.duration);
    widget.controller?._attach(_controller);

    _buildAnimations();

    final reduceMotion = WidgetsBinding
        .instance
        .platformDispatcher
        .accessibilityFeatures
        .disableAnimations;
    if (reduceMotion) {
      _controller.value = 1.0;
    } else {
      _controller.forward();
    }
  }

  void _buildAnimations() {
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
    );

    _scaleAnimation = Tween<double>(
      begin: widget.beginScale,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    _slideAnimation =
        Tween<Offset>(
          begin: Offset(0, widget.slideOffset),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.0, 0.9, curve: Curves.easeOutCubic),
          ),
        );
  }

  @override
  void didUpdateWidget(covariant DialogOpenAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.duration != widget.duration) {
      _controller.duration = widget.duration;
    }
    if (oldWidget.beginScale != widget.beginScale ||
        oldWidget.slideOffset != widget.slideOffset ||
        oldWidget.curve != widget.curve) {
      _buildAnimations();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(0, _slideAnimation.value.dy),
            child: Transform.scale(scale: _scaleAnimation.value, child: child),
          ),
        );
      },
    );
  }
}
