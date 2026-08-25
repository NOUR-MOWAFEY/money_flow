part of 'app_lock_cubit.dart';

sealed class AppLockState {}

class AppLockInitial extends AppLockState {}

class AppLockLocked extends AppLockState {}

class AppLockUnlocked extends AppLockState {}

class AppLockError extends AppLockState {
  AppLockError(this.message);
  final String message;
}