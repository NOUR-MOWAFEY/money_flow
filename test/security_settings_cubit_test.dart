import 'package:flutter_test/flutter_test.dart';
import 'package:money_flow/features/security/data/services/app_lock_settings_service.dart';
import 'package:money_flow/features/security/data/services/biometric_service.dart';
import 'package:money_flow/features/security/data/services/pin_service.dart';
import 'package:money_flow/features/security/view_model/security_settings_cubit/security_settings_cubit.dart';

class FakePinService extends PinService {
  String? _pin;

  @override
  Future<void> setPin(String pin) async {
    _pin = pin;
  }

  @override
  Future<bool> hasPin() async {
    return _pin != null;
  }

  @override
  Future<bool> verifyPin(String pin) async {
    return _pin == pin;
  }

  @override
  Future<void> clearPin() async {
    _pin = null;
  }
}

class FakeBiometricService extends BiometricService {
  bool isSupported = true;
  bool authSuccess = true;

  @override
  Future<bool> isDeviceSupported() async {
    return isSupported;
  }

  @override
  Future<bool> authenticate() async {
    return authSuccess;
  }
}

class FakeAppLockSettingsService extends AppLockSettingsService {
  bool _lock = false;
  bool _bio = false;

  @override
  bool isAppLockEnabled() => _lock;

  @override
  Future<void> setAppLockEnabled(bool value) async {
    _lock = value;
  }

  @override
  bool isBiometricEnabled() => _bio;

  @override
  Future<void> setBiometricEnabled(bool value) async {
    _bio = value;
  }
}

void main() {
  late FakePinService fakePin;
  late FakeBiometricService fakeBio;
  late FakeAppLockSettingsService fakeSettings;
  late SecuritySettingsCubit cubit;

  setUp(() {
    fakePin = FakePinService();
    fakeBio = FakeBiometricService();
    fakeSettings = FakeAppLockSettingsService();
    cubit = SecuritySettingsCubit(
      pinService: fakePin,
      biometricService: fakeBio,
      settingsService: fakeSettings,
    );
  });

  tearDown(() {
    cubit.close();
  });

  test('Initial state reflects services', () async {
    await cubit.loadSettings();
    expect(cubit.state.isAppLockEnabled, false);
    expect(cubit.state.isBiometricEnabled, false);
    expect(cubit.state.isBiometricSupported, true);
    expect(cubit.state.hasPin, false);
  });

  test('enableAppLock sets PIN and enables app lock', () async {
    await cubit.enableAppLock('123456');

    expect(cubit.state.isAppLockEnabled, true);
    expect(cubit.state.hasPin, true);
    expect(await fakePin.verifyPin('123456'), true);
    expect(await fakePin.verifyPin('654321'), false);
  });

  test('updatePin modifies stored PIN', () async {
    await cubit.enableAppLock('123456');
    await cubit.updatePin('654321');

    expect(await fakePin.verifyPin('654321'), true);
    expect(await fakePin.verifyPin('123456'), false);
  });

  test('disableAppLock clears pin and resets switches', () async {
    await cubit.enableAppLock('123456');
    await cubit.toggleBiometric(true);
    expect(cubit.state.isBiometricEnabled, true);

    await cubit.disableAppLock();
    expect(cubit.state.isAppLockEnabled, false);
    expect(cubit.state.isBiometricEnabled, false);
    expect(cubit.state.hasPin, false);
    expect(await fakePin.hasPin(), false);
  });
}
