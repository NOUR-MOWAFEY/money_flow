import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Stores and verifies the user's PIN. The raw PIN is NEVER stored —
/// only its SHA-256 hash, in the device's encrypted secure storage
/// (Keychain on iOS, Keystore-backed on Android).
class PinService {
  final _storage = const FlutterSecureStorage();
  static const _pinKey = 'app_lock_pin_hash';

  String _hash(String pin) {
    final bytes = utf8.encode(pin);
    return sha256.convert(bytes).toString();
  }

  Future<void> setPin(String pin) async {
    await _storage.write(key: _pinKey, value: _hash(pin));
  }

  Future<bool> hasPin() async {
    final value = await _storage.read(key: _pinKey);
    return value != null;
  }

  Future<bool> verifyPin(String pin) async {
    final stored = await _storage.read(key: _pinKey);
    if (stored == null) return false;
    return stored == _hash(pin);
  }

  Future<void> clearPin() async {
    await _storage.delete(key: _pinKey);
  }
}