import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_dimensions.dart';
import 'package:money_flow/features/security/view_model/pin_screen_controller.dart';
import 'package:money_flow/features/security/views/widgets/lock_header.dart';
import 'package:money_flow/features/security/views/widgets/lock_keypad.dart';
import 'package:money_flow/features/security/views/widgets/lock_pin_dots.dart';
import 'package:money_flow/features/security/views/widgets/pin_error_message.dart';

class PinScreenBody extends StatelessWidget {
  const PinScreenBody({super.key, required PinScreenController controller})
    : _controller = controller;

  final PinScreenController _controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.viewPadding,
      ),
      child: ListenableBuilder(
        listenable: _controller,
        builder: (context, _) => Column(
          children: [
            const SizedBox(height: 32),

            LockHeader(
              icon: _controller.stepIcon,
              title: _controller.stepTitle,
              subtitle: _controller.stepSubtitle,
            ),

            const SizedBox(height: 32),

            LockPinDots(
              pinLength: _controller.pinLength,
              filledCount: _controller.enteredPin.length,
              isError: _controller.errorMessage.isNotEmpty,
              shakeAnimation: _controller.shakeAnimation,
            ),

            PinErrorMessage(message: _controller.errorMessage),

            const Spacer(),

            LockKeypad(
              biometricEnabled: false,
              onDigit: _controller.onDigit,
              onBackspace: _controller.onBackspace,
              onClear: _controller.onClear,
              onBiometric: () {},
            ),

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
