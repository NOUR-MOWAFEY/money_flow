import 'package:flutter/animation.dart';

/// Builds the left-right "shake" animation used to signal a wrong PIN.
Animation<double> buildShakeAnimation(AnimationController controller) {
  return TweenSequence<double>([
    TweenSequenceItem(tween: Tween(begin: 0.0, end: 10.0), weight: 1),
    TweenSequenceItem(tween: Tween(begin: 10.0, end: -10.0), weight: 2),
    TweenSequenceItem(tween: Tween(begin: -10.0, end: 10.0), weight: 2),
    TweenSequenceItem(tween: Tween(begin: 10.0, end: -5.0), weight: 2),
    TweenSequenceItem(tween: Tween(begin: -5.0, end: 0.0), weight: 1),
  ]).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
}
