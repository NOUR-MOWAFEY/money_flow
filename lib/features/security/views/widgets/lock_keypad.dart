import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/features/security/views/widgets/lock_action_button.dart';
import 'package:money_flow/features/security/views/widgets/lock_key_button.dart';

/// Numeric keypad used to enter the PIN, plus the bottom row containing
/// either a biometric or "Clear" action, the 0 digit, and backspace.
class LockKeypad extends StatelessWidget {
  const LockKeypad({
    super.key,
    required this.biometricEnabled,
    required this.onDigit,
    required this.onBackspace,
    required this.onClear,
    required this.onBiometric,
  });

  final bool biometricEnabled;
  final ValueChanged<String> onDigit;
  final VoidCallback onBackspace;
  final VoidCallback onClear;
  final VoidCallback onBiometric;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildRow(['1', '2', '3']),
        const SizedBox(height: 16),
        _buildRow(['4', '5', '6']),
        const SizedBox(height: 16),
        _buildRow(['7', '8', '9']),
        const SizedBox(height: 16),
        _buildBottomRow(),
      ],
    );
  }

  Widget _buildRow(List<String> digits) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: digits
          .map((d) => LockKeyButton(digit: d, onTap: () => onDigit(d)))
          .toList(),
    );
  }

  Widget _buildBottomRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Biometric or Clear button
        if (biometricEnabled)
          LockActionButton(
            icon: Icons.fingerprint_rounded,
            iconSize: 32,
            iconColor: AppColors.primary,
            onTap: onBiometric,
          )
        else
          LockActionButton(label: 'Clear', onTap: onClear),
        // 0 button
        LockKeyButton(digit: '0', onTap: () => onDigit('0')),
        // Backspace button
        LockActionButton(icon: Icons.backspace_outlined, onTap: onBackspace),
      ],
    );
  }
}
