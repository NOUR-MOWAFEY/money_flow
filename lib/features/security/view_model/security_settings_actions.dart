import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/utils/show_toastification.dart';
import 'package:money_flow/features/security/view_model/security_settings_cubit/security_settings_cubit.dart';
import 'package:money_flow/features/security/view_model/security_settings_cubit/security_settings_state.dart';
import 'package:money_flow/features/security/views/pin_view.dart';

/// Helper class that handles user actions and navigation for the Security Settings screen.
abstract final class SecuritySettingsActions {
  static Future<void> handleAppLockToggle(
    BuildContext context,
    SecuritySettingsState state,
    bool enable,
  ) async {
    final cubit = context.read<SecuritySettingsCubit>();

    if (enable) {
      final pin = await Navigator.of(context, rootNavigator: true).push<String>(
        MaterialPageRoute(
          builder: (context) => const PinView(mode: PinScreenMode.createPin),
        ),
      );

      if (pin != null && pin.length == PinView.pinLength) {
        await cubit.enableAppLock(pin);
        if (context.mounted) {
          ShowToastification.success(context, 'App Lock enabled successfully');
        }
      }
    } else {
      final verifiedPin = await Navigator.of(context, rootNavigator: true)
          .push<String>(
            MaterialPageRoute(
              builder: (context) => const PinView(
                mode: PinScreenMode.verifyPin,
                title: 'Confirm PIN to Disable',
              ),
            ),
          );

      if (verifiedPin != null) {
        await cubit.disableAppLock();
        if (context.mounted) {
          ShowToastification.success(context, 'App Lock disabled');
        }
      }
    }
  }

  static Future<void> handleBiometricToggle(
    BuildContext context,
    SecuritySettingsState state,
    bool enable,
  ) async {
    final cubit = context.read<SecuritySettingsCubit>();
    final success = await cubit.toggleBiometric(enable);

    if (context.mounted) {
      if (success) {
        ShowToastification.success(
          context,
          enable ? 'Biometric unlock enabled' : 'Biometric unlock disabled',
        );
      } else {
        ShowToastification.failure(
          context,
          'Biometric authentication cancelled or unavailable',
        );
      }
    }
  }

  static Future<void> handleChangePin(BuildContext context) async {
    final cubit = context.read<SecuritySettingsCubit>();

    final newPin = await Navigator.of(context, rootNavigator: true)
        .push<String>(
          MaterialPageRoute(
            builder: (context) => const PinView(mode: PinScreenMode.changePin),
          ),
        );

    if (newPin != null && newPin.length == PinView.pinLength) {
      await cubit.updatePin(newPin);
      if (context.mounted) {
        ShowToastification.success(context, 'PIN changed successfully');
      }
    }
  }
}
