import 'package:flutter/material.dart';
import 'package:money_flow/features/security/views/widgets/lock_pin_dot_item.dart';

/// Row of PIN indicator dots. Purely presentational: it reflects how many
/// digits have been entered and whether the current attempt is in an error
/// state, and applies the shake animation driven by the parent.
class LockPinDots extends StatelessWidget {
  const LockPinDots({
    super.key,
    required this.pinLength,
    required this.filledCount,
    required this.isError,
    required this.shakeAnimation,
  });

  final int pinLength;
  final int filledCount;
  final bool isError;
  final Animation<double> shakeAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: shakeAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(shakeAnimation.value, 0),
          child: child,
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(pinLength, (index) {
          return LockPinDotItem(
            isFilled: index < filledCount,
            isError: isError,
          );
        }),
      ),
    );
  }
}
