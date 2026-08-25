import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/features/security/data/services/app_lock_settings_service.dart';
import 'package:money_flow/features/security/data/services/biometric_service.dart';
import 'package:money_flow/features/security/data/services/pin_service.dart';

part 'app_lock_state.dart';

class AppLockCubit extends Cubit<AppLockState> {
  AppLockCubit({
    required this.pinService,
    required this.biometricService,
    required this.settingsService,
  }) : super(
          settingsService.isAppLockEnabled()
              ? AppLockLocked()
              : AppLockUnlocked(),
        );

  final PinService pinService;
  final BiometricService biometricService;
  final AppLockSettingsService settingsService;

  bool _isAuthenticatingWithBiometrics = false;
  bool get isAuthenticatingWithBiometrics => _isAuthenticatingWithBiometrics;

  DateTime? _lastUnlockedAt;

  /// Call this from a WidgetsBindingObserver when the app resumes from
  /// the background (didChangeAppLifecycleState -> resumed), so the app
  /// re-locks every time it's reopened.
  void lockIfEnabled() {
    if (_isAuthenticatingWithBiometrics) return;
    if (state is AppLockLocked) return;

    // Safety guard: if unlocked very recently (e.g. from biometric prompt closing), do not re-lock
    if (_lastUnlockedAt != null &&
        DateTime.now().difference(_lastUnlockedAt!).inMilliseconds < 1500) {
      return;
    }

    if (settingsService.isAppLockEnabled()) {
      emit(AppLockLocked());
    }
  }

  /// Attempts biometric unlock.
  Future<void> unlockWithBiometrics() async {
    if (_isAuthenticatingWithBiometrics) return;
    _isAuthenticatingWithBiometrics = true;

    try {
      final success = await biometricService.authenticate();
      if (success) {
        _lastUnlockedAt = DateTime.now();
        emit(AppLockUnlocked());
      }
    } catch (_) {
      // ignore
    } finally {
      // Keep flag true briefly so trailing lifecycle resume events are ignored
      Future.delayed(const Duration(milliseconds: 1000), () {
        _isAuthenticatingWithBiometrics = false;
      });
    }
  }

  /// Attempts PIN unlock — the fallback path, always available.
  Future<void> unlockWithPin(String pin) async {
    final isCorrect = await pinService.verifyPin(pin);
    if (isCorrect) {
      _lastUnlockedAt = DateTime.now();
      emit(AppLockUnlocked());
    } else {
      emit(AppLockError('Incorrect PIN'));
      emit(AppLockLocked());
    }
  }

  /// Used during first-time setup in Settings when the user turns on
  /// App Lock and creates a PIN.
  Future<void> setUpPin(String pin) async {
    await pinService.setPin(pin);
    await settingsService.setAppLockEnabled(true);
  }

  Future<void> changePin(String pin) async {
    await pinService.setPin(pin);
  }

  Future<void> disableAppLock() async {
    await pinService.clearPin();
    await settingsService.setAppLockEnabled(false);
    await settingsService.setBiometricEnabled(false);
    emit(AppLockUnlocked());
  }
}
