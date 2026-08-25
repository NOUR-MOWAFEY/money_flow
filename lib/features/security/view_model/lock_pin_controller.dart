import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_flow/features/security/data/services/app_lock_settings_service.dart';
import 'package:money_flow/features/security/view_model/app_lock_cubit/app_lock_cubit.dart';

import 'lock_shake_animation.dart';

/// Owns all PIN-entry state and behaviour for the lock screen: the current
/// PIN, error message, biometric flag, and the shake animation used to
/// signal a wrong attempt.
///
/// The view only listens to this and renders — none of the interaction
/// logic lives in the widget itself.
class LockPinController extends ChangeNotifier {
  LockPinController({
    required TickerProvider vsync,
    required this.pinLength,
    required this.cubit,
  }) : _shakeController = AnimationController(
         duration: const Duration(milliseconds: 400),
         vsync: vsync,
       ) {
    _shakeAnimation = buildShakeAnimation(_shakeController);
    biometricEnabled = AppLockSettingsService().isBiometricEnabled();
  }

  final int pinLength;
  final AppLockCubit cubit;

  final AnimationController _shakeController;
  late final Animation<double> _shakeAnimation;
  Animation<double> get shakeAnimation => _shakeAnimation;

  String _pin = '';
  String get pin => _pin;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  late final bool biometricEnabled;

  /// Attempts a biometric unlock, if enabled.
  void tryBiometric() {
    if (biometricEnabled) {
      cubit.unlockWithBiometrics();
    }
  }

  /// Appends [digit] to the PIN and submits once it reaches [pinLength].
  void onDigit(String digit) {
    if (_pin.length >= pinLength) return;

    HapticFeedback.lightImpact();
    _errorMessage = '';
    _pin += digit;
    notifyListeners();

    if (_pin.length == pinLength) {
      cubit.unlockWithPin(_pin);
    }
  }

  void onBackspace() {
    if (_pin.isEmpty) return;
    HapticFeedback.selectionClick();
    _errorMessage = '';
    _pin = _pin.substring(0, _pin.length - 1);
    notifyListeners();
  }

  void onClear() {
    if (_pin.isEmpty) return;
    HapticFeedback.selectionClick();
    _errorMessage = '';
    _pin = '';
    notifyListeners();
  }

  /// Called when the cubit reports a failed unlock attempt: shows the
  /// error, shakes the dots, then clears the PIN.
  void handleError(String message) {
    HapticFeedback.vibrate();
    _errorMessage = message;
    notifyListeners();

    _shakeController.forward(from: 0.0).then((_) {
      Future.delayed(const Duration(milliseconds: 300), () {
        _pin = '';
        _errorMessage = '';
        notifyListeners();
      });
    });
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }
}
