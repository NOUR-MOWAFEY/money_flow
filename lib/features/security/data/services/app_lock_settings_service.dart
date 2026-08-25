import 'package:hive/hive.dart';

/// Simple on/off flags for the lock feature, stored in their own Hive
/// box. Separate from PinService (which stores the actual PIN hash in
/// flutter_secure_storage) since these are just preferences, not
/// sensitive data — no need for OS-level encryption here.
class AppLockSettingsService {
  static const String boxName = 'app_lock_settings';
  static const String _appLockEnabledKey = 'appLockEnabled';
  static const String _biometricEnabledKey = 'biometricEnabled';

  /// Call this once during app startup, alongside your other
  /// Hive.openBox calls (e.g. in HiveService's init/setup).
  static Future<void> init() async {
    await Hive.openBox<bool>(boxName);
  }

  Box<bool> get _box => Hive.box<bool>(boxName);

  bool isAppLockEnabled() {
    return _box.get(_appLockEnabledKey, defaultValue: false)!;
  }

  Future<void> setAppLockEnabled(bool value) async {
    await _box.put(_appLockEnabledKey, value);
  }

  bool isBiometricEnabled() {
    return _box.get(_biometricEnabledKey, defaultValue: false)!;
  }

  Future<void> setBiometricEnabled(bool value) async {
    await _box.put(_biometricEnabledKey, value);
  }
}
