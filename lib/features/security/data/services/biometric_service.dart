import 'package:local_auth/local_auth.dart';

/// Thin wrapper around local_auth. Keeps biometric-specific logic in one
/// place so the rest of the app doesn't touch the plugin directly.
class BiometricService {
  final LocalAuthentication _auth = LocalAuthentication();

  /// Whether this device HAS biometric hardware set up (fingerprint/Face ID
  /// enrolled). Use this to decide whether to even show the "Use
  /// Biometric" toggle in Settings.
  Future<bool> isDeviceSupported() async {
    try {
      final canCheck = await _auth.canCheckBiometrics;
      final isSupported = await _auth.isDeviceSupported();
      return canCheck && isSupported;
    } catch (_) {
      return false;
    }
  }

  /// Triggers the native biometric prompt. Returns true only if the user
  /// successfully authenticates.
  Future<bool> authenticate() async {
    try {
      return await _auth.authenticate(
        localizedReason: 'Authenticate to access Money Flow',
        biometricOnly: true,
      );
    } catch (_) {
      return false;
    }
  }
}
