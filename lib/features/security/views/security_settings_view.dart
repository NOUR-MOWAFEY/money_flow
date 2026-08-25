import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/widgets/custom_app_bar.dart';
import 'package:money_flow/features/security/data/services/app_lock_settings_service.dart';
import 'package:money_flow/features/security/data/services/biometric_service.dart';
import 'package:money_flow/features/security/data/services/pin_service.dart';
import 'package:money_flow/features/security/view_model/security_settings_cubit/security_settings_cubit.dart';
import 'package:money_flow/features/security/views/widgets/security_settings_view_body.dart';

class SecuritySettingsView extends StatelessWidget {
  const SecuritySettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SecuritySettingsCubit(
        pinService: PinService(),
        biometricService: BiometricService(),
        settingsService: AppLockSettingsService(),
      ),
      child: const Scaffold(
        appBar: CustomAppBar(title: 'Security'),
        body: SecuritySettingsViewBody(),
      ),
    );
  }
}
