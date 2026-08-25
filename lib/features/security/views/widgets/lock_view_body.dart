import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_dimensions.dart';
import 'package:money_flow/features/security/view_model/lock_pin_controller.dart';
import 'package:money_flow/features/security/views/lock_view.dart';
import 'package:money_flow/features/security/views/widgets/lock_header.dart';
import 'package:money_flow/features/security/views/widgets/lock_keypad.dart';
import 'package:money_flow/features/security/views/widgets/lock_pin_dots.dart';
import 'package:money_flow/features/security/views/widgets/pin_error_message.dart';

class LockViewBody extends StatelessWidget {
  const LockViewBody({super.key, required LockPinController controller})
    : _controller = controller;

  final LockPinController _controller;

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
            const SizedBox(height: 80),

            const LockHeader(),

            const SizedBox(height: 32),

            LockPinDots(
              pinLength: LockView.pinLength,
              filledCount: _controller.pin.length,
              isError: _controller.errorMessage.isNotEmpty,
              shakeAnimation: _controller.shakeAnimation,
            ),

            PinErrorMessage(message: _controller.errorMessage),

            const Spacer(),

            LockKeypad(
              biometricEnabled: _controller.biometricEnabled,
              onDigit: _controller.onDigit,
              onBackspace: _controller.onBackspace,
              onClear: _controller.onClear,
              onBiometric: _controller.tryBiometric,
            ),

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
