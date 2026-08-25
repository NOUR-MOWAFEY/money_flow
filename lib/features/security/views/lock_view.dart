import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/features/security/view_model/app_lock_cubit/app_lock_cubit.dart';
import 'package:money_flow/features/security/view_model/lock_pin_controller.dart';
import 'package:money_flow/features/security/views/widgets/lock_view_body.dart';

class LockView extends StatefulWidget {
  const LockView({super.key});

  static const int pinLength = 6;

  @override
  State<LockView> createState() => _LockViewState();
}

class _LockViewState extends State<LockView>
    with SingleTickerProviderStateMixin {
  late final LockPinController _controller;

  @override
  void initState() {
    super.initState();
    _controller = LockPinController(
      vsync: this,
      pinLength: LockView.pinLength,
      cubit: context.read<AppLockCubit>(),
    );
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _controller.tryBiometric(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: BlocListener<AppLockCubit, AppLockState>(
          listener: (context, state) {
            if (state is AppLockError) _controller.handleError(state.message);
          },

          child: LockViewBody(controller: _controller),
        ),
      ),
    );
  }
}
