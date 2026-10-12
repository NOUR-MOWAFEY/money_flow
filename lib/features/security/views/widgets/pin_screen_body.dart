import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_dimensions.dart';
import 'package:money_flow/features/security/view_model/pin_screen_controller.dart';
import 'package:money_flow/features/security/views/widgets/lock_header.dart';
import 'package:money_flow/features/security/views/widgets/lock_keypad.dart';
import 'package:money_flow/features/security/views/widgets/lock_pin_dots.dart';
import 'package:money_flow/features/security/views/widgets/pin_error_message.dart';

class PinScreenBody extends StatelessWidget {
  const PinScreenBody({super.key, required this.controller});

  final PinScreenController controller;

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
            const SizedBox(height: 32),

            LockHeader(
              icon: controller.stepIcon,
              title: controller.stepTitle,
              subtitle: controller.stepSubtitle,
            ),

            const SizedBox(height: 32),

            LockPinDots(
              pinLength: controller.pinLength,
              filledCount: controller.enteredPin.length,
              isError: controller.errorMessage.isNotEmpty,
              shakeAnimation: controller.shakeAnimation,
            ),

            PinErrorMessage(message: controller.errorMessage),

            const Spacer(),

            LockKeypad(
              biometricEnabled: false,
              onDigit: controller.onDigit,
              onBackspace: controller.onBackspace,
              onClear: controller.onClear,
              onBiometric: () {},
            ),

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
