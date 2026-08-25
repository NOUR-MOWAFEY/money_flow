import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/features/security/data/services/app_lock_settings_service.dart';
import 'package:money_flow/features/security/data/services/biometric_service.dart';
import 'package:money_flow/features/security/data/services/pin_service.dart';
import 'package:money_flow/features/security/view_model/security_settings_cubit/security_settings_state.dart';

class SecuritySettingsCubit extends Cubit<SecuritySettingsState> {
  SecuritySettingsCubit({
    required this.pinService,
    required this.biometricService,
    required this.settingsService,
  }) : super(const SecuritySettingsState()) {
    loadSettings();
  }

  final PinService pinService;
  final BiometricService biometricService;
  final AppLockSettingsService settingsService;

  Future<void> loadSettings() async {
    emit(state.copyWith(isLoading: true));

    final isLockEnabled = settingsService.isAppLockEnabled();
    final isBioEnabled = settingsService.isBiometricEnabled();
    final isBioSupported = await biometricService.isDeviceSupported();
    final hasPin = await pinService.hasPin();

    emit(
      state.copyWith(
        isAppLockEnabled: isLockEnabled,
        isBiometricEnabled: isBioEnabled,
        isBiometricSupported: isBioSupported,
        hasPin: hasPin,
        isLoading: false,
      ),
    );
  }

  Future<bool> verifyCurrentPin(String pin) async {
    return await pinService.verifyPin(pin);
  }

  Future<void> enableAppLock(String pin) async {
    await pinService.setPin(pin);
    await settingsService.setAppLockEnabled(true);
    await loadSettings();
  }

  Future<void> updatePin(String newPin) async {
    await pinService.setPin(newPin);
    await loadSettings();
  }

  Future<void> disableAppLock() async {
    await pinService.clearPin();
    await settingsService.setAppLockEnabled(false);
    await settingsService.setBiometricEnabled(false);
    await loadSettings();
  }

  Future<bool> toggleBiometric(bool enable) async {
    if (enable) {
      final authenticated = await biometricService.authenticate();
      if (!authenticated) {
        return false;
      }
    }
    await settingsService.setBiometricEnabled(enable);
    await loadSettings();
    return true;
  }
}
