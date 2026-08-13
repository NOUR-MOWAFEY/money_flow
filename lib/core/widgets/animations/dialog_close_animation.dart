import 'package:flutter/material.dart';

class DialogCloseAnimation extends StatefulWidget {
  const DialogCloseAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 200),
    this.endScale = 0.85,
    this.slideOffset = 8.0,
    this.curve = Curves.easeIn,
    this.controller,
  });

  final Widget child;
  final Duration duration;
  final double endScale;
  final double slideOffset;
  final Curve curve;
  final DialogCloseAnimationController? controller;

  @override
  State<DialogCloseAnimation> createState() => _DialogCloseAnimationState();
}

class DialogCloseAnimationController {
  AnimationController? _controller;

  void _attach(AnimationController controller) => _controller = controller;

  Future<void> dismiss() async {
    await _controller?.forward();
  }

  Future<void> reset() async {
    await _controller?.reverse();
  }
}

class _DialogCloseAnimationState extends State<DialogCloseAnimation>
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
  }

  void _buildAnimations() {
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ).drive(Tween<double>(begin: 1.0, end: 0.0));

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: widget.endScale,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(0, widget.slideOffset),
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));
  }

  @override
  void didUpdateWidget(covariant DialogCloseAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.duration != widget.duration) {
      _controller.duration = widget.duration;
    }
    if (oldWidget.endScale != widget.endScale ||
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
