import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/services/hive_service.dart';

/// Manages balance visibility / privacy toggle state across the application.
class BalanceVisibilityCubit extends Cubit<bool> {
  final UserStorageService userStorage;

  BalanceVisibilityCubit({UserStorageService? userStorage})
      : userStorage = userStorage ?? HiveService.instance.userStorage,
        super(
          (userStorage ?? HiveService.instance.userStorage).isBalanceHidden,
        );

  /// Toggles visibility and persists user preference.
  Future<void> toggle() async {
    final next = !state;
    emit(next);
    await userStorage.setBalanceHidden(next);
  }
}
