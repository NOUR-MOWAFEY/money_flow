import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_flow/features/settings/data/models/user_model.dart';

/// Storage service dedicated to user profile and onboarding settings.
class UserStorageService {
  const UserStorageService();

  static const String boxName = 'user';
  static const String _userModelKey = 'userModel';

  Box get _box => Hive.box(boxName);

  /// Convenience getter for current user.
  UserModel? get currentUser => getUserModel();

  /// Returns true if user hasn't completed onboarding yet.
  bool get isFirstTime => getUserModel()?.isFirstTime ?? true;

  /// Sets the onboarding completion flag.
  Future<void> setIsFirstTime(bool value) async {
    final user = getUserModel();
    if (user != null) {
      user.isFirstTime = value;
      await user.save();
    } else {
      await saveUserModel(UserModel(name: 'User', isFirstTime: value));
    }
  }

  /// Marks onboarding as completed.
  Future<void> setNotFirstTime() async {
    await setIsFirstTime(false);
  }

  /// Persists [UserModel] in Hive.
  Future<void> saveUserModel(UserModel user) async {
    await _box.put(_userModelKey, user);
  }

  /// Returns the current [UserModel], or null if not yet created.
  UserModel? getUserModel() {
    return _box.get(_userModelKey) as UserModel?;
  }

  /// Updates specific fields on the current [UserModel].
  Future<void> updateUserModel({
    String? name,
    String? imagePath,
    String? defaultCurrency,
    bool? isFirstTime,
  }) async {
    final existing = getUserModel();
    if (existing == null) return;
    final updated = existing.copyWith(
      name: name,
      imagePath: imagePath,
      defaultCurrency: defaultCurrency,
      isFirstTime: isFirstTime,
    );
    await saveUserModel(updated);
  }

  /// Real-time stream of user profile changes.
  Stream<BoxEvent> watchUserModel() => _box.watch(key: _userModelKey);

  /// Deletes the current [UserModel].
  Future<void> deleteUserModel() async {
    await _box.delete(_userModelKey);
  }
}
