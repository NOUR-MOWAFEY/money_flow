import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/features/security/view_model/app_lock_cubit/app_lock_cubit.dart';
import 'package:money_flow/features/security/views/lock_view.dart';

/// Wrap your app's root/home widget with this. It watches app lifecycle
/// and re-locks whenever the app comes back from the background, then
/// shows LockView on top until the user authenticates.
///
/// Usage in main.dart (inside MaterialApp's builder, or as `home`):
///   AppLockGate(child: const HomeNavigationShell())
class AppLockGate extends StatelessWidget {
  const AppLockGate({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppLockCubit, AppLockState>(
      builder: (context, state) {
        if (state is! AppLockUnlocked) {
          return const LockView();
        }
        return child;
      },
    );
  }
}
