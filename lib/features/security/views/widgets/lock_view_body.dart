import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_dimensions.dart';
import 'package:money_flow/features/security/view_model/lock_pin_controller.dart';
import 'package:money_flow/features/security/views/lock_view.dart';
import 'package:money_flow/features/security/views/widgets/lock_header.dart';
import 'package:money_flow/features/security/views/widgets/lock_keypad.dart';
import 'package:money_flow/features/security/views/widgets/lock_pin_dots.dart';
import 'package:money_flow/features/security/views/widgets/pin_error_message.dart';

class LockViewBody extends StatelessWidget {
  const LockViewBody({super.key, required this.controller});

  final LockPinController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.viewPadding,
      ),
      child: ListenableBuilder(
        listenable: controller,
        builder: (context, _) => Column(
          children: [
            const SizedBox(height: 80),

            const LockHeader(),

            const SizedBox(height: 32),

            LockPinDots(
              pinLength: LockView.pinLength,
              filledCount: controller.pin.length,
              isError: controller.errorMessage.isNotEmpty,
              shakeAnimation: controller.shakeAnimation,
            ),

            PinErrorMessage(message: controller.errorMessage),

            const Spacer(),

            LockKeypad(
              biometricEnabled: controller.biometricEnabled,
              onDigit: controller.onDigit,
              onBackspace: controller.onBackspace,
              onClear: controller.onClear,
              onBiometric: controller.tryBiometric,
            ),

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
